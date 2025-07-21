help:
	@echo 'make install: Install awesome Rocky Linux software (recommended)'
	@echo 'make basic:   Installs only basic Rocky Linux software'
	@echo 'make gui:     Installs light desktop x-environment for GUI servers'
	@echo 'make desktop: Installs software for Rocky Linux super desktop'

update:
	sudo dnf update

upgrade:
	sudo dnf upgrade -y

install: update
	git config --global core.editor "vim"
	sudo dnf install -y \
		@development-tools \
		curl \
		fish \
		golang \
		git \
		htop \
		kdiff3 \
		libXft-devel \
		lua \
		make \
		neovim \
		nodejs \
		openssh-clients \
		python3 \
		python3-pip \
		python3-devel \
		python3-pytest \
		python3-virtualenv \
		rsync \
		ripgrep \
		tmux \
		wget \
		xclip \
		xorg-x11-server-Xvfb \
		zlib-devel

software2:
	sudo dnf install -y \
		dwm \
		ruby \
		ruby-devel \
		the_silver_searcher \
		python3-logilab-common

gui: ldxe vnc
	sh efs_rocky.sh
	sh s3.sh

desktop:
	sudo dnf install -y \
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
		yt-dlp \
		zathura \
		redshift

desktop2:
	sudo dnf install -y \
		postgresql-server \
		gimp \
		chromium \
		maim \
		s3fs-fuse \
		openvpn \
		gnome-tweaks

x2goserver:
	sudo dnf install -y epel-release
	sudo dnf install -y x2goserver x2goserver-xsession

nextcloud:
	sudo dnf install -y epel-release
	sudo dnf install -y nextcloud-client

node:
	curl -sL https://rpm.nodesource.com/setup_18.x | sudo bash -
	sudo dnf install -y nodejs

extra:
	sudo dnf install -y terminator \
		nodejs

/usr/bin/nvim:
	sudo dnf install -y epel-release
	sudo dnf install -y neovim

add-repos:
	sudo dnf install -y epel-release
	sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/shells:fish:release:3/RHEL_9/shells:fish:release:3.repo
	sudo dnf update

/usr/bin/fish:
	sudo dnf install -y fish
	echo "/usr/bin/fish" | sudo tee -a /etc/shells

fish: /usr/bin/fish
	chsh -s /usr/bin/fish
	curl -L https://get.oh-my.fish | fish

pipenv:
	sudo dnf install -y python3-pip
	pip3 install --user pipenv

python37:
	sudo dnf install -y python3.7

docker:
	sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
	sudo dnf install -y docker-ce docker-ce-cli containerd.io
	sudo systemctl enable --now docker
	sudo usermod -aG docker $(USER)

klayout.rpm:
	wget -O 'klayout.rpm' 'https://www.klayout.org/downloads/CentOS_7/klayout-0.28.6-1.x86_64.rpm'

klayout: klayout.rpm
	sudo dnf install -y klayout.rpm

vnc:
	sudo dnf install -y tigervnc-server
	vncserver -geometry 2304x1440
	vncserver -kill :1
	mkdir -p $(HOME)/.vnc
	cp vnc/xstartup_ldxe $(HOME)/.vnc/xstartup
	sudo cp vnc/vncserver_1.service.rocky /etc/systemd/system/vncserver@.service
	sudo systemctl daemon-reload
	sudo systemctl enable --now vncserver@1

vncj:
	sudo dnf install -y tigervnc-server
	sudo cp vnc/vncserver_1.service.rocky /etc/systemd/system/vncserver@.service
	sudo systemctl daemon-reload
	vncserver -geometry 2304x1440
	vncserver -kill :1
	mkdir -p $(HOME)/.vnc
	cp vnc/xstartup_dwm $(HOME)/.vnc/xstartup
	vncserver -geometry 2304x1440

ldxe:
	sudo dnf install -y @lxde-desktop
	sudo systemctl set-default graphical.target
	sudo systemctl start lightdm

vnc_ldxe:
	sudo dnf install -y tigervnc-server

vnc_xfce:
	sudo dnf install -y @xfce-desktop
	mkdir -p ~/.vnc
	cp xstartup /home/rocky/.vnc/xstartup
	vncserver
	vncserver -kill :1
	vncserver -geometry 2304x1440

xrdp:
	sudo dnf install -y epel-release
	sudo dnf install -y xrdp
	sudo systemctl enable --now xrdp
	sudo passwd rocky

.PHONY: install docker photonics vim brew pip software config fish colors anaconda2 iterm tmux ipkiss3 lumerical dotfiles vnc nodejs klayout
