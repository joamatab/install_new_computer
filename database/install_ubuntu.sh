#!/bin/sh

sudo apt-get install -y pgcli postgresql
sudo systemctl start postgresql

sudo -u postgres createuser ubuntu
sudo -u postgres createdb -O ubuntu hackmd

