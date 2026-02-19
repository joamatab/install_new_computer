#!/bin/sh

sudo apt-get update -y
sudo apt-get install -y klayout

wget https://www.klayout.org/downloads/Ubuntu-24/klayout_0.30.0-1_amd64.deb
sudo dpkg -i klayout_0.30.0-1_amd64.deb
