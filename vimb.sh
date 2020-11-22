#!/bin/sh
# https://github.com/fanglingsu/vimb.git
# Vim inspired browser

[ ! -d vimb ] && git clone https://github.com/fanglingsu/vimb.git
cd vimb || exit
make PREFIX=/usr
make PREFIX=/usr install
