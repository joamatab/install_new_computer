#!/bin/bash

git clone https://github.com/jbonjean/re-search.git
cd re-search
make
mkdir -p ~/.local/bin
cp re-search ~/.local/bin

