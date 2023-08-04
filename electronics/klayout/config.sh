#!/bin/bash

# mkdir -p ~/.Trash
# mv ~/.klayout ~/.Trash
echo 'installing Klayout layermaps'

mkdir -p ~/.klayout
mkdir -p ~/.klayout/tech
mkdir -p ~/.klayout/pymacros
mkdir -p ~/.klayout/macros
mkdir -p ~/.klayout/python

# # Layermaps
# for entry in "$PWD"/tech/*
# do
#   ln -sf "$entry" ~/.klayout/tech/
# done

ln -sf "$PWD"/xsection  $/.klayout/
ln -sf "$PWD"/drc  ~/.klayout
ln -sf "$PWD"/pymacros/klive.lym  ~/.klayout/pymacros/

cp $PWD/pymacros/klive.lym  ~/.klayout/pymacros/
