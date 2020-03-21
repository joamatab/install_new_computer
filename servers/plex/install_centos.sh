#!/bin/bash

mkdir -p /data/plex
mkdir -p /data/media
chmod 750 /data/plex
chmod 750 /data/media
mount /dev/sdk /data/media
mkdir -p /data/media/movies
mkdir -p /data/media/tv
chmod -R 750 /data/media
chown -R ec2-user:ec2-user /data/media
chown -R ec2-user:ec2-user /data/plex
echo \"/dev/sdk /data/media ext4 defaults,nofail 0 2\" >> /etc/fstab
yum update -y
yum install -y docker
service docker start
usermod -a -G docker ec2-user
docker create --name=plex --net=host -e VERSION=latest -e PUID=$(id -u ec2-user) -e PGID=$(id -g ec2-user) -v /data/plex:/config -v /data/media/tv:/data/tvshows -v /data/media/movies:/data/movies --restart=always linuxserver/plex
docker start plex
