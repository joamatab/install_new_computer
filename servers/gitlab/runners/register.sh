#!/bin/bash
# ./register.sh registration_token


REGISTRATION_TOKEN=@1
URL="http://gitlab.mywebsite.com/"

sudo gitlab-runner register -n \
  --url $URL \
  --registration-token $REGISTRATION_TOKEN \
  --executor docker \
  --description "docker-builder" \
  --docker-image "docker:latest" \
  --docker-privileged \
  --run-untagged="true" \
  --locked="false"


