#!/bin/bash

mkdir -p ~/.ssh/keys
id="$HOME/.ssh/id_rsa"


grep -q 'Host 172.31.*' ~/.ssh/config > /dev/null 2>&1
if [[ $? != 0 ]]; then
  printf "Host 172.31.*\n" >> $HOME/.ssh/config
  printf "  IdentityFile $id \n  IdentitiesOnly yes \n  StrictHostKeyChecking no\n" >> $HOME/.ssh/config
fi

grep -q 'Host cluster.mywebsite.com' ~/.ssh/config > /dev/null 2>&1
if [[ $? != 0 ]]; then
  printf "Host cluster.mywebsite.com\n" >> $HOME/.ssh/config
  printf "  User centos\n  IdentityFile $id\n  IdentitiesOnly yes\n  StrictHostKeyChecking no\n" >> $HOME/.ssh/config
fi

# cp key/id_rsa.pub ~/.ssh/keys/engineer.pub
# cp key/id_rsa ~/.ssh/keys/engineer
# chmod 600 ~/.ssh/keys/engineer
# chmod 600 ~/.ssh/keys/engineer.pub
chmod 600 ~/.ssh/config

# grep '172.*' ~/.ssh/config > /dev/null 2>&1
# if [[ $? = 0 ]]; then
#   printf "Host 172.*\n" >> $HOME/.ssh/config
#   printf "  IdentityFile $id \n  IdentitiesOnly yes \n  StrictHostKeyChecking no\n" >> $HOME/.ssh/config
# fi

# grep 'cluster.mywebsite.com' ~/.ssh/config > /dev/null 2>&1
# if [[ $? = 0 ]]; then
#   for i in cluster.mywebsite.com;
#   do
#     printf "Host cluster \n" >> $HOME/.ssh/config
#     printf "  User centos\n  Hostname $i \n  IdentityFile $id \n  IdentitiesOnly yes \n  StrictHostKeyChecking no\n" >> $HOME/.ssh/config
#   done
# fi

# mkdir -p ~/.config/keys
# id="$PWD/key/id_rsa"
# chmod 600 $id

# printf "Host 172.*\n" >> $HOME/.ssh/config
# printf "  IdentityFile $id \n  IdentitiesOnly yes \n  StrictHostKeyChecking no\n" >> $HOME/.ssh/config

## for all
# printf "Host *\n" >> $HOME/.ssh/config
# printf "  IdentityFile $id \n  IdentitiesOnly yes \n  StrictHostKeyChecking no\n" >> $HOME/.ssh/config

## avoid centos@ip
# printf "  User centos\n  Hostname $i \n  IdentityFile $id \n  IdentitiesOnly yes \n  StrictHostKeyChecking no\n" >> $HOME/.ssh/config

