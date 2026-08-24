#!/bin/bash

script_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$script_home/lib_sh/echos.sh"
source "$script_home/lib_sh/requirers.sh"

echo "==> Installing Homebrew and core packages..."

################################
# install brew
################################
running "checking homebrew install"
brew_bin=$(which brew) 2>&1 > /dev/null
if [[ $? != 0 ]]; then
  if dseditgroup -o checkmember -m "$(whoami)" admin &>/dev/null; then
    # Admin user: standard install to /opt/homebrew
    action "installing homebrew (admin)"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ $? != 0 ]]; then
      error "unable to install homebrew, script $0 abort!"
      exit 2
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    # Non-admin user: install to home directory
    action "installing homebrew in home directory (no admin required)"
    HOMEBREW_PREFIX="$HOME/.homebrew"
    mkdir -p "$HOMEBREW_PREFIX"
    curl -fsSL https://github.com/Homebrew/brew/tarball/master | tar xz --strip-components 1 -C "$HOMEBREW_PREFIX"
    if [[ $? != 0 ]]; then
      error "unable to install homebrew to $HOMEBREW_PREFIX, script $0 abort!"
      exit 2
    fi
    eval "$("$HOMEBREW_PREFIX/bin/brew" shellenv)"
    action "adding homebrew shellenv to shell profiles"
    BREW_SHELLENV="eval \"\$(${HOMEBREW_PREFIX}/bin/brew shellenv)\""
    # Add to bash profile
    if ! grep -qF "$HOMEBREW_PREFIX/bin/brew shellenv" "$HOME/.profile" 2>/dev/null; then
      echo "$BREW_SHELLENV" >> "$HOME/.profile"
    fi
    # Add to zsh profile
    if ! grep -qF "$HOMEBREW_PREFIX/bin/brew shellenv" "$HOME/.zprofile" 2>/dev/null; then
      echo "$BREW_SHELLENV" >> "$HOME/.zprofile"
    fi
  fi
else
  ok
  # Make sure we’re using the latest Homebrew
  # running "updating homebrew"
  # brew update
  # ok
fi

################################
# Basic software
################################

for i in \
  ag \
  atuin \
  autojump \
  automake \
  awk \
  bash \
  bat \
  bottom \
  copilot-cli \
  dust \
  eza \
  fastmod \
  fd \
  fish \
  fzf \
  gh \
  gemini-cli \
  git-delta \
  git-lfs \
  go \
  htop \
  hyperfine \
  lazygit \
  lf \
  lsd \
  m-cli \
  mcfly \
  mpv \
  neovim \
  node \
  ollama \
  postgres \
  ripgrep \
  s-search \
  s3fs \
  sd \
  shellcheck \
  skim \
  tmux \
  tokei \
  tree \
  vim \
  weechat \
  wget \
  yarn \
  zoxide \
  zellij \
  ;
do
  require_brew $i
done

# for i in \
#   chatgpt \
#   ghostty \
#   flameshot \
#   # granola \
#   # google-drive \
#   ;
# do
#   bin=$(which $i) 2>&1 > /dev/null
#   if [[ $? != 0 ]]; then
#     echo brew install $i
#     brew install $i
#   fi
# done

# for i in \
#   autoenv \
#   chafa \
#   font-dejavusansmono-nerd-font \
#   font-fantasque-sans-mono \
#   font-fira-code \
#   font-firacode-nerd-font \
#   font-firacode-nerd-font-mono \
#   font-iosevka \
#   font-iosevka-nerd-font \
#   font-sourcecodepro-nerd-font \
#   geos \
#   googler \
#   howdoi \
#   locate \
#   mas \
#   neomutt \
#   ;
# do
#   bin=$(which $i) 2>&1 > /dev/null
#   if [[ $? != 0 ]]; then
#     echo brew install $i
#     brew install $i
#   fi
# done

echo "==> Done! Homebrew packages installed."
