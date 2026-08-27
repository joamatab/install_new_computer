#!/bin/bash

set -euo pipefail

NVIM_VERSION=$(curl -fsSL https://api.github.com/repos/neovim/neovim/releases/latest | grep -Po '"tag_name": "\K[^"]*')
echo "==> Installing Neovim ($NVIM_VERSION) for Linux..."

ARCH=$(uname -m)
case "$ARCH" in
  x86_64)  ASSET="nvim-linux-x86_64" ;;
  aarch64) ASSET="nvim-linux-arm64" ;;
  *)       echo "    Unsupported architecture: $ARCH"; exit 1 ;;
esac

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

echo "    Downloading ${ASSET}.tar.gz..."
curl -fsSL "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${ASSET}.tar.gz" -o "$TEMP_DIR/${ASSET}.tar.gz"

echo "    Extracting..."
tar xzf "$TEMP_DIR/${ASSET}.tar.gz" -C "$TEMP_DIR"

INSTALL_DIR="$HOME/.local/opt/nvim"
echo "    Installing to $INSTALL_DIR..."
rm -rf "$INSTALL_DIR"
mkdir -p "$(dirname "$INSTALL_DIR")"
cp -r "$TEMP_DIR/${ASSET}" "$INSTALL_DIR"

mkdir -p "$HOME/.local/bin"
ln -sf "$INSTALL_DIR/bin/nvim" "$HOME/.local/bin/nvim"

echo "    Neovim version: $("$HOME/.local/bin/nvim" --version | head -1)"
if ! command -v nvim &>/dev/null; then
    echo "    Warning: nvim not found in PATH. Add ~/.local/bin to your PATH."
fi

echo "    Installing vim-plug for Neovim..."
if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo "    vim-plug installed."
else
  echo "    vim-plug already installed."
fi

echo "==> Done! Neovim installed. Run ':PlugInstall' to set up plugins."
