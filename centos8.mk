help:
	@echo 'make install:      Install centos software'

update:
	sudo yum update -y
	sudo yum upgrade -y

install: update
	sudo yum groupinstall -y "Development tools"
	sudo yum install -y epel-release
	sudo yum install -y \
		bzip2 \
		fish \
		gcc \
		go \
		htop \
		make \
		neovim \
		nodejs \
		npm \
		ruby \
		tmux \
		tmux \
		wget \
		xclip \
		xorg-x11-server-Xvfb
