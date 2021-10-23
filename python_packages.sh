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


conda config --add channels simpetus
conda install -y pymeep matplotlib
jupyter labextension install @axlair/jupyterlab_vim
