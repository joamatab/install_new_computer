#!/bin/bash

sudo cp nginx.conf.centos /etc/nginx/nginx.conf
sudo service nginx reload
sudo service nginx restart
sudo service nginx status
