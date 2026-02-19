#!/bin/bash

echo "==> Configuring SSH keys and ~/.ssh/config..."

mkdir -p ~/.ssh/keys
id="$HOME/.ssh/id_rsa"

grep -q 'Host 172.31.*' ~/.ssh/config > /dev/null 2>&1
if [[ $? != 0 ]]; then
  echo "    Adding Host 172.31.* to SSH config..."
  printf "Host 172.31.*\n" >> $HOME/.ssh/config
  printf "  IdentityFile $id \n  IdentitiesOnly yes \n  StrictHostKeyChecking no\n" >> $HOME/.ssh/config
else
  echo "    Host 172.31.* already configured."
fi

grep -q 'Host cluster.mywebsite.com' ~/.ssh/config > /dev/null 2>&1
if [[ $? != 0 ]]; then
  echo "    Adding Host cluster.mywebsite.com to SSH config..."
  printf "Host cluster.mywebsite.com\n" >> $HOME/.ssh/config
  printf "  User centos\n  IdentityFile $id\n  IdentitiesOnly yes\n  StrictHostKeyChecking no\n" >> $HOME/.ssh/config
else
  echo "    Host cluster.mywebsite.com already configured."
fi

chmod 600 ~/.ssh/config

echo "==> Done! SSH config updated."
