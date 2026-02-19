#!/bin/sh

echo "==> Installing tldr (simplified man pages)..."
echo "    https://github.com/isacikgoz/tldr"

curl -OL https://github.com/isacikgoz/tldr/releases/download/v0.5.0/tldr_0.5.0_linux_amd64.tar.gz

echo "    Extracting..."
tar xzf tldr_0.5.0_linux_amd64.tar.gz
cp tldr ~/.local/bin/

echo "==> Done! tldr installed to ~/.local/bin/"
