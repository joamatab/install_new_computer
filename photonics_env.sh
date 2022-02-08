#!/bin/sh
# installs python photonics packages in a new conda environment

# Meep for FDTD simulations
conda create -n photonics -c conda-forge pymeep -y
conda activate photonics
pip install ipykernel
python -m ipykernel install --user --name photonics --display-name "photonics"

mkdir -p ~/photonics/

# gdsfactory for layout
git clone https://github.com/gdsfactory/gdsfactory.git ~/photonics/gdsfactory
cd ~/photonics/gdsfactory
make install

# Mode solver
git clone https://github.com/joamatab/modesolverpy ~/photonics/modes
cd ~/photonics/modes
make install
