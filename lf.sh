#!/bin/sh
# install lf for linux

lf_bin=$(which lf) 2>&1 > /dev/null
if [[ $? != 0 ]]; then
  # go get -u github.com/gokcehan/lf
  mkdir -p ~/.local/bin
  curl -L https://github.com/gokcehan/lf/releases/download/r13/lf-linux-amd64.tar.gz | tar xzC ~/.local/bin
fi 


