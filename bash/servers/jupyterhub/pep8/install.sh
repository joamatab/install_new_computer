#!/bin/bash
# https://github.com/mlshapiro/jupyterlab-flake8

conda install flake8
jupyter labextension install jupyterlab-flake8
jupyter lab --watch
npm run watch
