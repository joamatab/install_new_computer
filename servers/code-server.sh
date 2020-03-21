#!/bin/sh

git clone https://github.com/microsoft/vscode
cd vscode
git checkout ${vscodeVersion} # See travis.yml for the version to use.
yarn
git clone https://github.com/cdr/code-server src/vs/server
cd src/vs/server
yarn
yarn patch:apply
yarn watch
# Wait for the initial compilation to complete (it will say "Finished compilation").
# Run the next command in another shell.
yarn start
