#!/bin/bash

# conda install nb_conda_kernels

mkdir -p $HOME/.local/share/jupyter
# cp -r kernels_centos/* $HOME/.local/share/jupyter/kernels/
cp -r $PWD/kernels_centos/ipkiss3 $HOME/miniconda3/envs/ipkiss3/share/jupyter/kernels
