#!/bin/bash

echo "==> Installing GitHub Copilot plugin for Neovim..."
echo "    https://docs.github.com/en/copilot/getting-started-with-github-copilot?tool=vimneovim"

DEST="$HOME/.config/nvim/pack/github/start/copilot.vim"

if [ -d "$DEST" ]; then
  echo "    Already installed at $DEST"
else
  git clone https://github.com/github/copilot.vim "$DEST"
fi

echo "==> Done! Run ':Copilot setup' in Neovim to authenticate."
