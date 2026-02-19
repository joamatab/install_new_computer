#!/bin/sh

[ ! -d ngspice ] && git clone https://github.com/imr/ngspice.git
mkdir -p ngspice/release
cd ngspice
./autogen.sh --adms
cd release
../configure  --with-x --with-readline=yes --disable-debug
make
sudo make install
