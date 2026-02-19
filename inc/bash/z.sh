#!/bin/sh
[ ! -d z ] && git clone  https://github.com/skywind3000/z.lua.git z

mkdir -p ~/.local/bin
ln -sf "$PWD"/z/z.lua ~/.local/bin/
mkdir -p ~/.config/fish/conf.d/
cp z.fish ~/.config/fish/conf.d/z.fish
