#!/bin/bash

sudo apt-get install -y unzip
wget https://releases.hashicorp.com/terraform/0.12.6/terraform_0.12.6_linux_amd64.zip
unzip terraform_0.12.6_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform --version 
