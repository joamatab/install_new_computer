#!/bin/bash

echo "==> Setting up Neovim plugin manager (vim-plug)..."

if [ -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
  echo "    vim-plug already installed."
else
  echo "    Installing vim-plug for Neovim..."
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "==> Done! Run ':PlugInstall' in Neovim to install plugins."
