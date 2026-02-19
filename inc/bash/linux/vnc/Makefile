
ubuntu:
	sudo apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
	sudo apt-get install -y gnome-core xfce4 firefox vnc4server
	sudo apt-get install -y xubuntu-desktop

restart:
	vncserver
	vncserver -kill :1
	vncserver -geometry 2304x1440 # 1440x900 also works

i3:
	cp xstartup_i3 $(HOME)/.vnc/xstartup

dwm:
	cp xstartup_dwm $(HOME)/.vnc/xstartup

ldxe:
	cp xstartup_ldxe $(HOME)/.vnc/xstartup

xfce:
	cp xstartup_xfce $(HOME)/.vnc/xstartup

ubuntu-client:
	sudo apt-get install xtightvncviewer
