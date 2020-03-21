#!/bin/bash

# conda install nb_conda_kernels
# mkdir -p $HOME/.local/share/jupyter
# cp -r kernels $HOME/.local/share/jupyter/
# cp -r $PWD/kernels/ipkiss3/* $HOME/miniconda3/envs/ipkiss3/share/jupyter/kernels/python2

python2 -m pip install ipykernel
python2 -m ipykernel install --user

python3 -m pip install ipykernel
python3 -m ipykernel install --user

conda activate base
python -m pip install ipykernel
python -m ipykernel install --user

