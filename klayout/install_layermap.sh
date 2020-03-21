#!/bin/bash

[ -f "$PWD"/tech/$1/tech.lyt ] && ln -sf "$PWD"/tech/$1 ~/.klayout/tech/$1 && echo 'installed layermap for' $1 
[ ! -d "$PWD"/tech/$1 ] && echo "no layermap available for" $1

