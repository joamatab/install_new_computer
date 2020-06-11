#!/bin/sh

# Serial pymeep
conda create -n mp2 -c simpetus -c conda-forge pymeep

conda activate mp2
python -m ipykernel install --user --name mp2 --display-name "mp2"


# Parallel pymeep
# conda create -n pmp_test -c simpetus -c conda-forge pymeep=*=mpi_mpich*
