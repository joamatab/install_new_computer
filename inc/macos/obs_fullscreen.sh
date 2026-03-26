#!/bin/sh
# Configure OBS screen capture to fill the full canvas

OBS_SCENES="$HOME/Library/Application Support/obs-studio/basic/scenes/Untitled.json"
OBS_PROFILE="$HOME/Library/Application Support/obs-studio/basic/profiles/Untitled/basic.ini"

if [ ! -f "$OBS_SCENES" ]; then
    echo "OBS scene file not found. Make sure OBS is installed and has been run at least once."
    exit 1
fi

# Close OBS if running (config changes require restart)
if pgrep -x "OBS" > /dev/null; then
    echo "OBS is running. Please close it first so config changes take effect."
    exit 1
fi

python3 -c "
import json, sys, re

scene_path = sys.argv[1]
profile_path = sys.argv[2]

with open(scene_path) as f:
    data = json.load(f)

# OBS uses these formulas to compute actual values from _rel values:
#   scale = scale_rel * canvas_h / scale_ref.y
#   pos   = pos_rel * (canvas_h / 2) + (canvas_w / 2, canvas_h / 2)
#   bounds = bounds_rel * (canvas_h / 2)
#
# We want: canvas=1920x1080, source fit to canvas using bounds (Fit to Screen)

canvas_w = 1920
canvas_h = 1080
half_h = canvas_h / 2.0

data['resolution'] = {'x': canvas_w, 'y': canvas_h}

for source in data.get('sources', []):
    if source.get('id') != 'scene':
        continue
    for item in source.get('settings', {}).get('items', []):
        ref = item.get('scale_ref', {})
        src_w = ref.get('x', 1512)
        src_h = ref.get('y', 982)

        # bounds_type 2 = Scale to inner bounds (Fit to Screen)
        item['bounds_type'] = 2
        item['bounds_align'] = 0

        # bounds = canvas size, bounds_rel = bounds / half_h
        item['bounds'] = {'x': float(canvas_w), 'y': float(canvas_h)}
        item['bounds_rel'] = {'x': canvas_w / half_h, 'y': canvas_h / half_h}

        # scale 1:1 (bounds will override visual size)
        item['scale'] = {'x': 1.0, 'y': 1.0}
        item['scale_rel'] = {'x': src_h / canvas_h, 'y': src_h / canvas_h}

        # pos = (0, 0), compute matching pos_rel
        item['pos'] = {'x': 0.0, 'y': 0.0}
        item['pos_rel'] = {'x': -(canvas_w / 2.0) / half_h, 'y': -1.0}

        item['crop_left'] = 0
        item['crop_top'] = 0
        item['crop_right'] = 0
        item['crop_bottom'] = 0

        print(f'Set \"{item[\"name\"]}\" to fit {canvas_w}x{canvas_h} canvas (bounds mode)')

with open(scene_path, 'w') as f:
    json.dump(data, f, indent=4)

# Update profile basic.ini
with open(profile_path) as f:
    ini = f.read()

ini = re.sub(r'^BaseCX=.*$', f'BaseCX={canvas_w}', ini, flags=re.MULTILINE)
ini = re.sub(r'^BaseCY=.*$', f'BaseCY={canvas_h}', ini, flags=re.MULTILINE)
ini = re.sub(r'^OutputCX=.*$', f'OutputCX={canvas_w}', ini, flags=re.MULTILINE)
ini = re.sub(r'^OutputCY=.*$', f'OutputCY={canvas_h}', ini, flags=re.MULTILINE)

with open(profile_path, 'w') as f:
    f.write(ini)

print(f'Profile set to {canvas_w}x{canvas_h}')
print('Done. Open OBS to verify.')
" "$OBS_SCENES" "$OBS_PROFILE"
