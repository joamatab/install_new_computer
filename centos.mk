help:
	@echo 'make install:      Install centos software'

gui: install vnc
cloudbox: gui klayout lumerical
	sudo yum install -y chromium i3

git:
	sudo yum install -y http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-2.noarch.rpm
	sudo yum install -y git

vnc:
	sudo yum -y update
	sudo yum -y install tigervnc-server xorg-x11-fonts-Type1 Xvfb
	sudo yum -y groupinstall "Xfce"
	sudo yum -y install epel-release
	sudo yum -y install bash-completion
	sudo cp vnc/vncserver@:1.service.centos vncserver@:1.service
	sudo cp vnc/vncserver@:1.service /etc/systemd/system/vncserver@:1.service
	vncserver
	sudo systemctl daemon-reload
	sudo systemctl start vncserver@:1.service
	sudo systemctl enable vncserver@:1.service
	mkdir -p $(HOME)/.vnc
	cp vnc/xstartup_xfce $(HOME)/.vnc/xstartup
	sudo systemctl daemon-reload
	sudo systemctl set-default graphical.target

vnc_extra:
	vncserver -geometry 2304x1440
	# vncserver -kill :1
	vncserver -geometry 2304x1440

vnc2:
	yum -y install x11vnc
	x11vnc -storepasswd
	x11vnc --reopen --forever -rfbauth $(HOME)/vncpasswd &

vnc-restart:
	x11vnc --reopen --forever -rfbauth $(HOME)/vncpasswd &


x2go:
	sudo yum install -y x2goserver x2goserver-xsession


cyberduck:
	echo -e "[duck-stable]\nname=duck-stable\nbaseurl=https://repo.cyberduck.io/stable/\$basearch/\nenabled=1\ngpgcheck=0" | sudo tee /etc/yum.repos.d/duck-stable.repo
	sudo yum install duck

ripgrep:
	sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
	sudo yum install -y ripgrep

update:
	sudo yum update -y
	sudo yum upgrade -y

install: update
	sudo yum groupinstall -y "Development tools"
	sudo yum install -y epel-release
	sudo yum install -y s3fs-fuse
	sudo yum install -y \
		bzip2 \
		fish \
		g++ \
		gcc \
		go \
		htop \
		libqt4-dev \
		libqt4-dev-bin \
		libz-dev \
		make \
		neovim \
		nodejs \
		npm \
		ruby \
		ruby-dev \
		tmux \
		wget \
		xclip \
		xorg-x11-server-Xvfb

nodejs:
	curl –sL https://rpm.nodesource.com/setup_12.x | sudo bash -
	sudo yum install –y nodejs

python3:
	sudo yum -y install https://centos7.iuscommunity.org/ius-release.rpm
	sudo yum -y install python36u

python3dev:
	sudo yum install -y \
		python3 \
		python3-dev \
		python3-pip \


cool:
	pip install ranger-fm neovim
	sudo npm install -g neovim
	sudo gem install neovim
	pip2 install neovim --user


nx:
	sudo yum install freenx-server nxagent

nxaddrepo:
	sudo yum install -y freenx-server nxagent
	sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
	sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el6/x86_64/nux-dextop-release-0-2.el6.nux.noarch.rpm

vim:
	sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	sudo yum install -y neovim python3-neovim

vim2:
	curl -fLo $(HOME)/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	sudo yum install -y nodejs-legacy
	sudo yum install -y nodejs
	sudo yum install -y npm
	sudo yum install -y neovim
	sudo yum install -y python-dev python-pip python3-dev python3-pip
	sudo yum install -y ruby-dev
	gem install neovim
	npm install -g neovim

ldxe:
	sudo yum install -y lxde

xrdp:
	sudo yum install -y xrdp
	sudo passwd centos

fish:
	sudo passwd $(USER)
	chsh -s /usr/bin/fish
	curl -L https://get.oh-my.fish | fish

pycharm.tar.gz:
	# wget -O "pycharm.tar.gz"  "https://www.jetbrains.com/pycharm/download/download-thanks.html?platform=linux&code=PCC"
	wget -O "pycharm.tar.gz" https://download-cf.jetbrains.com/python/pycharm-professional-2018.3.2.tar.gz

pycharm: pycharm.tar.gz
	sudo tar xvfz pycharm.tar.gz
	sudo /opt/pycharm-community-2021.1/bin/pycharm.sh

pipenv:
	sudo yum install software-properties-common python-software-properties
	sudo add-yum-repository ppa:pypa/ppa
	sudo yum update
	sudo yum install pipenv

python37:
	sudo yum install software-properties-common
	sudo add repository ppa:deadsnakes/ppa
	sudo yum update
	sudo yum install python3.7

docker-io:
	sudo yum install -y docker.io
	sudo yum install -y docker docker-compose
	sudo usermod -aG docker ${USER}

docker:
	wget -qO- https://get.docker.com/ | sh
	sudo usermod -aG docker $(USER)

klayout.rpm:
	wget -O 'klayout.rpm' https://www.klayout.org/downloads/CentOS_7/klayout-0.25.8-0.x86_64.rpm

klayout: klayout.rpm
	sudo yum install klayout.rpm -y


.PHONY: lumerical install photonics vim brew pip software config fish colors anaconda2 klayout iterm tmux lumerical vnc nodejs
