#!/bin/bash

pip install jupyter
pip install jupyterhub
jupyter labextension install @jupyterlab/hub-extension
# sudo apt-get install -y npm nodejs-legacy
# sudo apt-get install -y npm
# sudo npm install -g configurable-http-proxy

conda install -c conda-forge jupyterhub
conda install notebook
conda install jupyterlab
