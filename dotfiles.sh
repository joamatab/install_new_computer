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
  git clone http://github.com/joamatab/dotfiles.git ~/dotfiles
  cd ~/dotfiles/
  sh install.sh
fi

if [ ! -d $DOTFILES/luke ]; then
  git clone https://github.com/LukeSmithxyz/voidrice.git luke
else
  cd luke
  git pull
  cd ..
fi

if [ ! -d $DOTFILES/brodie ]; then
  git clone https://github.com/BrodieRobertson/scripts.git brodie
else
  cd brodie
  git pull
  cd ..
fi

mkdir -p extra
if [ ! -d $DOTFILES/extra/brodie ]; then
    git clone https://github.com/BrodieRobertson/dotfiles.git extra/brodie
else
    cd extra/brodie
    git pull
    cd ../..
fi
