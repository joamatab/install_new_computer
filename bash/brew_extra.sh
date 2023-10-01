#!/bin/bash

source ./lib_sh/echos.sh
source ./lib_sh/requirers.sh


for i in qutebrowser;
do
  bin=$(which "$i") 2>&1 > /dev/null
  if [[ $? != 0 ]]; then
    echo brew cask install $i
    brew cask install $i
  else
    echo brew cask upgrade $i
    brew cask upgrade $i
  fi
done


# deprecated
# macpass
