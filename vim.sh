#!/bin/bash

# if [[ ! -d $HOME/.vim/autoload ]]; then
#   curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# fi

if [[ ! -d $HOME/.local/share/nvim/site/autoload ]]; then
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# mkdir -p ~/.config/nvim
# ln -sf ~/.vimrc ~/.config/nvim/init.vim
