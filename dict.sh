#!/bin/sh

[ ! -d cli-dictionary ] && git clone git@github.com:ropoko/cli-dictionary.git
cd cli-dictionary | exit
pip install -e .
