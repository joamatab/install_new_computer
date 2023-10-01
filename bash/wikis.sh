#!/bin/sh

if [ ! -d $HOME/wikis/joaquin ]; then
  git clone git@github.com:joamatab/joaquin.wiki.git  ~/wikis/joaquin
else
  cd ~/wikis/joaquin
  git pull
fi

if [ ! -d $HOME/wikis/github ]; then
  git clone git@github.com:joamatab/dotfiles.wiki.git  ~/wikis/github
else
  cd ~/wikis/github
  git pull
fi

if [ ! -d $HOME/wikis/gotbletu ]; then
  git clone https://github.com/gotbletu/shownotes.git ~/wikis/gotbletu
else
  cd ~/wikis/gotbletu
  git pull
fi

if [ ! -d $HOME/wikis/book-notes ]; then
  git clone git@github.com:joamatab/book-notes.git ~/wikis/book-notes
else
  cd ~/wikis/book-notes
  git pull
fi

if [ ! -d $HOME/wikis/awesome_photonics ]; then
  git clone git@github.com:joamatab/awesome_photonics.git ~/wikis/awesome_photonics
else
  cd ~/wikis/awesome_photonics
  git pull
fi
