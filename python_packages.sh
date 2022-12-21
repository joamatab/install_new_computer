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
  recommonmark \
  sphinx \
  sphinx_rtd_theme \
  tox \
  trash-cli \
  virtualenvwrapper\
  PyPDF2

mamba install -y \
  jupyterlab

jupyter labextension install @axlair/jupyterlab_vim

# mamba install -y jaxlib
# mamba install pymeep=*=mpi_mpich_* -y
# mamba install -y matplotlib
