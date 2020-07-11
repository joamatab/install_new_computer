#!/bin/bash

# if [[ ! -d $HOME/.vim/autoload ]]; then
#   curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# fi

if [[ ! -d $HOME/.local/share/nvim/site/autoload ]]; then
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# mkdir -p ~/.config/nvim
# ln -sf ~/.vimrc ~/.config/nvim/init.vim

# python3 -m venv ~/.config/nvim/env
# source ~/.config/nvim/env/bin/activate
# pip install pynvim neovim black


# source ~/.vim/black/bin/activate  # make sure to install in the right venv
# source ~/.local/share/nvim/black/bin/activate
# pip install --upgrade git+https://github.com/psf/black.git
