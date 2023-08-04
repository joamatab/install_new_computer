#!/bin/sh

[ ! -d ~/.pyenv ] && git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# pyenv install 3.7.8
# pyenv install miniconda3-4.7.12
# pyenv global miniconda3-4.7.12

pyenv install miniconda3-latest
pyenv global miniconda3-latest
