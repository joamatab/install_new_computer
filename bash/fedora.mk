install: software

help:
	@echo 'make install: Install awesome fedora software (recommended)'
	@echo 'make basic:   Installs only basic fedora software'
	@echo 'make rdp:     Installs and configures RDP server for remote desktop access'
	@echo 'make x2go:    Installs and configures X2Go server for high-performance remote desktop'
	@echo 'make chrome_rdp: Installs and configures Chrome Remote Desktop'

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

rdp:
	sudo dnf install -y xrdp xorgxrdp
	sudo systemctl enable xrdp
	sudo systemctl start xrdp
	sudo firewall-cmd --permanent --add-port=3389/tcp
	sudo firewall-cmd --reload
	@echo "RDP server has been installed and started"
	@echo "Connect using RDP client to: <your-server-ip>:3389"
	@echo "Use your system username and password to login"
	@echo "Note: You may need to set a password with 'sudo passwd <username>'"

x2go:
	# X2Go is available in official Fedora repos since Fedora 19
	sudo dnf install -y x2goserver x2goserver-xsession
	sudo systemctl enable sshd
	sudo systemctl start sshd
	# Configure firewall if firewalld is available
	sudo dnf install -y firewalld || true
	sudo systemctl enable firewalld || true
	sudo systemctl start firewalld || true
	sudo firewall-cmd --permanent --add-service=ssh || true
	sudo firewall-cmd --reload || true
	@echo "X2Go server has been installed and started"
	@echo "Connect using X2Go client to: <your-server-ip>:22"
	@echo "Use your system username and password to login"
	@echo "Session type: Select your desktop environment (GNOME, KDE, XFCE, etc.)"
	@echo "Download X2Go client from: https://wiki.x2go.org/doku.php/download:start"
	@echo "Note: If firewall is disabled, ensure SSH port 22 is accessible"

chrome_rdp:
	# Install Google Chrome repository and Chrome browser
	sudo dnf install -y dnf-plugins-core
	sudo dnf config-manager --set-enabled google-chrome
	wget -O /tmp/google-chrome.repo https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm || \
	{ sudo dnf config-manager --add-repo https://dl.google.com/linux/chrome/rpm/stable/x86_64/google-chrome.repo; \
	  sudo dnf install -y google-chrome-stable; }
	# Install Chrome Remote Desktop
	wget -O /tmp/chrome-remote-desktop.rpm https://dl.google.com/linux/direct/chrome-remote-desktop_current_x86_64.rpm
	sudo dnf install -y /tmp/chrome-remote-desktop.rpm
	# Configure Chrome Remote Desktop service
	sudo systemctl enable chrome-remote-desktop@$(whoami).service
	# Configure firewall for Chrome Remote Desktop
	sudo dnf install -y firewalld || true
	sudo systemctl enable firewalld || true
	sudo systemctl start firewalld || true
	sudo firewall-cmd --permanent --add-port=22/tcp || true
	sudo firewall-cmd --reload || true
	@echo "Chrome Remote Desktop has been installed"
	@echo "Setup steps:"
	@echo "1. Open Google Chrome and go to: https://remotedesktop.google.com/headless"
	@echo "2. Sign in to your Google account"
	@echo "3. Click 'Set up via SSH' and follow the instructions"
	@echo "4. Run the command provided by Google to complete setup"
	@echo "5. You can then access this computer from https://remotedesktop.google.com"
	@echo "Note: You may need to install a desktop environment if running headless"

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


.PHONY: docker extra rdp x2go chrome_rdp
