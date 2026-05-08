#!/bin/bash
# inspired in github.com/donnemartin/dev-setup
# Ubuntu/Debian equivalent of new_mac.sh

script_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $script_home/lib_sh/echos.sh

###############################################################################
# Section selector
###############################################################################
SECTIONS=$(whiptail --title "Ubuntu Setup" --checklist \
  "Select sections to install (space to toggle, enter to confirm):" 20 70 7 \
  "build"     "Build essentials"          ON \
  "defaults"  "System defaults (GNOME)"   ON \
  "cli"       "CLI packages (apt)"        ON \
  "external"  "External CLI packages"     ON \
  "gui"       "GUI desktop apps"          OFF \
  "setup"     "Setup scripts (fish, ssh, dotfiles, vim, git)" ON \
  3>&1 1>&2 2>&3) || exit 0

has_section() { echo "$SECTIONS" | grep -q "\"$1\""; }

###############################################################################
# Build essentials (equivalent of Xcode Command Line Tools)
###############################################################################
if has_section build; then
  if dpkg -s build-essential &>/dev/null; then
    echo "==> Build essentials already installed."
  else
    echo "==> Installing build essentials..."
    sudo apt update
    sudo apt install -y build-essential curl git wget software-properties-common \
      apt-transport-https ca-certificates gnupg lsb-release
  fi
fi

if has_section defaults; then
echo "==> Configuring Ubuntu defaults (GNOME, keyboard, etc.)..."

###############################################################################
# Keyboard & Input
###############################################################################

running "Disable natural (reversed) scrolling direction"
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false 2>/dev/null;ok

running "Set key repeat rate to fastest"
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 15 2>/dev/null;ok

running "Set initial key repeat delay to shortest"
gsettings set org.gnome.desktop.peripherals.keyboard delay 150 2>/dev/null;ok

###############################################################################
# Dock & Desktop
###############################################################################

running "Set Dock icon size to 36 pixels"
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 36 2>/dev/null;ok

running "Auto-hide the Dock"
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false 2>/dev/null;ok

running "Set Dock hide delay to 0"
gsettings set org.gnome.shell.extensions.dash-to-dock hide-delay 0 2>/dev/null;ok

running "Minimize on click"
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize' 2>/dev/null;ok

running "Clear pinned apps from Dock"
gsettings set org.gnome.shell favorite-apps "[]" 2>/dev/null;ok

###############################################################################
# File Manager (Nautilus)
###############################################################################

running "Show hidden files in file manager"
gsettings set org.gnome.nautilus.preferences show-hidden-files true 2>/dev/null;ok

fi # end defaults

###############################################################################
# Install CLI packages (equivalent of brew.sh)
###############################################################################
if has_section cli; then

echo "==> Installing CLI packages via apt..."

sudo apt update

for i in \
  automake \
  bat \
  curl \
  fd-find \
  fish \
  fzf \
  gawk \
  gh \
  git-lfs \
  golang-go \
  htop \
  hyperfine \
  mpv \
  neovim \
  nodejs \
  npm \
  postgresql \
  ripgrep \
  shellcheck \
  tmux \
  tree \
  vim \
  wget \
  xclip \
  yarn \
  zoxide \
  ;
do
  running "apt install $i"
  if dpkg -s $i &>/dev/null; then
    ok "already installed"
  else
    sudo apt install -y $i
    ok
  fi
done

fi # end cli

###############################################################################
# Packages not in default apt repos (install via other methods)
###############################################################################
if has_section external; then

echo "==> Installing packages from external sources..."

# eza (modern ls)
if ! command -v eza &>/dev/null; then
  running "Installing eza"
  sudo mkdir -p /etc/apt/keyrings
  wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
  echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
  sudo apt update && sudo apt install -y eza
  ok
fi

# lazygit
if ! command -v lazygit &>/dev/null; then
  running "Installing lazygit"
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  sudo tar xf /tmp/lazygit.tar.gz -C /usr/local/bin lazygit
  rm /tmp/lazygit.tar.gz
  ok
fi

# lf file manager
if ! command -v lf &>/dev/null; then
  running "Installing lf"
  curl -Lo /tmp/lf.tar.gz "https://github.com/gokcehan/lf/releases/latest/download/lf-linux-amd64.tar.gz"
  sudo tar xf /tmp/lf.tar.gz -C /usr/local/bin
  rm /tmp/lf.tar.gz
  ok
fi

# atuin (shell history)
if ! command -v atuin &>/dev/null; then
  running "Installing atuin"
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
  ok
fi

# delta (git pager)
if ! command -v delta &>/dev/null; then
  running "Installing git-delta"
  DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
  curl -Lo /tmp/delta.deb "https://github.com/dandavison/delta/releases/latest/download/git-delta_${DELTA_VERSION}_amd64.deb"
  sudo dpkg -i /tmp/delta.deb
  rm /tmp/delta.deb
  ok
fi

# dust (disk usage)
if ! command -v dust &>/dev/null; then
  running "Installing dust"
  DUST_VERSION=$(curl -s "https://api.github.com/repos/bootandy/dust/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo /tmp/dust.deb "https://github.com/bootandy/dust/releases/latest/download/du-dust_${DUST_VERSION}-1_amd64.deb"
  sudo dpkg -i /tmp/dust.deb
  rm /tmp/dust.deb
  ok
fi

# bottom (system monitor)
if ! command -v btm &>/dev/null; then
  running "Installing bottom"
  BOTTOM_VERSION=$(curl -s "https://api.github.com/repos/ClementTsang/bottom/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
  curl -Lo /tmp/bottom.deb "https://github.com/ClementTsang/bottom/releases/latest/download/bottom_${BOTTOM_VERSION}-1_amd64.deb"
  sudo dpkg -i /tmp/bottom.deb
  rm /tmp/bottom.deb
  ok
fi

# sd (sed alternative)
if ! command -v sd &>/dev/null; then
  running "Installing sd"
  cargo install sd 2>/dev/null || echo "    (install cargo first or install sd manually)"
  ok
fi

# tokei (code stats)
if ! command -v tokei &>/dev/null; then
  running "Installing tokei"
  cargo install tokei 2>/dev/null || echo "    (install cargo first or install tokei manually)"
  ok
fi

# zellij (terminal multiplexer)
if ! command -v zellij &>/dev/null; then
  running "Installing zellij"
  curl -Lo /tmp/zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz"
  sudo tar xf /tmp/zellij.tar.gz -C /usr/local/bin
  rm /tmp/zellij.tar.gz
  ok
fi

fi # end external

###############################################################################
# GUI apps (equivalent of brew_cask.sh)
###############################################################################
if has_section gui; then

echo "==> Installing desktop apps..."

# Snap packages
for i in \
  firefox \
  obs-studio \
  ;
do
  running "snap install $i"
  if snap list $i &>/dev/null 2>&1; then
    ok "already installed"
  else
    sudo snap install $i
    ok
  fi
done

# Flameshot
if ! command -v flameshot &>/dev/null; then
  running "Installing flameshot"
  sudo apt install -y flameshot
  ok
fi

# VS Code
if ! command -v code &>/dev/null; then
  running "Installing VS Code"
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 /tmp/packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
  sudo apt update && sudo apt install -y code
  rm /tmp/packages.microsoft.gpg
  ok
fi

# Google Chrome
if ! command -v google-chrome &>/dev/null; then
  running "Installing Google Chrome"
  wget -qO /tmp/chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
  sudo dpkg -i /tmp/chrome.deb
  sudo apt install -f -y
  rm /tmp/chrome.deb
  ok
fi

# Ghostty
if ! command -v ghostty &>/dev/null; then
  running "Installing Ghostty"
  sudo add-apt-repository -y ppa:ghostty/ppa 2>/dev/null
  sudo apt update && sudo apt install -y ghostty 2>/dev/null || echo "    (Ghostty PPA may not be available yet — install manually)"
  ok
fi

# Neovide
if ! command -v neovide &>/dev/null; then
  running "Installing Neovide"
  cargo install --git https://github.com/neovide/neovide 2>/dev/null || echo "    (install cargo first or install neovide manually)"
  ok
fi

# Zed
if ! command -v zed &>/dev/null; then
  running "Installing Zed"
  curl -f https://zed.dev/install.sh | sh
  ok
fi

echo "==> Done! Desktop apps installed."

fi # end gui

###############################################################################
# Run shared setup scripts
###############################################################################
if has_section setup; then

bash $script_home/fish.sh
bash $script_home/ssh_create_key.sh
bash $script_home/dotfiles.sh
bash $script_home/vim.sh
bash $script_home/git_config.sh

fi # end setup
