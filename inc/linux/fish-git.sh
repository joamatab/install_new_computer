#!/bin/bash

git clone https://github.com/fish-shell/fish-shell.git
cd fish-shell
mkdir build; cd build
cmake ..
make
sudo make install

curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
rm -rf ~/.local/share/omf
curl -L -k https://get.oh-my.fish | fish
