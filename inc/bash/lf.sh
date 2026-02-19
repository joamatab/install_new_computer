#!/bin/bash

echo "==> Installing lf (terminal file manager)..."

mkdir -p ~/.local/bin

if [[ -d /Applications ]]; then
  echo "    Downloading lf for macOS..."
  curl -L https://github.com/gokcehan/lf/releases/download/r38/lf-darwin-amd64.tar.gz | tar xzC ~/.local/bin
else
  echo "    Downloading lf for Linux..."
  curl -L https://github.com/gokcehan/lf/releases/download/r38/lf-linux-amd64.tar.gz | tar xzC ~/.local/bin
fi

echo "==> Done! lf installed to ~/.local/bin/"
