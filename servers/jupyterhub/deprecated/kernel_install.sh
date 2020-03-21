#!/bin/bash

# conda install nb_conda_kernels

mkdir -p $HOME/.local/share/jupyter
cp -r kernels $HOME/.local/share/jupyter/


# cp -r $PWD/kernels/ipkiss3/* $HOME/miniconda3/envs/ipkiss3/share/jupyter/kernels/python2
