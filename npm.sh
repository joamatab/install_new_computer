#!/bin/bash

sudo curl -L https://www.npmjs.com/install.sh | sh
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
