#!/bin/bash

pip install \
  black \
  bumpversion \
  classifier \
  howdoi \
  gitcli \
  img2pdf \
  isort \
  matplotlib \
  nbconvert \
  neovim \
  notedown \
  pillow \
  pre-commit \
  pyflakes \
  pylint \
  ranger-fm \
  recommonmark \
  sphinx \
  sphinx_rtd_theme \
  trash-cli \
  virtualenvwrapper\
  PyPDF2

conda install -y \
  jupyterlab


conda config --add channels simpetus
conda install -y pymeep
pip install gdsfactory --upgrade
pip install modes --upgrade

jupyter labextension install @axlair/jupyterlab_vim
