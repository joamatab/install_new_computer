#!/bin/bash
# copy ssh key

export KEY_NAME="id_ed25519"

if [ -d /Applications ]; then
  pbcopy < ~/.ssh/id_rsa.pub # copies key to clipboard
elif [ -d /c ]; then
  cat ~/.ssh/id_rsa.pub | clip # copies key to clipboard
else
  xclip -sel clip < ~/.ssh/$KEY_NAME.pub
fi
