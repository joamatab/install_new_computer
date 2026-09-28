#!/bin/bash
# inspired in github.com/donnemartin/dev-setup

script_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$script_home/lib_sh/echos.sh"
source "$script_home/lib_sh/requirers.sh"

# Reuse sudo's cached authorization throughout long package installations.
echo "==> Checking administrator authorization..."
if ! sudo -v; then
  echo "ERROR: Administrator authorization is required to continue."
  exit 1
fi

(
  sudo_sleep_pid=
  trap 'if [ -n "$sudo_sleep_pid" ]; then kill "$sudo_sleep_pid" 2>/dev/null; wait "$sudo_sleep_pid" 2>/dev/null; fi' EXIT
  trap 'exit' INT TERM
  while kill -0 "$$" 2>/dev/null; do
    sudo -n -v || exit
    sleep 60 &
    sudo_sleep_pid=$!
    wait "$sudo_sleep_pid"
    sudo_sleep_pid=
  done
) &
sudo_keepalive_pid=$!
trap 'kill "$sudo_keepalive_pid" 2>/dev/null; wait "$sudo_keepalive_pid" 2>/dev/null' EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

###############################################################################
# Xcode Command Line Tools (silent install, no popup)
###############################################################################
if ! xcode-select -p &>/dev/null; then
  echo "==> Installing Xcode Command Line Tools..."
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  CLT_PKG=$(softwareupdate --list 2>/dev/null | grep -o ".*Command Line Tools.*" | grep -v "^\\*" | sed 's/^[[:space:]]*//' | sort -V | tail -1)
  if [ -n "$CLT_PKG" ]; then
    softwareupdate --install "$CLT_PKG" --verbose
  else
    echo "ERROR: Could not find Command Line Tools package. Run 'xcode-select --install' manually."
  fi
  rm -f /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
else
  echo "==> Xcode Command Line Tools already installed."
fi

echo "==> Configuring macOS defaults (Dock, Finder, iTerm2)..."

###############################################################################
# Gatekeeper & App Security
###############################################################################

running "Allow apps from App Store and identified developers (disable Gatekeeper)"
sudo spctl --master-disable;ok

running "Disable quarantine prompt for downloaded apps"
defaults write com.apple.LaunchServices LSQuarantine -bool false;ok

running "Disable natural (reversed) scrolling direction"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false;ok

running "Set key repeat rate to fastest"
defaults write NSGlobalDomain KeyRepeat -int 1;ok

running "Set initial key repeat delay to shortest"
defaults write NSGlobalDomain InitialKeyRepeat -int 10;ok

# running "Disable the crash reporter"
# defaults write com.apple.CrashReporter DialogType -string "none";ok
# running "Avoid creating .DS_Store files on network volumes"
# defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true;ok

###############################################################################
# "Dock & Dashboard"
###############################################################################

running "Remove the auto-hiding Dock delay"
defaults write com.apple.dock autohide-delay -float 0;ok

running "Remove the animation when hiding/showing the Dock"
defaults write com.apple.dock autohide-time-modifier -float 0;ok

running "Set the icon size of Dock items to 36 pixels"
defaults write com.apple.dock tilesize -int 36;ok

running "Change minimize/maximize window effect to scale"
defaults write com.apple.dock mineffect -string "scale";ok

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don't use
# the Dock to launch apps.

defaults write com.apple.dock persistent-apps -array
killall Dock

defaults write com.apple.finder AppleShowAllFiles TRUE

###############################################################################
# Iterm2
###############################################################################
running "Don't display the annoying prompt when quitting iTerm"
defaults write com.googlecode.iterm2 PromptOnQuit -bool false;ok
running "hide tab title bars"
defaults write com.googlecode.iterm2 HideTab -bool true;ok
running "hide pane titles in split panes"
defaults write com.googlecode.iterm2 ShowPaneTitles -bool false;ok

# running "set system-wide hotkey to show/hide iterm with ^\`"
# defaults write com.googlecode.iterm2 Hotkey -bool true;ok

echo "==> Done! macOS defaults configured."

for setup_step in brew brew_cask fish ssh_create_key dotfiles vim git_config; do
  echo "==> Running ${setup_step}.sh..."
  if ! bash "$script_home/${setup_step}.sh"; then
    echo "ERROR: ${setup_step}.sh failed. Fix the error above before continuing."
    exit 1
  fi
  if [ "$setup_step" = brew ]; then
    # brew.sh runs in a child shell; import its new installation into this one.
    brew_bin=$(command -v brew || true)
    if [ -z "$brew_bin" ]; then
      for candidate in "$HOME/.homebrew/bin/brew" /opt/homebrew/bin/brew /usr/local/bin/brew; do
        if [ -x "$candidate" ]; then
          brew_bin=$candidate
          break
        fi
      done
    fi
    if [ -n "$brew_bin" ]; then
      if ! brew_environment=$("$brew_bin" shellenv); then
        echo "ERROR: Could not load the Homebrew environment."
        exit 1
      fi
      eval "$brew_environment"
    fi
  fi
done

echo "==> Done! Mac setup completed."
