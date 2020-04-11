#!/bin/bash
# ./shell.sh registration_token


REGISTRATION_TOKEN=@1
URL="http://gitlab.mywebsite.com/"

sudo gitlab-runner register -n \
  --url $URL \
  --registration-token $REGISTRATION_TOKEN \
  --executor "docker" \
  # --docker-image "ubuntu:18.04" \
  --docker-image "python:3.7" \
  --description "docker Runner" \
  --run-untagged="true" \
  --locked="false"
