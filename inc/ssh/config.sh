#!/bin/bash

mkdir -p ~/.config/keys
id="$HOME/.ssh/id_rsa"

for i in ip1 ip2;
do
  printf "Host s$i \n" >> $HOME/.ssh/config
  printf "  User ubuntu\n  Hostname $i \n  IdentityFile $id \n  IdentitiesOnly yes \n  StrictHostKeyChecking no\n" >> $HOME/.ssh/config
done
