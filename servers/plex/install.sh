#!/bin/bash

mkdir -p /data/plex
mkdir -p /data/media
chmod 750 /data/plex
chmod 750 /data/media
mkdir -p /data/media/movies
mkdir -p /data/media/tv
chmod -R 750 /data/media
chown -R ubuntu:ubuntu /data/media
chown -R ubuntu:ubuntu /data/plex
# echo \"/dev/sdk /data/media ext4 defaults,nofail 0 2\" >> /etc/fstab
docker create --name=plex --net=host -e VERSION=latest -e PUID=$(id -u ubuntu) -e PGID=$(id -g ubuntu) -v /data/plex:/config -v /data/media/tv:/data/tvshows -v /data/media/movies:/data/movies --restart=always linuxserver/plex
docker start plex
