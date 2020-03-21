#!/bin/sh
# https://ipython.readthedocs.io/en/latest/install/kernel_install.html

python2 -m pip install ipykernel
python2 -m ipykernel install --user

python3 -m pip install ipykernel
python3 -m ipykernel install --user

python -m pip install ipykernel
python -m ipykernel install --user

pip install ipykernel
pip2 install ipykernel
pip3 install ipykernel
