#!/bin/bash

# conda install nb_conda_kernels

mkdir -p ~/.Trash
mv ~/.local/share/jupyter/kernels ~/.Trash

mkdir -p ~/.local/share/jupyter
cp -r kernels ~/.local/share/jupyter/

# cp -r $PWD/kernels/ipkiss3/* $HOME/miniconda3/envs/ipkiss3/share/jupyter/kernels/python2
