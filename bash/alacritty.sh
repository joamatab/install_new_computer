#!/bin/sh

[ ! -d alacritty ] && git clone git@github.com:alacritty/alacritty.git
cd alacritty
make install
ln -sf $PWD/alacritty/target/release/alacritty ~/.local/bin

