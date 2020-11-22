#!/bin/sh

fish_bin=$(which fish) 2>&1 > /dev/null
echo $fish_bin | sudo tee -a /etc/shells

chsh -s $(which fish)
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

if [[ ! -d $HOME/.local/share/omf ]]; then
  curl -L https://get.oh-my.fish | fish
fi
