#!/bin/bash

mkdir -p $HOME/efs
sudo mount -t efs fs-a39c380a $HOME/efs
sudo chown $USER $HOME/efs
