#!/bin/bash
apt-get install -y gfortran liblapack-dev python-numpy python-scipy python-matplotlib libboost-python-dev scons libblitz-dev python-dev python-numpy liblapack-dev

## Get and unpack the sources
git clone https://github.com/kitchenknif/CAMFR camfr
cd camfr

## Change the options for compilation (removes the dependency on 'mkl'
ln -s machine_cfg.py.gcc machine_cfg.py
sed -i -e 's|^flags = .*|flags = base_flags + "-O3 -march=native -g -funroll-loops "|g' machine_cfg.py
sed -i -e 's|^include_dirs = .*|include_dirs = ["/usr/include/python2.7", "/pymodules/python2.7/", \ "/usr/lib/python2.7/dist-packages/"] |g' machine_cfg.py
sed -i -e 's|^libs = .*|libs = ["boost_python", "blitz", "lapack"]|g' machine_cfg.py
sed -i -e 's|^extra_files = .*|extra_files = []|g' machine_cfg.py

## Compile and install
sudo python setup.py install
cd ..
rm -rf camfr
