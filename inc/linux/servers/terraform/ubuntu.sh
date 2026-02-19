#!/bin/bash

sudo apt-get install -y unzip
wget https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip
unzip terraform_1.4.6_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform --version
