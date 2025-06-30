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
  git clone https://github.com/joamatab/dotfiles.git $DOTFILES
  cd ~/dotfiles/
  sh install
fi

