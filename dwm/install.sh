#!/bin/sh

rm -rf dwm
git clone https://git.suckless.org/dwm
cd dwm
sudo make clean install
