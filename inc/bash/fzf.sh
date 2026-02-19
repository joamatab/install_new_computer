#!/bin/sh

echo "==> Installing fzf (fuzzy finder)..."

if [ -d ~/.fzf ]; then
  echo "    Already cloned at ~/.fzf"
else
  echo "    Cloning fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi

echo "    Running fzf installer..."
~/.fzf/install

echo "==> Done! fzf installed."
