#!/bin/sh
# https://github.com/glacambre/firenvim

git clone https://git.sr.ht/~glacambre/firenvim
cd firenvim || exit
npm install
npm run build
npm run install_manifests
