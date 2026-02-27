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
  # Homebrew installer requires admin privileges
  if ! dseditgroup -o checkmember -m "$(whoami)" admin &>/dev/null; then
    error "Homebrew installation requires an administrator account."
    error "Your user ‘$(whoami)’ is not in the admin group."
    error "Either run this from an admin account, or add your user to the admin group:"
    error "  sudo dseditgroup -o edit -a $(whoami) -t user admin"
    exit 2
  fi
  action "installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ $? != 0 ]]; then
      error "unable to install homebrew, script $0 abort!"
      exit 2
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"
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
  bottom \
  git-delta \
  eza \
  fish \
  fzf \
  gcc \
  gh \
  ghostscript \
  go \
  htop \
  git-lfs \
  lazygit \
  lf \
  lsd \
  m-cli \
  mame \
  neovim \
  node \
  ollama \
  postgres \
  s-search \
  s3fs \
  shellcheck \
  starship \
  tmux \
  tree \
  vim \
  wget \
  yarn \
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
