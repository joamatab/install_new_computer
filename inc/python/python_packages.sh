#!/bin/bash

pip install \
  classifier \
  gitcli \
  # howdoi \
  llm \
  img2pdf \
  mkinit \
  nbconvert \
  nbdime \
  neovim \
  pillow \
  pre-commit \
  pylint \
  pytest-testmon\
  pytest-watch\
  recommonmark \
  ruff \
  sourcery \
  sphinx \
  tbump \
  towncrier \
  trash-cli \
  virtualenvwrapper\
  PyPDF2

# mamba install -y \
#   jupyterlab
# jupyter labextension install @axlair/jupyterlab_vim

# mamba install -y jaxlib
# mamba install pymeep=*=mpi_mpich_* -y
# mamba install -y matplotlib
conda install -y  -c conda-forge gh
