#!/bin/sh

DIR="$HOME/.local/bin"

mkdir -p $DIR
curl https://raw.githubusercontent.com/kyleburton/bake/master/bake > $DIR/bake
chmod 755 $DIR/bake
