#!/bin/bash

docker pull gitlab/gitlab-runner:latest
docker stop gitlab-runner && docker rm gitlab-runner

docker run -d \
  --name gitlab-runner \
  --restart always \
  -v $HOME/gitlab-runner-volume/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest
