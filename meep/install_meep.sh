#!/bin/bash

set -e

RPATH_FLAGS="-Wl,-rpath,/usr/local/lib:/usr/lib/x86_64-linux-gnu/hdf5/openmpi"
MY_LDFLAGS="-L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/hdf5/openmpi ${RPATH_FLAGS}"
MY_CPPFLAGS="-I/usr/local/include -I/usr/include/hdf5/openmpi"

sudo apt-get update
sudo apt-get -y install build-essential gfortran libblas-dev liblapack-dev libgmp-dev swig libgsl-dev autoconf pkg-config libpng-dev git guile-2.2-dev libfftw3-dev libhdf5-openmpi-dev hdf5-tools libpython3-dev python3-pip cmake

mkdir -p ~/install
cd ~/install
git clone https://github.com/NanoComp/harminv.git
cd harminv/
sh autogen.sh --enable-shared
make && sudo make install

cd ~/install
git clone https://github.com/NanoComp/libctl.git
cd libctl/
sh autogen.sh --enable-shared
make && sudo make install

cd ~/install
git clone https://github.com/NanoComp/h5utils.git
cd h5utils/
sh autogen.sh CC=mpicc LDFLAGS="${MY_LDFLAGS}" CPPFLAGS="${MY_CPPFLAGS}"
make && sudo make install

cd ~/install
git clone https://github.com/NanoComp/mpb.git
cd mpb/
sh autogen.sh --enable-shared CC=mpicc LDFLAGS="${MY_LDFLAGS}" CPPFLAGS="${MY_CPPFLAGS}" --with-hermitian-eps
make && sudo make install

cd ~/install
git clone https://github.com/HomerReid/libGDSII.git
cd libGDSII/
sh autogen.sh
make && make check && sudo make install

pip3 install --user --no-cache-dir mpi4py
pip3 install --user Cython==0.29.16
export HDF5_MPI="ON"
pip3 install --user --no-binary=h5py h5py
pip3 install --user autograd
pip3 install --user scipy
pip3 install --user matplotlib>3.0.0
pip3 install --user ffmpeg

cd ~/install
git clone git://github.com/stevengj/nlopt.git
cd nlopt/
cmake -DPYTHON_EXECUTABLE=/usr/bin/python3 && make && make check && sudo make install

export PYTHONPATH="/usr/lib/python3/dist-packages:${PWD}/.local/lib/python3.8/site-packages:${PYTHONPATH}"

cd ~/install
git clone https://github.com/NanoComp/meep.git
cd meep/
sh autogen.sh --enable-shared --with-mpi --with-openmp PYTHON=python3 LDFLAGS="${MY_LDFLAGS}" CPPFLAGS="${MY_CPPFLAGS}"
make && make check && sudo make install
