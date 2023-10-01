#!/bin/bash

sudo apt-get install -y docker.io
sudo apt-get install -y docker docker-compose
sudo usermod -aG docker ${USER}

