#!/bin/sh

wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce_19.03.8~3-0~ubuntu-bionic_amd64.deb
wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/containerd.io_1.2.6-3_amd64.deb
wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce-cli_19.03.8~3-0~ubuntu-bionic_amd64.deb

sudo dpkg -i containerd.io_1.2.6-3_amd64.deb
sudo dpkg -i docker-ce-cli_19.03.8~3-0~ubuntu-bionic_amd64.deb
sudo dpkg -i docker-ce_19.03.8~3-0~ubuntu-bionic_amd64.deb

sudo usermod -aG docker $USER
