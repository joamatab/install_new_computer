#!/bin/sh
# installs python packages in a conda environment

# Meep for FDTD simulations
conda create -n photonics -c simpetus -c conda-forge pymeep -y
conda activate photonics
pip install ipykernel
python -m ipykernel install --user --name photonics --display-name "photonics"

# Simphony for Smatrix circuit simulations
pip install simphony

mkdir -p ~/photonics/

# gdsfactory for layout
git clone https://github.com/gdsfactory/gdsfactory.git ~/photonics/
cd ~/photonics/gdsfactory
make install

# Mode solver
git clone https://github.com/joamatab/modesolverpy ~/photonics/
cd ~/photonics/modesolverpy
make install
