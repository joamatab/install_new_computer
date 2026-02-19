#!/bin/sh

echo "==> Installing Fish shell plugins..."

echo "    Adding fish-git-util..."
fisher add fishpkg/fish-git-util

echo "    Adding fzf integration..."
fisher add jethrokuan/fzf

echo "==> Done! Fish plugins installed."
