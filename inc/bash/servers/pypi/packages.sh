#!/bin/bash
# pull all packages


for package in ipkiss klive
do
  cd ~/$package
  git pull
  python setup.py sdist
done
