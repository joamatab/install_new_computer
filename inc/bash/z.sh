#!/bin/sh

echo "==> Installing z.lua (directory jumper)..."

if [ ! -d z ]; then
  echo "    Cloning z.lua..."
  git clone https://github.com/skywind3000/z.lua.git z
else
  echo "    z.lua already cloned."
fi

echo "    Linking z.lua to ~/.local/bin/..."
mkdir -p ~/.local/bin
ln -sf "$PWD"/z/z.lua ~/.local/bin/

echo "    Installing Fish shell integration..."
mkdir -p ~/.config/fish/conf.d/
cp z.fish ~/.config/fish/conf.d/z.fish

echo "==> Done! z.lua installed. Use 'z <directory>' to jump."
