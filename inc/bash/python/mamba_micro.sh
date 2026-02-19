#!/bin/bash

# curl -L -O https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh
# bash Mambaforge-$(uname)-$(uname -m).sh -b

echo "checking mamba install for python3 64 bits"
if [[ ! -d $HOME/mambaforge ]]; then
  echo "installing mamba"
  if [[ -d /Applications ]]; then

    curl -Ls https://micro.mamba.pm/api/micromamba/osx-64/latest | tar -xvj bin/micromamba

  else
    wget -qO- https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
  fi
fi
cp bin/micromamba ~/.local/bin/micromamba
