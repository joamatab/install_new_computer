#!/bin/sh

[ ! -d clipnotify ] && git clone https://github.com/cdown/clipnotify.git
[ ! -d clipmenu ] && git clone https://github.com/cdown/clipmenu.git

cd clipnotify || exit
make install
cd clipmenu || exit
make install
