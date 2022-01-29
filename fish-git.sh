#!/bin/bash

git clone https://github.com/fish-shell/fish-shell.git
cd fish-shell
mkdir build; cd build
cmake ..
make
sudo make install
