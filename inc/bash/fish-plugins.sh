#!/bin/sh

curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
rm -rf ~/.local/share/omf
curl -L -k https://get.oh-my.fish | fish
