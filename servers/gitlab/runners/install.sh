#!/bin/bash

# Install gitlab runner
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
sudo apt-get install gitlab-runner

# Install docker
sudo apt install -y docker.io
sudo apt-get install -y docker docker-compose
sudo usermod -aG docker ${USER}
sudo service docker restart

# Install docker-machine

# register gitlab
sudo gitlab-runner register
