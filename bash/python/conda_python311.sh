#!/bin/bash

version="py311_24.7.1-0"

echo "checking conda install for python3 64 bits"

# check if conda is already installed
if [[ ! -d $home/miniconda3 ]]; then
  echo "installing conda..."

  # detect architecture
  architecture=$(uname -m)
  if [[ "$architecture" == "arm64" ]]; then
    # arm64 installer for apple silicon
    echo "detected arm64 architecture. using arm-specific miniconda installer."
    mkdir -p ~/miniconda3
    curl -o ~/miniconda3/miniconda.sh "https://repo.anaconda.com/miniconda/miniconda3-${version}-macosx-arm64.sh"
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
  else
    # x86_64 installer for intel macs
    echo "detected x86_64 architecture. using x86_64 miniconda installer."
    mkdir -p ~/miniconda3
    curl -o ~/miniconda3/miniconda.sh "https://repo.anaconda.com/miniconda/miniconda3-${version}-macosx-x86_64.sh"
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
  fi
  
  # remove the installer script
  rm ~/miniconda3/miniconda.sh

  # add conda to path in .bashrc
  if ! grep -q 'export path="$home/miniconda3/bin:$path"' ~/.bashrc; then
    echo 'export path="$home/miniconda3/bin:$path"' >> ~/.bashrc
    echo "conda has been added to .bashrc."
  else
    echo "conda is already in .bashrc."
  fi

  # source .bashrc to immediately apply the change
  source ~/.bashrc
  echo "conda installation completed and added to path."

else
  echo "conda is already installed."
fi


