#!/bin/sh
# installs python photonics packages in your current python environment

conda config --add channels simpetus
conda install -y pymeep
pip install gdsfactory --upgrade
pip install modes --upgrade
