#!/bin/bash

set -eo pipefail

echo "==> Setting up Fish shell as default..."

fish_bin=$(command -v fish || true)

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
omf_path="${XDG_DATA_HOME-$HOME/.local/share}/omf"
if [ -d "$omf_path/pkg/omf" ]; then
  echo "    Oh My Fish already installed. Keeping existing plugins."
else
  omf_installer=$(mktemp)
  trap 'rm -f "$omf_installer"' EXIT
  curl -fsSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install -o "$omf_installer"
  fish "$omf_installer" --noninteractive --yes
fi

echo "==> Done! Restart your terminal to use Fish."
