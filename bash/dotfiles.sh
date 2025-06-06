#!/bin/sh
# Install config files with shortcuts, paths, etc.

DOTFILES="$HOME/dotfiles"
DOTFILES_LUKE="$HOME/dotfiles/extra/luke"
DOTFILES_BRODIE="$HOME/dotfiles/extra/brodie"

if [ -d $DOTFILES ]; then
  echo "updating dotfiles"
  cd $DOTFILES
  git pull
  sh install
else
  echo "installing dotfiles"
  # Try SSH first, fallback to HTTPS
  if ! git clone git@github.com:joamatab/dotfiles.git $DOTFILES; then
    echo "SSH clone failed, trying HTTPS..."
    git clone https://github.com/joamatab/dotfiles.git $DOTFILES
  fi
  cd ~/dotfiles/
  sh install
fi

if [ ! -d $DOTFILES_LUKE ]; then
  git clone https://github.com/LukeSmithxyz/voidrice.git $DOTFILES_LUKE
else
  cd $DOTFILES_LUKE
  git pull
fi

if [ ! -d $DOTFILES_BRODIE ]; then
  git clone https://github.com/BrodieRobertson/scripts.git  $DOTFILES_BRODIE
else
  cd $DOTFILES_BRODIE
  git pull
fi
