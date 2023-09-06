#! /bin/bash

wget https://github.com/neovim/neovim/releases/download/v0.9.1/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz
ln -s "$PWD/nvim-linux64/bin/nvim" ~/.local/bin/
