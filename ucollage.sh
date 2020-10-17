#!/bin/sh
# https://github.com/ckardaris/ucollage


[ ! -d ucollage ] && git clone https://github.com/ckardaris/ucollage.git
ln -sf "$PWD"/ucollage/ucollage ~/.local/bin/
