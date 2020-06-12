#!/bin/sh
# installs latest meep in your a new conda environment

# Serial pymeep
conda create -n mp2 -c simpetus -c conda-forge pymeep -y

conda activate mp2
pip install ipykernel
python -m ipykernel install --user --name mp2 --display-name "mp2"


# Parallel pymeep
# conda create -n pmp_test -c simpetus -c conda-forge pymeep=*=mpi_mpich*
