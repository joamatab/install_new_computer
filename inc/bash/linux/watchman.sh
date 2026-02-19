#!/bin/sh
# use the latest stable release
# a file watching
# https://facebook.github.io/watchman/

git clone https://github.com/facebook/watchman.git -b v4.9.0 --depth 1
cd watchman
./autogen.sh
./configure
make
sudo make install
