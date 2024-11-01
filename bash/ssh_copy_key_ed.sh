#!/bin/bash
# copy ssh key

if [ -d /Applications ]; then
  pbcopy < ~/.ssh/ed_key.pub # copies key to clipboard
elif [ -d /c ]; then
  cat ~/.ssh/ed_key.pub | clip # copies key to clipboard
else
  xclip -sel clip < ~/.ssh/ed_key.pub
fi
