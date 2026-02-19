#!/bin/bash

mkdir -p ~/s3

cp key/.passwd-s3fs ~/
chmod 600 ~/.passwd-s3fs

sudo cp fuse.conf /etc/fuse.conf
sudo cp key/.passwd-s3fs /etc/passwd-s3fs
sudo chmod 600 /etc/passwd-s3fs

echo "s3fs#bucketName $HOME/s3 fuse _netdev,allow_other,uid=1000 0 0" | sudo tee -a /etc/fstab
