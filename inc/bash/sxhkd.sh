#!/bin/sh

echo "==> Installing sxhkd (Simple X Hotkey Daemon)..."

if [ ! -d sxhkd ]; then
  echo "    Cloning sxhkd repository..."
  git clone https://github.com/baskerville/sxhkd.git
fi

echo "    Building and installing..."
cd sxhkd
sudo make && sudo make install

echo "==> Done! sxhkd installed."
