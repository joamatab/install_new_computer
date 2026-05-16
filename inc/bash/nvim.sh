#!/bin/bash

NVIM_VERSION=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep -Po '"tag_name": "\K[^"]*')
echo "==> Installing Neovim ($NVIM_VERSION) for Linux..."

ARCH=$(uname -m)
case "$ARCH" in
  x86_64)  ASSET="nvim-linux-x86_64" ;;
  aarch64) ASSET="nvim-linux-arm64" ;;
  *)       echo "    Unsupported architecture: $ARCH"; exit 1 ;;
esac

echo "    Downloading ${ASSET}.tar.gz..."
curl -sL "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${ASSET}.tar.gz" -o /tmp/${ASSET}.tar.gz

echo "    Extracting..."
tar xzf /tmp/${ASSET}.tar.gz -C /tmp

echo "    Installing to /opt/nvim..."
rm -rf /opt/nvim
cp -r /tmp/${ASSET} /opt/nvim

mkdir -p "$HOME/.local/bin"
ln -sf /opt/nvim/bin/nvim "$HOME/.local/bin/nvim"

rm -rf /tmp/${ASSET}.tar.gz /tmp/${ASSET}

if command -v nvim &>/dev/null; then
    echo "    Neovim version: $(nvim --version | head -1)"
else
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
