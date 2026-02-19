#!/bin/bash

sudo apt-get update
sudo apt-get install -y curl openssh-server ca-certificates
sudo apt-get install -y postfix
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash

sudo EXTERNAL_URL="http://gitlab.mywebsite.com" apt-get install gitlab-ee
sudo gitlab-ctl status

sudo pip install --upgrade python-gitlab
