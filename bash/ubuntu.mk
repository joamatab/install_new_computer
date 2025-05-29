help:
	@echo 'make install: Install awesome ubuntu software (recommended)'
	@echo 'make basic:   Installs only basic ubuntu software'
	@echo 'make gui:     Installs light desktop x-environment for GUI servers'
	@echo 'make desktop: Installs software for ubuntu super desktop'

update:
	sudo apt update

upgrade:
	sudo apt upgrade -y

install: update
	git config --global core.editor "vim"
	sudo apt install -y --ignore-missing \
		build-essential \
		curl \
		fish \
		g++ \
		gcc \
		golang-go \
		git \
		htop \
		kdiff3 \
		libxft-dev \
		lua5.3 \
		make \
		neovim \
		nodejs \
		openssh-client \
		python3 \
		python3-pip \
		python3-dev \
		python3-pytest \
		python3-venv \
		rsync \
		ripgrep \
		software-properties-common \
		tmux \
		wget \
		xclip \
		xvfb \
		zlib1g-dev

software2:
	sudo apt install -y \
		dwm \
		ruby \
		ruby-dev \
		silversearcher-ag \
		python-logilab-common

gui: xfce vnc_xfce_setup
	@echo "GUI environment with VNC has been set up successfully!"
	@echo "XFCE desktop environment is installed"
	@echo "VNC server is running on port 5901"
	@echo "Connect using VNC viewer to: <your-server-ip>:5901"
	@echo "Running additional setup scripts..."
	sh efs_ubuntu.sh
	sh s3.sh

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
		vinagre \
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


extra:
	sudo apt install -y terminator \
		nodejs


/usr/bin/nvim:
	# sudo add-apt-repository ppa:neovim-ppa/stable
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt-get update
	sudo apt-get install -y neovim


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
	wget -O 'klayout.deb' 'https://www.klayout.org/downloads/Ubuntu-18/klayout_0.26.4-1_amd64.deb'

klayout: klayout.deb
	sudo dpkg -i klayout.deb

vnc:
	sudo apt-get install -y tightvncserver
	# Stop any existing VNC servers
	vncserver -kill :1 || true
	# Create VNC directory and setup xstartup
	mkdir -p $(HOME)/.vnc
	cp vnc/xstartup_ldxe $(HOME)/.vnc/xstartup
	chmod +x $(HOME)/.vnc/xstartup
	# Set up VNC password (you'll be prompted)
	@echo "Please set VNC password when prompted:"
	vncpasswd
	# Start VNC once to initialize
	vncserver -geometry 2304x1440 :1
	vncserver -kill :1
	# Setup systemd service
	sudo cp vnc/vncserver_1.service.ubuntu /etc/systemd/system/vncserver@.service
	sudo systemctl daemon-reload
	sudo systemctl enable vncserver@1
	sudo systemctl start vncserver@1
	@echo "VNC server started on :1 (port 5901)"
	@echo "You can connect using: <your-server-ip>:5901"

vncj:
	sudo apt-get install -y tightvncserver
	sudo cp vnc/vncserver_1.service.ubuntu /etc/systemd/system/vncserver@.service
	sudo systemctl daemon-reload
	vncserver -geometry 2304x1440
	vncserver -kill :1
	mkdir -p $(HOME)/.vnc
	cp vnc/xstartup_dwm $(HOME)/.vnc/xstartup
	vncserver -geometry 2304x1440

vnc1:
	sudo apt-get install -y tightvncserver
	sudo cp vnc/vncserver@:1.service.ubuntu /etc/systemd/system/vncserver@.service
	sudo systemctl daemon-reload
	vncserver -geometry 2304x1440
	vncserver -kill :1
	mkdir -p ~/.vnc
	cp vnc/xstartup_ldxe ~/.vnc/xstartup
	vncserver -geometry 2304x1440

vnc0:
	sudo apt-get install -y tightvncserver
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

xfce:
	sudo apt-get install -y xfce4 xfce4-goodies
	# Don't start display manager automatically since we're using VNC
	sudo systemctl disable lightdm || true
	sudo systemctl disable gdm3 || true
	@echo "XFCE desktop environment installed"
	@echo "Use with VNC for remote desktop access"

ldxe:
	sudo apt-get install -y lxde-core lxde-common
	# Don't start lightdm automatically since we're using VNC
	sudo systemctl disable lightdm || true
	@echo "LXDE desktop environment installed"
	@echo "Use with VNC for remote desktop access"

vnc_ldxe:
	sudo apt-get install -y tightvncserver

vnc_xfce:
	sudo apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
	sudo apt-get install -y gnome-core xfce4 firefox tightvncserver
	sudo apt-get install -y xubuntu-desktop
	mkdir -p ~/.vnc
	cp xstartup /home/ubuntu/.vnc/xstartup
	vncserver
	vncserver -kill :1
	vncserver -geometry 2304x1440 # 1440x900 also works

xrdp:
	sudo apt install -y xrdp
	sudo passwd ubuntu

vnc_xfce_setup:
	sudo apt-get install -y tightvncserver
	# Stop any existing VNC servers
	vncserver -kill :1 || true
	# Create VNC directory and setup xstartup for XFCE
	mkdir -p $(HOME)/.vnc
	cp vnc/xstartup_xfce $(HOME)/.vnc/xstartup
	chmod +x $(HOME)/.vnc/xstartup
	# Set up VNC password (you'll be prompted)
	@echo "Please set VNC password when prompted:"
	vncpasswd
	# Start VNC once to initialize
	vncserver -geometry 2304x1440 :1
	vncserver -kill :1
	# Setup systemd service
	sudo cp vnc/vncserver_1.service.ubuntu /etc/systemd/system/vncserver@.service
	sudo systemctl daemon-reload
	sudo systemctl enable vncserver@1
	sudo systemctl start vncserver@1
	@echo "VNC server started on :1 (port 5901) with XFCE"
	@echo "You can connect using: <your-server-ip>:5901"

.PHONY: install docker photonics vim brew pip software config fish colors anaconda2 iterm tmux ipkiss3 lumerical dotfiles vnc nodejs klayout xfce vnc_xfce_setup
