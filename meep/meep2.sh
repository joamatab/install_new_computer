#!/bin/sh
# installs meep in your current conda environment

conda config --add channels conda-forge
pip install ipykernel
conda install -y pymeep

