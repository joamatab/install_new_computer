#!/bin/sh
# you can update the new packages from https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/

# wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce_19.03.8~3-0~ubuntu-bionic_amd64.deb
# wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/containerd.io_1.2.6-3_amd64.deb
# wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce-cli_19.03.8~3-0~ubuntu-bionic_amd64.deb

# sudo dpkg -i containerd.io_1.2.6-3_amd64.deb
# sudo dpkg -i docker-ce-cli_19.03.8~3-0~ubuntu-bionic_amd64.deb
# sudo dpkg -i docker-ce_19.03.8~3-0~ubuntu-bionic_amd64.deb

DOCKER=20.10.6~3-0~ubuntu-bionic_amd64.deb
CONTAINERD=1.4.4-1_amd64.deb


wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce_"$DOCKER"
wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce-cli_"$DOCKER"
wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/containerd.io_$CONTAINERD

sudo dpkg -i containerd.io_$CONTAINERD
sudo dpkg -i docker-ce-cli_$DOCKER
sudo dpkg -i docker-ce_$DOCKER


sudo usermod -aG docker $USER
