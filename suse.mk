install: software 

help:
	@echo 'make install: Install awesome ubuntu software (reccommended)'
	@echo 'make basic:   Installs only basic ubuntu software'

software: 
	sudo zypper install -y \
		chromium \
		fish \
		golang-bin \
		gparted \
		htop \
		neovim \
		redshift \
		tmux \
		xcape \
		setxkbmap \
		cargo \
		qutebrowser \
		util-linux-user \
		kitty


docker:
	./docker.sh

i3:
	sudo zypper install -y i3

gnome: sudo zypper install dconf-editor

desktop: 
	sudo zypper install -y \
		bpython \
		dwm \
		gimp \
		gnome-tweak-tool \
		dconf-editor \
		htop \
		ipython \
		jq \
		openvpn \
		postgresql  \
		redshift \
		sxhkd \
		youtube-dl \
		zathura  
