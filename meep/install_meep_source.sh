#!/bin/bash

git clone https://github.com/NanoComp/meep.git
cd meep/
./configure --prefix=$HOME/install PYTHON="${HOME}"/mambaforge/bin/python --with-maintainer-mode --without-guile
# sh autogen.sh --enable-shared --with-mpi --with-openmp PYTHON=python3 LDFLAGS="${MY_LDFLAGS}" CPPFLAGS="${MY_CPPFLAGS}"
sh autogen.sh --enable-shared --with-openmp PYTHON=python3 LDFLAGS="${MY_LDFLAGS}" CPPFLAGS="${MY_CPPFLAGS}"
make && make check && sudo make install
