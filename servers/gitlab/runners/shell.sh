#!/bin/bash
# ./shell.sh registration_token


REGISTRATION_TOKEN=@1
URL="http://gitlab.mywebsite.com/"

sudo gitlab-runner register -n \
  --url $URL \
  --registration-token $REGISTRATION_TOKEN \
  --executor "shell" \
  --description "new shell Runner (4 workers)" \
  --run-untagged="true" \
  --locked="false"
