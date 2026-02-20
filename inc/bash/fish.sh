#!/bin/sh

echo "==> Setting up Fish shell as default..."

fish_bin=$(which fish) 2>&1 > /dev/null
echo "    Found Fish at: $fish_bin"

echo "    Adding Fish to /etc/shells..."
echo $fish_bin | sudo tee -a /etc/shells

echo "    Changing default shell to Fish..."
chsh -s $(which fish)

echo "    Installing Oh My Fish..."
curl -L https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

echo "==> Done! Restart your terminal to use Fish."
