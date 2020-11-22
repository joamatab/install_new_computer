#!/bin/sh
# https://github.com/hluk/CopyQ
# can copy images but I prefer clipmenu

[ ! -d CopyQ ] && git clone https://github.com/hluk/CopyQ.git
cd CopyQ || exit
cmake .
make
