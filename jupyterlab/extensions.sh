#!/bin/sh

# dash
pip install "jupyterlab>=1.0" jupyterlab-dash==0.1.0a3
jupyter labextension install jupyterlab-dash@0.1.0-alpha.3

# plotly
conda install -c conda-forge jupyterlab-plotly-extension
jupyter labextension install @jupyterlab/plotly-extension
