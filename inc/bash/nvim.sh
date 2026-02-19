#!/bin/bash

echo "==> Installing Neovim (v0.10.3) for Linux..."

echo "    Downloading nvim-linux64.tar.gz..."
wget https://github.com/neovim/neovim/releases/download/v0.10.3/nvim-linux64.tar.gz

echo "    Extracting..."
tar xzvf nvim-linux64.tar.gz

if [ -d "$HOME/.local/bin" ]; then
    ln -sf "$PWD/nvim-linux64/bin/nvim" "$HOME/.local/bin/"
    echo "    Linked nvim to $HOME/.local/bin/"
else
    mv "$PWD/nvim-linux64/bin/nvim" /usr/local/bin/
    echo "    Moved nvim to /usr/local/bin/"
fi

rm -rf nvim-linux64.tar.gz

if command -v nvim &> /dev/null; then
    echo "    Neovim version: $(nvim --version | head -1)"
else
    echo "    Warning: nvim not found in PATH after install."
fi

echo "    Installing vim-plug for Neovim..."
if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo "    vim-plug installed."
else
  echo "    vim-plug already installed."
fi

echo "==> Done! Neovim installed. Run ':PlugInstall' to set up plugins."
