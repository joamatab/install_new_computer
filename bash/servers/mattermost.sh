#!/bin/sh
# open source slack alternative

sudo apt-get update
sudo apt-get install wget
wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker ubuntu
sudo service docker start
newgrp docker

curl -L https://github.com/docker/compose/releases/download/$dockerComposeVersion/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo apt-get install git
git clone https://github.com/mattermost/mattermost-docker.git
cd mattermost-docker
docker-compose build
mkdir -pv ./volumes/app/mattermost/{data,logs,config,plugins,client-plugins}
chown -R 2000:2000 ./volumes/app/mattermost/
docker-compose up -d
