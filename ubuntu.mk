help:
	@echo 'make install: Install awesome ubuntu software (reccommended)'
	@echo 'make basic:   Installs only basic ubuntu software'
	@echo 'make gui:     Installs light desktop x-environment for GUI servers'
	@echo 'make desktop: Installs software for ubuntu super desktop'

install: software yarn vim 

update:
	sudo apt update
	sudo apt upgrade -y

software: update
	sudo timedatectl set-timezone America/Los_Angeles
	git config --global core.editor "vim"
	sudo apt install -y \
		build-essential \
		curl \
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
		python \
		python-pip \
		python3 \
		python3-pip \
		python3-pytest \
		python3-venv \
		rsync \
		ruby \
		ruby-dev \
		silversearcher-ag \
		software-properties-common \
		tmux \
		wget \
		xclip \
		xvfb \
		yarn \
		zlib1g-dev 
	yarn add prettier --dev --exact

software2:
	sudo apt install -y \
		python-logilab-common 

gui: full ldxe klayout vnc
	sh efs_ubuntu.sh
	sh s3.sh

desktop: 
	sudo apt install -y \
		glances \
		htop \
		i3 \
		i3status \
		flameshot \
		jq \
		libreoffice \
		keepassxc \
		openssh-server \
		pgcli \
		scrot \
		sxhkd \
		sxiv \
		xcape \
		youtube-dl \
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

cyberduck:
	echo -e "deb https://s3.amazonaws.com/repo.deb.cyberduck.io stable main" | sudo tee /etc/apt/sources.list.d/cyberduck.list > /dev/null
	sudo apt-get update
	sudo apt-get install duck

x2goserver:
	sudo add-apt-repository ppa:x2go/stable
	sudo apt-get update
	sudo apt-get install -y x2goserver x2goserver-xsession

nextcloud:
	sudo add-apt-repository ppa:nextcloud-devs/client
	sudo apt-get update
	sudo apt install -y nextcloud-client

node:
	curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
	sudo apt-get install -y nodejs npm

yarn:
	curl -o- -L https://yarnpkg.com/install.sh | bash


extra:
	sudo apt install -y terminator \
		nodejs 


/usr/bin/nvim:
	# sudo add-apt-repository ppa:neovim-ppa/stable
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt-get update
	sudo apt-get install -y neovim

vim: 
	./vim.sh

add-repos:
	sudo add-apt-repository -y ppa:neovim-ppa/stable
	sudo apt-add-repository -y ppa:fish-shell/release-2
	sudo apt-get update

/usr/bin/fish:
	sudo apt install -y fish
	echo "/usr/bin/fish" | sudo tee -a /etc/shells

fish: /usr/bin/fish
	chsh -s /usr/bin/fish
	curl -L https://get.oh-my.fish | fish

pipenv:
	sudo apt install software-properties-common python-software-properties
	sudo add-apt-repository ppa:pypa/ppa
	sudo apt update
	sudo apt install pipenv

python37:
	sudo apt-get install software-properties-common
	sudo add-apt-repository ppa:deadsnakes/ppa
	sudo apt-get update
	sudo apt-get install python3.7

docker:
	wget -qO- https://get.docker.com/ | sh 
	sudo usermod -aG docker $(USER) 

klayout.deb:
	wget -O 'klayout.deb' 'https://www.klayout.org/downloads/Ubuntu-18/klayout_0.26.3-1_amd64.deb'

klayout: klayout.deb
	sudo dpkg -i klayout.deb

vnc:
	sudo apt-get install -y  vnc4server 
	vncserver -geometry 2304x1440
	vncserver -kill :1
	mkdir -p $(HOME)/.vnc
	cp vnc/xstartup_ldxe $(HOME)/.vnc/xstartup
	sudo cp vnc/vncserver@:1.service.ubuntu /etc/systemd/system/vncserver@.service
	sudo systemctl daemon-reload
	sudo systemctl enable --now vncserver@1

vncj:
	sudo apt-get install -y  vnc4server 
	sudo cp vnc/vncserver@:1.service.ubuntu /etc/systemd/system/vncserver@.service
	sudo systemctl daemon-reload
	vncserver -geometry 2304x1440
	vncserver -kill :1
	mkdir -p $(HOME)/.vnc
	cp vnc/xstartup_dwm $(HOME)/.vnc/xstartup
	vncserver -geometry 2304x1440

vnc1:
	sudo apt-get install -y  vnc4server 
	sudo cp vnc/vncserver@:1.service.ubuntu /etc/systemd/system/vncserver@.service
	sudo systemctl daemon-reload
	vncserver -geometry 2304x1440
	vncserver -kill :1
	mkdir -p ~/.vnc
	cp vnc/xstartup_ldxe ~/.vnc/xstartup
	vncserver -geometry 2304x1440

vnc0:
	sudo apt-get install -y  vnc4server tightvncserver
	# vncserver -geometry 2304x1440
	# vncserver -kill :1
	mkdir -p $(HOME)/.vnc
	cp vnc/xstartup_ldxe $(HOME)/.vnc/xstartup
	vncserver -geometry 2304x1440
	sudo cp software/vnc/vncserver@:1.service.ubuntu vncserver@:1.service
	sudo cp software/vnc/vncserver@:1.service /etc/systemd/system/vncserver@.service
	sudo systemctl daemon-reload
	sudo systemctl enable vncserver@:1.service
	vncserver -kill :1
	sudo systemctl start vncserver@:1.service
	sudo systemctl status vncserver@1

ldxe:
	sudo apt-get install -y lxde
	sudo service lightdm start
	# sudo start lxdm # for ubuntu18

vnc_ldxe:
	sudo apt-get install -y  vnc4server

vnc_xfce:
	sudo apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
	sudo apt-get install -y gnome-core xfce4 firefox vnc4server
	sudo apt-get install -y xubuntu-desktop
	mkdir -p ~/.vnc
	cp xstartup /home/ubuntu/.vnc/xstartup
	vncserver
	vncserver -kill :1
	vncserver -geometry 2304x1440 # 1440x900 also works

xrdp:
	sudo apt install -y xrdp
	sudo passwd ubuntu

.PHONY: install docker photonics vim brew pip software config fish colors anaconda2 iterm tmux ipkiss3 lumerical dotfiles vnc nodejs klayout
