#!/bin/sh
# adds Joaquin's SSH key for remote SSH access to this machine

mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys
cat ssh/id_rsa.pub >> ~/.ssh/authorized_keys
