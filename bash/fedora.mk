install: software

help:
	@echo 'make install: Install awesome ubuntu software (recommended)'
	@echo 'make basic:   Installs only basic ubuntu software'

software:
	sudo dnf install -y \
		cargo \
		chromium \
		fish \
		golang-bin \
		gparted \
		htop \
		neovim \
		openssh-server \
		redshift \
		setxkbmap \
		tmux \
		util-linux-user \
		kitty

vncserver:
	sudo yum install -y tigervnc-server xterm i3
	mkdir -p $(HOME)/.vnc
	echo 'i3 &' > $(HOME)/.vnc/xstartup


docker:
	./docker.sh

i3:
	sudo dnf install -y i3

gnome: sudo dnf install dconf-editor

desktop:
	sudo dnf install -y \
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

extra:
	sudo dnf install -y \
		maim \
		qutebrowser \
		vifm


.PHONY: docker extra
