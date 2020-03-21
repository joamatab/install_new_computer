#!/bin/bash

mkdir -p /home/ubuntu/unstable-packages
mkdir -p /home/ubuntu/stable-packages

sudo cp nginx.conf /etc/nginx/sites-available/default
sudo service nginx reload
sudo service nginx restart
sudo service nginx status

sudo pkill gunicorn

gunicorn --paste paste.ini
