#!/bin/bash

sudo apt-get install ngspice build-essential git cmake qtbase5-dev qttools5-dev libqt5svg5-dev flex bison
wget https://github.com/ra3xdh/qucs_s/releases/download/24.2.1/qucs-s-24.2.1.tar.gz
tar xvfz qucs-s-24.2.1.tar.gz
cd qucs-s-24.2.1
mkdir builddir
cd builddir
cmake ..
make
make install
