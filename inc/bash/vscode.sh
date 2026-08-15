#!/bin/sh

mkdir -p ~/.local/opt ~/.local/bin
cd /tmp || exit 1

wget -O vscode.tar.gz 'https://update.code.visualstudio.com/latest/linux-x64/stable'
tar -xzf vscode.tar.gz

mv VSCode-linux-x64 ~/.local/opt/vscode
ln -sf ~/.local/opt/vscode/bin/code ~/.local/bin/code
