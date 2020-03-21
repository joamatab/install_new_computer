#!/bin/bash

mkdir -p ~/.Trash
mv ~/.local/share/jupyter/kernels ~/.Trash
mkdir -p ~/.local/share/jupyter
cp -r kernels_linux ~/.local/share/jupyter/

