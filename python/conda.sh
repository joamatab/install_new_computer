#!/bin/bash
# I recommend installing miniconda with pyenv, so you can also install other python versions

echo "checking conda install for python3 64 bits"
if [[ ! -d $HOME/miniconda3 ]]; then
  echo "installing conda"
  if [[ -d /Applications ]]; then
    wget -O 'miniconda3.sh' 'https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh'
  else
    wget -O 'miniconda3.sh' 'https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh'
  fi
  bash miniconda3.sh -b
  rm miniconda3.sh
  # sudo ln -s $HOME/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh
fi

# sudo ln -sf $HOME/miniconda3/bin/python /usr/local/bin/python
# sudo ln -sf $HOME/miniconda3/bin/pip /usr/local/bin/pip

# cp $HOME/miniconda3/bin/python /usr/local/bin/python
# cp $HOME/miniconda3/bin/pip /usr/local/bin/pip
# conda install -y python=3.6
# ln -sf $HOME/miniconda3/bin/python3.6 /usr/local/bin/python
# conda create -n emopt python=2
