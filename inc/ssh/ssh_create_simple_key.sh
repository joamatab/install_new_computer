#!/bin/bash

########################################
# create SSH key and open gitlab / github
########################################

export KEY_NAME="id_ed25519"

if [ ! -f $HOME/.ssh/$KEY_NAME.pub ]; then
  echo 'Lets create a GIT credential and add it to http://github.com and/or gitlab.com'
  echo 'Go to gitlab and make sure you log in'
  read
  if [! -d /c ]; then
    open 'http://github.com'
    open 'http://gitlab.com'
  fi

  echo 'lets create an ssh key, so you can connect your computer with GIT without typing any password'
  read
  mkdir -p ~/.ssh
  ssh-keygen -f ~/.ssh/id_ed25519 -t ed25519 -N ''

  echo 'Press any key to copy the key into the clipboard, then paste the key in gitlab and/or gitlab'
  read

  if [ -d /Applications ]; then
    pbcopy < ~/.ssh/$KEY_NAME.pub # copies key to clipboard
    open 'http://gitlab.com/profile/keys'
    open 'https://github.com/settings/keys'
  elif [ -d /c ]; then
    echo 'Press any key to copy the key into the clipboard, then paste the key in gitlab'
    read
    cat ~/.ssh/$KEY_NAME.pub | clip # copies key to clipboard
  else
    xclip -sel clip < ~/.ssh/id_ed25519.pub
    open 'http://gitlab.com/profile/keys'
    open 'https://github.com/settings/keys'
    # less ~/.ssh/id_rsa.pub
  fi
fi


if [ -d /Applications ]; then
  pbcopy < ~/.ssh/$KEY_NAME.pub # copies key to clipboard
elif [ -d /c ]; then
  cat ~/.ssh/$KEY_NAME.pub | clip # copies key to clipboard
else
  xclip -sel clip < ~/.ssh/$KEY_NAME.pub
fi
