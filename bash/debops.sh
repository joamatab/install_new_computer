#!/bin/sh

sudo apt install python3-future python3-ldap python3-netaddr \
                 python3-dnspython python3-passlib python3-openssl

sudo apt install build-essential python3-dev libffi-dev libssl-dev \
                 libsasl2-dev libldap2-dev python3-pip

virtualenv ~/src/venv/debops
cd ~/src/venv/debops
source bin/activate

pip3 install --user debops[ansible]

