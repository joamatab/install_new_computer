#!/bin/sh

mkdir -p ~/.vnc
cp xstartup_dwm ~/.vnc/xstartup
vncserver
vncserver -kill :1
vncserver -geometry 2304x1440 # 1440x900 also works
