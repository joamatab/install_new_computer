#!/bin/sh

[ ! -d dwm ] && git clone git@github.com:joamatab/dwm.git

cd dwm || echo "$PWD/dwm not found"
sudo make install
