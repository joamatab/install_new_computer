#!/bin/bash

echo "==> Setting up coc.nvim..."

# coc.nvim requires Node.js >= 16
if ! command -v node &>/dev/null; then
  echo "    Node.js not found. Installing via nvm..."
  export NVM_DIR="$HOME/.nvm"
  if [ ! -d "$NVM_DIR" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
  fi
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  nvm install 20
fi

echo "    Node.js version: $(node --version)"

# Install vim-plug plugins (including coc.nvim) headlessly
if command -v nvim &>/dev/null; then
  echo "    Running :PlugInstall..."
  nvim --headless +PlugInstall +qall 2>/dev/null
  echo "    Installing coc extensions..."
  nvim --headless +'CocInstall -sync coc-pyright coc-json coc-css coc-html coc-yaml coc-vimlsp coc-tsserver coc-tailwindcss coc-svelte coc-elixir coc-svg coc-actions coc-lists coc-yank coc-highlight coc-solargraph|qall' 2>/dev/null
else
  echo "    Warning: nvim not found. Install neovim first."
  exit 1
fi

echo "==> Done! coc.nvim installed with extensions."
