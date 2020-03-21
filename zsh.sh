#!/bin/sh
# Z-shell is a shell replacement for bash. I prefer FISH

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

zsh_bin=$(which zsh) 2>&1 > /dev/null
chsh -s $zsh_bin
