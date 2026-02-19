#!/bin/sh

echo "==> Installing Fisher plugin manager and Oh My Fish..."

echo "    Installing Fisher..."
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

echo "    Removing existing Oh My Fish installation..."
rm -rf ~/.local/share/omf

echo "    Installing Oh My Fish..."
curl -L -k https://get.oh-my.fish | fish

echo "==> Done! Fisher and Oh My Fish installed."
