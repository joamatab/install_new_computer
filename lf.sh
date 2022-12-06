#!/bin/sh
# install lf file browser for linux and mac os

mkdir -p ~/.local/bin

if [[ -d /Applications ]]; then
  curl -L https://github.com/gokcehan/lf/releases/download/r27/lf-darwin-amd64.tar.gz | tar xzC ~/.local/bin

else
  curl -L https://github.com/gokcehan/lf/releases/download/r27/lf-linux-amd64.tar.gz | tar xzC ~/.local/bin

fi
