#!/bin/sh
# Install config files with shortcuts, paths, etc.

DOTFILES="$HOME/dotfiles"

if [ -d $DOTFILES ]; then
  echo "updating dotfiles"
  cd ~/dotfiles/
  git pull
  sh install.sh
else
  echo "installing dotfiles"
  git clone git@github.com:joamatab/dotfiles.git $DOTFILES
  cd ~/dotfiles/
  sh install.sh
fi

if [ ! -d $DOTFILES/luke ]; then
  git clone https://github.com/LukeSmithxyz/voidrice.git "$DOTFILES"/luke
else
  cd luke
  git pull
  cd ..
fi

if [ ! -d $DOTFILES/brodie ]; then
  git clone https://github.com/BrodieRobertson/scripts.git  "$DOTFILES"/brodie
else
  cd brodie
  git pull
  cd ..
fi

mkdir -p "$DOTFILES"/extra
if [ ! -d $DOTFILES/extra/brodie ]; then
    git clone https://github.com/BrodieRobertson/dotfiles.git "$DOTFILES"/extra/brodie
else
    cd extra/brodie
    git pull
    cd ../..
fi
