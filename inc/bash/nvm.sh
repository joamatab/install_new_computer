#!/bin/bash

echo "==> Installing nvm (Node Version Manager)..."

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

echo "==> Done! Restart your shell, then run 'nvm install 20' to install Node.js 20 LTS."
