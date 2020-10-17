help:
	@echo 'make install: Install awesome software (recommended)'


install:
	sudo timedatectl set-timezone America/Los_Angeles
	git config --global core.editor "vim"
	sudo apt install -y \
		build-essential \
		cmake \
		curl \
		ctags \
		fish \
		g++ \
		gcc \
		golang-go \
		git \
		htop \
		kitty \
		libqt4-dev \
		libqt4-dev-bin \
		libxft-dev \
		make \
		neovim \
		nodejs \
		python3 \
		python3-pip \
		python3-venv \
		ripgrep \
		rsync \
		ruby \
		ruby-dev \
		silversearcher-ag \
		tmux \
		wget \
		xclip \
		yarn \
		zlib1g-dev

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
		i3 \
		i3status \
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
