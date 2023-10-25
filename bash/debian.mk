help:
	@echo 'make install: Install awesome software (recommended)'

install:
	git config --global core.editor "vim"
	sudo apt install -y --ignore-missing \
		build-essential \
		cmake \
		curl \
		dwm \
		fish \
		g++ \
		gcc \
		golang-go \
		git \
		git-lfs \
		htop \
		kitty \
		kdiff3 \
		libxft-dev \
		lua5.1 \
		libx11-dev \
		make \
		neovim \
		nodejs \
		xz-utils \
		ripgrep \
		rsync \
		ruby \
		ruby-dev \
		tmux \
		wget \
		xclip \
		sxhkd \
		yarn \
		zlib1g-dev
sway:
	sudo apt install sway waybar kanshi light alsa-utils slurp grim swaylock wl-clipboard wofi wtype mako-notifier -y

gui:
	sudo apt install -y \
		git \
		libatk1.0-dev \
		libbonoboui2-dev \
		libcairo2-dev \
		libgnome2-dev \
		libgnomeui-dev \
		libgtk2.0-dev \
		libncurses5-dev \
		libx11-dev \
		libxpm-dev \
		libxt-dev python-dev \
		python3-dev
	yarn add prettier --dev --exact

update:
	sudo apt update
	sudo apt upgrade -y

software2:
	sudo apt install -y \
		python-logilab-common

desktop:
	sudo apt install -y \
		flameshot \
		glances \
		htop \
		jq \
		keepassxc \
		libreoffice \
		openssh-server \
		pgcli \
		remmina \
		scrot \
		sxhkd \
		sxiv \
		xcape \
		youtube-dl \
		vinagre \
		zathura \
	    redshift

desktop2:
	sudo apt install -y \
		postgresql \
		gimp \
		chromium-browser \
		maim \
		s3fs \
		openvpn \
		gnome-tweak-tool


.PHONY: install docker photonics vim brew pip software config fish colors anaconda2 iterm tmux ipkiss3 lumerical dotfiles vnc nodejs klayout
