#!/bin/sh
# installs stable meep in your a new conda environment

conda create -n mp -c conda-forge pymeep -y
conda install -y notebook ipykernel 
conda activate mp
python -m ipykernel install --user --name mp --display-name "mp"

