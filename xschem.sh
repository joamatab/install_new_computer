#!/bin/sh

[ ! -d xschem ] && git clone git@github.com:StefanSchippers/xschem.git
cd xschem
./configure --prefix=$HOME && make
make install
