#!/bin/sh

[ ! -d ~/.pyenv ] && git clone https://github.com/pyenv/pyenv.git ~/.pyenv

pyenv install 3.7.8
pyenv install miniconda3-latest

pyenv global 3.7.8
