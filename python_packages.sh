#!/bin/bash

pip install \
  black \
  bumpversion \
  classifier \
  howdoi \
  gitcli \
  img2pdf \
  isort \
  nbconvert \
  neovim \
  mkinit \
  notedown \
  nbdime \
  pillow \
  pre-commit \
  pyflakes \
  pylint \
  ranger-fm \
  recommonmark \
  sphinx \
  sphinx_rtd_theme \
  tox \
  trash-cli \
  virtualenvwrapper\
  PyPDF2

conda install -y \
  jupyterlab


conda config --add channels conda-forge
# conda config --add channels simpetus
# conda install mpi4py -y

conda install -y matplotlib
conda install -y jaxlib
conda install -c conda-forge pymeep=*=mpi_mpich_* -y

jupyter labextension install @axlair/jupyterlab_vim
