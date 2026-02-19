#!/bin/sh

[ ! -d dwmblocks ] && git clone https://github.com/joamatab/dwmblocks.git

cd dwmblocks || echo "$PWD/dwmblocks not found"
sudo make install
