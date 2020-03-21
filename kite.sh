#!/bin/sh
# Kite is an autocomplete framework for python

bash -c "$(wget -q -O - https://linux.kite.com/dls/linux/current)"

mkdir -p ~/.config/nvim/pack/kite/start/kite
if [ -d $HOME/dotfiles ]; then
  cd ~/.config/nvim/pack/kite/start/kite/
  git pull
else
  git clone https://github.com/kiteco/vim-plugin.git ~/.config/nvim/pack/kite/start/kite/
fi
