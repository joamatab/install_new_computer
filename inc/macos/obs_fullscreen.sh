#!/bin/sh
# Configure OBS screen capture to fill the full canvas

OBS_SCENES="$HOME/Library/Application Support/obs-studio/basic/scenes/Untitled.json"

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
import json, sys, subprocess

path = sys.argv[1]
with open(path) as f:
    data = json.load(f)

canvas_w = data.get('resolution', {}).get('x', 1920)
canvas_h = data.get('resolution', {}).get('y', 1080)

# Get actual display resolution via system_profiler
try:
    out = subprocess.check_output(
        ['system_profiler', 'SPDisplaysDataType'], text=True
    )
    for line in out.splitlines():
        if 'Resolution' in line and 'Retina' in line:
            # e.g. '3024 x 1964 Retina'
            parts = line.split(':')[1].strip().split()
            src_w = int(parts[0])
            src_h = int(parts[2])
            print(f'Detected display: {src_w}x{src_h}')
            break
    else:
        src_w, src_h = 3024, 1964
        print(f'Could not detect display, assuming {src_w}x{src_h}')
except Exception:
    src_w, src_h = 3024, 1964
    print(f'Could not detect display, assuming {src_w}x{src_h}')

# Uniform scale to fill canvas (crop overflow)
scale = max(canvas_w / src_w, canvas_h / src_h)
scaled_w = src_w * scale
scaled_h = src_h * scale
# Center the overflow
offset_x = -(scaled_w - canvas_w) / 2
offset_y = -(scaled_h - canvas_h) / 2

for source in data.get('sources', []):
    if source.get('id') != 'scene':
        continue
    for item in source.get('settings', {}).get('items', []):
        item['bounds_type'] = 0
        item['scale'] = {'x': scale, 'y': scale}
        item['pos'] = {'x': offset_x, 'y': offset_y}
        item['crop_left'] = 0
        item['crop_top'] = 0
        item['crop_right'] = 0
        item['crop_bottom'] = 0
        print(f'Set \"{item[\"name\"]}\" scale={scale:.6f} pos=({offset_x:.1f}, {offset_y:.1f})')

with open(path, 'w') as f:
    json.dump(data, f, indent=4)

print('OBS scene updated successfully.')
" "$OBS_SCENES"
