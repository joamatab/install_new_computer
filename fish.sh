#!/bin/bash

fish_bin=$(which fish) 2>&1 > /dev/null

if [[ ! -d $HOME/.local/share/omf ]]; then
  curl -L https://get.oh-my.fish | fish
fi

chsh -s $fish_bin
