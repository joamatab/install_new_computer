#!/bin/sh


docker pull muccg/devpi

docker run -d --name devpi \
    --publish 3141:3141 \
    --volume /srv/docker/devpi:/data \
    --env=DEVPI_PASSWORD=awsgui \
    --restart always \
    muccg/devpi
