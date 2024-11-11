#!/bin/bash

echo "Checking conda install for Python3 64 bits"

# Check if Conda is already installed
if [[ ! -d $HOME/miniconda3 ]]; then
  echo "Installing Conda..."

  # Detect architecture
  ARCHITECTURE=$(uname -m)
  if [[ "$ARCHITECTURE" == "arm64" ]]; then
    # ARM64 installer for Apple Silicon
    echo "Detected ARM64 architecture. Using ARM-specific Miniconda installer."
    mkdir -p ~/miniconda3
    curl -o ~/miniconda3/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
  else
    # x86_64 installer for Intel Macs
    echo "Detected x86_64 architecture. Using x86_64 Miniconda installer."
    mkdir -p ~/miniconda3
    curl -o ~/miniconda3/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
  fi
  
  # Remove the installer script
  rm ~/miniconda3/miniconda.sh

  # Add Conda to PATH in .bashrc
  if ! grep -q 'export PATH="$HOME/miniconda3/bin:$PATH"' ~/.bashrc; then
    echo 'export PATH="$HOME/miniconda3/bin:$PATH"' >> ~/.bashrc
    echo "Conda has been added to .bashrc."
  else
    echo "Conda is already in .bashrc."
  fi

  # Source .bashrc to immediately apply the change
  source ~/.bashrc
  echo "Conda installation completed and added to PATH."

else
  echo "Conda is already installed."
fi


