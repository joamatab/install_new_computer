#!/bin/bash

pip install \
  # awscli \
  black \
  bumpversion \
  classifier \
  matplotlib \
  isort \
  nbconvert \
  notedown \
  neovim \
  pillow \
  pre-commit \
  pyflakes \
  pylint \
  ranger-fm \
  recommonmark \
  sphinx \
  sphinx_rtd_theme \
  trash-cli \
  virtualenvwrapper

conda install -y \
  jupyterlab 

pip3 install --user --upgrade\
  cython \
  pillow \
  gds3xtrude 
