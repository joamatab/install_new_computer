#!/bin/sh

wget https://cloudron.io/cloudron-setup
chmod +x ./cloudron-setup
sudo bash cloudron-setup --provider ec2
