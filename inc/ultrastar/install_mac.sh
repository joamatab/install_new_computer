#!/bin/sh

if [ ! -d USDX ]; then
  git clone https://github.com/UltraStar-Deluxe/USDX
fi
cd USDX
./autogen.sh
./configure
make macosx-standalone-app
