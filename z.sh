#!/bin/sh
[ ! -d z ] && git clone  https://github.com/skywind3000/z.lua.git z
ln -sf "$PWD"/z/z.lua ~/.local/bin/
cp z.fish ~/.config/fish/conf.d/z.fish
