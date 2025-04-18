install:
	git config --global core.editor "vim"
	sudo pacman -Sy --noconfirm \
		alacritty \
		bat \
		bottom \
		broot \
		curl \
		cmus \
		dust \
		firefox \
		fish \
		flameshot \
		gcc \
		git \
		git-lfs \
		go \
		htop \
		kitty \
		lsd \
		libxcrypt-compat \
		nsxiv \
		make \
		mcfly \
		neovim \
		npm \
		ntp \
		procs \
		redshift \
		ripgrep \
		rsync \
		ruby \
		s3fs \
		tmux \
		trash-cli \
		tealdeer \
		time \
		unzip \
		wget \
		wireless_tools \
		xcape \
		xorg-xbacklight  \
		xclip \
		zoxide \
		yarn
	yarn add prettier

desktop:
	sudo pacman -Sy --noconfirm \
		docker \
		gparted \
		github-cli \
		keepassxc \
		libreoffice \
		redshift \
		rofi \
		transmission-gtk \
		sxhkd
	yay -S mons --noconfirm lf-git
	yay -S klayout --noconfirm lf-git
	yay -S ultrastartdx-git --noconfirm lf-git

rust:
	sudo pacman -Sy --noconfirm mcfly ripgrep tokei sd hyperfine du-dust dutree mcfly skim alacritty
	cargo install fastmod

useful:
	yay -S --noconfirm lf-git

update:
	sudo pacman-mirrors --fasttrack && sudo pacman -Syyu
	sudo pacman -Syyu --noconfirm

bspwm:
	sudo pacman -Sy --noconfirm \
		libxcb \
		polybar \
		xcb-util \
		xcb-util-wm \
		xcb-util-keysyms \
		xdo

extra:
	yay -S googler
	yay -S aur/mons
	# yaourt -G klayout
	sudo pacman -Sy --noconfirm \
		nextcloud-client \
		nodejs \
		the_silver_searcher \
		npm \
		i3 \
		qutebrowser \
		openscad \
		onlyoffice

mons:
	pacaur -S mons


vim: /usr/bin/nvim
	sudo npm install -g neovim
	curl -fLo $(HOME)/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	curl -fLo $(HOME)/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	mkdir -p $(HOME)/.config/nvim
	ln -sf $(HOME)/.vimrc $(HOME)/.config/nvim/init.vim
	sudo gem install neovim

docker:
	sudo pacman -Sy --noconfirm \
		docker
	sudo systemctl start docker
	sudo systemctl enable docker
	sudo usermod -aG docker $(USER)

lts:
	sudo pacman -Sy --noconfirm \
		lts \
		linux-lts-headers
	sudo grub-mkconfig -o /boot/grub/grub.cfg

cinnamon:
	sudo pacman -Sy --noconfirm \
		cinnamon \
		cinnamon-wallpapers cinnamon-sounds gnome-terminal parcellite

xfce:
	sudo pacman -Sy --noconfirm \
		xfce4-gtk3 xfce4-goodies xfce4-terminal network-manager-applet xfce4-notifyd-gtk3 xfce4-whiskermenu-plugin-gtk3 tumbler engrampa

kde:
	sudo pacman -Sy --noconfirm \
	plasma kio-extras
	kdebase

davmail:
	yay davmail

vbox:
	sudo pacman -Sy --noconfirm \
		virtualbox \
		linux-rt-lts-manjaro-virtualbox-host-modules

.PHONY: install nodejs rust
