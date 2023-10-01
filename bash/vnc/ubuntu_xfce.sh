#!/bin/sh

sudo apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
sudo apt-get install -y gnome-core xfce4 firefox vnc4server
sudo apt-get install -y xubuntu-desktop
mkdir -p ~/.vnc
cp xstartup_xfce /home/ubuntu/.vnc/xstartup
vncserver
vncserver -kill :1
vncserver -geometry 2304x1440 # 1440x900 also works

