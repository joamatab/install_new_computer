#!/bin/bash

echo "==> Installing KLayout (layout viewer/editor)..."

os_name=$(uname -s)
architecture=$(uname -m)

if [[ "$os_name" == "Darwin" ]]; then
  echo "    macOS detected. Installing KLayout via Homebrew cask..."
  brew install --cask klayout
elif [[ "$os_name" == "Linux" ]]; then
  if command -v apt-get &> /dev/null; then
    echo "    Debian/Ubuntu detected. Installing KLayout..."
    sudo apt-get update -y
    sudo apt-get install -y klayout
  elif command -v dnf &> /dev/null; then
    echo "    Fedora/RHEL detected. Installing KLayout..."
    sudo dnf install -y klayout
  elif command -v pacman &> /dev/null; then
    echo "    Arch detected. Installing KLayout..."
    sudo pacman -S --noconfirm klayout
  else
    echo "    Unsupported Linux distribution. Please install KLayout manually from https://www.klayout.de/build.html"
    exit 1
  fi
else
  echo "    Unsupported operating system."
  exit 1
fi

echo "==> Done! KLayout installed."
