#!/bin/bash

echo "Checking conda install for Python3 64 bits"

# Check if Conda is already installed
if [[ ! -d $HOME/miniconda3 ]]; then
  echo "Installing Conda..."

  # Download the installer using curl if wget isn't available
  if command -v wget &> /dev/null; then
    if [[ "$(uname)" == "Darwin" ]]; then
      wget -O 'miniconda3.sh' 'https://repo.anaconda.com/miniconda/Miniconda3-py311_24.7.1-0-MacOSX-x86_64.sh'
    else
      wget -O 'miniconda3.sh' 'https://repo.anaconda.com/miniconda/Miniconda3-py311_24.7.1-0-Linux-x86_64.sh'
    fi
  else
    if [[ "$(uname)" == "Darwin" ]]; then
      curl -o 'miniconda3.sh' 'https://repo.anaconda.com/miniconda/Miniconda3-py311_24.7.1-0-MacOSX-x86_64.sh'
    else
      curl -o 'miniconda3.sh' 'https://repo.anaconda.com/miniconda/Miniconda3-py311_24.7.1-0-Linux-x86_64.sh'
    fi
  fi

  # Run the installer in batch mode (-b) to skip user prompts
  bash miniconda3.sh -b -p $HOME/miniconda3
  rm miniconda3.sh

  # Initialize Conda for current shell session
  $HOME/miniconda3/bin/conda init

  # Add Conda to PATH for the session
  export PATH="$HOME/miniconda3/bin:$PATH"
  echo "Conda installation completed and added to PATH."

else
  echo "Conda is already installed."
fi

