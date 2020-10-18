#!/bin/sh

[ ! -d autojump ] && git https://github.com/wting/autojump.git
cd autojump || exit
./install.py
