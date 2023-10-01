#!/bin/sh

git clone --recurse-submodules https://github.com/sagemathinc/cocalc
cd cocalc/src
npm run install-all
npm test
install.py all
