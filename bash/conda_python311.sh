#!/bin/bash

version="py311_24.7.1-0"

echo "Checking conda installation for Python 3 (64-bit)..."

os_name=$(uname -s)

# Check if conda is already installed
if [[ ! -d "$HOME/miniconda3" ]]; then
  echo "Installing conda..."

  # Detect architecture
  architecture=$(uname -m)

  if [[ "$os_name" == "Darwin" ]]; then
    if [[ "$architecture" == "arm64" ]]; then
      # arm64 installer for Apple Silicon
      echo "Detected arm64 architecture. Using arm-specific Miniconda installer."
      curl -o miniconda.sh "https://repo.anaconda.com/miniconda/Miniconda3-${version}-MacOSX-arm64.sh"
    else
      # x86_64 installer for Intel Macs
      echo "Detected x86_64 architecture. Using x86_64 Miniconda installer."
      curl -o miniconda.sh "https://repo.anaconda.com/miniconda/Miniconda3-${version}-MacOSX-x86_64.sh"
    fi
    bash miniconda.sh -b -u -p "$HOME/miniconda3"
  elif [[ "$os_name" == "Linux" ]]; then
    # Linux installer
    echo "Detected Linux. Using Linux Miniconda installer."
    curl -o miniconda.sh "https://repo.anaconda.com/miniconda/Miniconda3-${version}-Linux-x86_64.sh"
    bash miniconda.sh -b -u -p "$HOME/miniconda3"
  else
    echo "Unsupported operating system."
    exit 1
  fi

  # Remove the installer script
  rm -f miniconda.sh

  # Add conda to PATH in .bashrc
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
