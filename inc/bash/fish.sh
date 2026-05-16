#!/bin/sh

echo "==> Setting up Fish shell as default..."

fish_bin=$(command -v fish)

if [ -z "$fish_bin" ]; then
  echo "    Fish not found. Install it first."
  exit 1
fi

echo "    Found Fish at: $fish_bin"

if ! grep -qx "$fish_bin" /etc/shells; then
  echo "    Adding Fish to /etc/shells..."
  echo "$fish_bin" | sudo tee -a /etc/shells
else
  echo "    Fish already in /etc/shells."
fi

if [ "$SHELL" != "$fish_bin" ]; then
  echo "    Changing default shell to Fish..."
  sudo chsh -s "$fish_bin" "$USER"
else
  echo "    Fish is already the default shell."
fi

echo "    Installing Oh My Fish..."
curl -L https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

echo "==> Done! Restart your terminal to use Fish."
