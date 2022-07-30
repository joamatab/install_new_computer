#!/bin/sh

[ ! -d sxhkd ] && git clone https://github.com/baskerville/sxhkd.git
cd sxhkd
sudo make && sudo make install


