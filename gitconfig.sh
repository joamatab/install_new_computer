#!/bin/sh

git remote remove origin
git remote add origin git@github.com:joamatab/install_new_computer.git
git pull origin master
git push origin master
