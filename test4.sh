#!/bin/bash

for i in \
  macvim \
  keepassx \
  qutebrowser \
  rateSAKDJ \
  nextcloud \
  karabiner-elements \
  osxfuse;
do
  a=$(which $i) 2>&1 > /dev/null
  if [[ $a != 0 ]]; then
    echo "upgrade $i"
  else
    echo "install $i"
  fi
done

