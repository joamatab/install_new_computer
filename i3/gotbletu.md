# Config for ~/.i3/config

From Video : http://www.youtube.com/watch?v=yAq_Enj_d2Q

Should you change your keyboard layout somewhen, delete
this file and re-run i3-config-wizard(1).
i3 config file (v4)
Please see http://i3wm.org/docs/userguide.html for a complete reference!
Mod4 = Super key
Mod1 = Alt key

```
set $mod Mod4
```

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below. ISO 10646 = Unicode
font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, if you need a lot of unicode glyphs or
# right-to-left text rendering, you should instead use pango for rendering and
# chose a FreeType font, such as:
# font pango:DejaVu Sans Mono 10

``` bash
# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
bindsym $mod+Return exec i3-sensible-terminal

# kill focused window
# bindsym $mod+Shift+q kill
bindsym $mod+c kill

# start dmenu (a program launcher)
bindsym $mod+d exec dmenu_run
# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed.
# bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

# j4-dmenu-desktop -- A faster replacement for i3-dmenu-desktop
# https://github.com/enkore/j4-dmenu-desktop
# https://aur.archlinux.org/packages/j4-dmenu-desktop-git/
# bindsym $mod+space exec --no-startup-id j4-dmenu-desktop
bindsym $mod+space exec --no-startup-id j4-dmenu-desktop --dmenu="dmenu -i -fn 'DejaVu Sans-10' -l 20"

# change focus

```bash
bindsym $mod+j focus left
bindsym $mod+k focus down
bindsym $mod+l focus up
bindsym $mod+semicolon focus right
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right
```

```bash
# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window (Super+Alt+vimkeys)
# bindsym $mod+Shift+j move left
# bindsym $mod+Shift+k move down
# bindsym $mod+Shift+l move up
# bindsym $mod+Shift+semicolon move right
bindsym $mod+mod1+h move left
bindsym $mod+mod1+j move down
bindsym $mod+mod1+k move up
bindsym $mod+mod1+l move right

# alternatively, you can use the cursor keys:
# bindsym $mod+Shift+Left move left
# bindsym $mod+Shift+Down move down
# bindsym $mod+Shift+Up move up
# bindsym $mod+Shift+Right move right
bindsym $mod+mod1+Left move left
bindsym $mod+mod1+Down move down
bindsym $mod+mod1+Up move up
bindsym $mod+mod1+Right move right

# i3 has it in reverse; h = vertical ; v = horizontal
# split in horizontal orientation
# bindsym $mod+h split h
bindsym $mod+b split v

# split in vertical orientation
# bindsym $mod+v split v
bindsym $mod+v split h

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
# bindsym $mod+Shift+space floating toggle
bindsym $mod+mod1+space floating toggle

# change focus between tiling / floating windows
# bindsym $mod+space focus mode_toggle
 # bindsym $mod+d focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindsym $mod+d focus child

# switch to workspace
# https://github.com/redhat69/dotfiles/blob/master/.i3/config
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8: manga
bindsym $mod+9 workspace 9: web
bindsym $mod+0 workspace 10: main

# move focused container to workspace
# bindsym $mod+Shift+1 move container to workspace 1
# bindsym $mod+Shift+2 move container to workspace 2
# bindsym $mod+Shift+3 move container to workspace 3
# bindsym $mod+Shift+4 move container to workspace 4
# bindsym $mod+Shift+5 move container to workspace 5
# bindsym $mod+Shift+6 move container to workspace 6
# bindsym $mod+Shift+7 move container to workspace 7
# bindsym $mod+Shift+8 move container to workspace 8
# bindsym $mod+Shift+9 move container to workspace 9
# bindsym $mod+Shift+0 move container to workspace 10
bindsym $mod+mod1+1 move container to workspace 1
bindsym $mod+mod1+2 move container to workspace 2
bindsym $mod+mod1+3 move container to workspace 3
bindsym $mod+mod1+4 move container to workspace 4
bindsym $mod+mod1+5 move container to workspace 5
bindsym $mod+mod1+6 move container to workspace 6
bindsym $mod+mod1+7 move container to workspace 7
bindsym $mod+mod1+8 move container to workspace 8: manga
bindsym $mod+mod1+9 move container to workspace 9: web
bindsym $mod+mod1+0 move container to workspace 10: main

# reload the configuration file
# bindsym $mod+Shift+c reload
bindsym $mod+mod1+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
# bindsym $mod+Shift+r restart
bindsym $mod+mod1+r restart
# exit i3 (logs you out of your X session)
# bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"
bindsym $mod+mod1+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        # bindsym j resize shrink width 10 px or 10 ppt
        # bindsym k resize grow height 10 px or 10 ppt
        # bindsym l resize shrink height 10 px or 10 ppt
        # bindsym semicolon resize grow width 10 px or 10 ppt
        bindsym h resize shrink width 10 px or 10 ppt
        bindsym j resize grow height 10 px or 10 ppt
        bindsym k resize shrink height 10 px or 10 ppt
        bindsym l resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
        status_command i3status
}


# My stuff

# auto enable floating mode
# class is usually 1st letter Capitalize and everything else lowercase
# use 'xprop' or 'xwininfo' to get window information
# for_window [class="(?i)dolphin"] floating enable
for_window [class="Guake"] floating enable
for_window [class="Screenkey"] floating enable
for_window [class="Xfce4-notifyd"] floating enable

# assign program to specific workspace
assign [class="Mcomix"] 8: manga
assign [class="Calibre"] 8: manga


# sound control
# https://faq.i3wm.org/question/125/how-to-change-the-systems-volume/?answer=249#post-id-249
bindsym XF86AudioRaiseVolume exec amixer -q set Master 5%+ -q
bindsym XF86AudioLowerVolume exec amixer -q set Master 5%- -q
bindsym XF86AudioMute exec amixer -q set Master toggle
# https://github.com/redhat69/dotfiles/blob/master/.i3/config
# toggle pause cmus music player
bindsym XF86AudioPlay exec cmus-remote -u

bindsym XF86HomePage exec chromium http://youtube.com
bindsym XF86Mail exec chromium https://mail.google.com

# switching between workspace
# http://i3wm.org/docs/userguide.html#_changing_named_workspaces_moving_to_workspaces
bindsym $mod+n workspace next
bindsym $mod+p workspace prev
bindsym $mod+mod1+n move container to workspace next
bindsym $mod+mod1+p move container to workspace prev
bindsym $mod+d workspace back_and_forth

# autostart apps
# http://i3wm.org/docs/userguide.html#_automatically_starting_applications_on_i3_startup
exec xmodmap ~/.Xmodmap
exec xcompmgr
exec ~/.scripts/feh-wallpaper-changer.sh
exec parcellite
exec sleep 3 && guake
# credit @SardemFF7 from #i3 irc
# exec i3-msg 'workspace 9: web; exec chromium; workspace back_and_forth'
exec i3-msg 'workspace 9: web; exec chromium'


# Colors
# https://github.com/Gravemind/ArchLinux/blob/master/.i3/config
# class                 border  backgr. text    indicator
# client.focused          #000000 #285577 #dddddd #0099ff
# client.focused_inactive #000000 #333333 #888888 #484e50
# client.unfocused        #000000 #000000 #555555 #292d2e
# client.urgent           #2f343a #900000 #ffffff #900000

# Def
# client.focused          #4c7899 #285577 #ffffff #2e9ef4
# client.focused_inactive #333333 #5f676a #ffffff #484e50
# client.unfocused        #333333 #222222 #888888 #292d2e
# client.urgent           #2f343a #900000 #ffffff #900000

# Todo list
# i3bar status
# timeout suspend system
# Assign apps to workspace https://github.com/jmazzi/dotfiles/blob/master/.i3/config
# better resize
```
