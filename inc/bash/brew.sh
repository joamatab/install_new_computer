#!/bin/bash

source ./lib_sh/echos.sh
source ./lib_sh/requirers.sh

################################
# install brew
################################
running "checking homebrew install"
brew_bin=$(which brew) 2>&1 > /dev/null
if [[ $? != 0 ]]; then
  action "installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    if [[ $? != 0 ]]; then
      error "unable to install homebrew, script $0 abort!"
      exit 2
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
  s-search \
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

for i in \
  chatgpt \
  ghostty \
  flameshot \
  # granola \
  # google-drive \
  ;
do
  bin=$(which $i) 2>&1 > /dev/null
  if [[ $? != 0 ]]; then
    echo brew install $i
    brew install $i
  fi
done


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
