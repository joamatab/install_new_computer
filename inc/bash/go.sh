#!/bin/sh

# wget https://dl.google.com/go/go1.13.3.linux-amd64.tar.gz
# tar -C ~ -xzf go1.13.3.linux-amd64.tar.gz

git clone https://go.googlesource.com/go goroot
cd goroot
cd src
./all.bash
