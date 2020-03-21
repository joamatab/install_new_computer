#!/bin/sh

sudo apt install -y \
		zlib1g \
		zlib1g-dev

wget http://archive.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng_1.2.54.orig.tar.xz

tar xvf libpng_1.2.54.orig.tar.xz 

cd libpng-1.2.54
./autogen.sh
./configure
make -j8 
sudo make install

