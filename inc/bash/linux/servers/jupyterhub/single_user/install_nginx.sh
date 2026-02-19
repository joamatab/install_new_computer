#!/bin/sh
sudo pkill apache
sudo apt remove apache
sudo apt-get install -y nginx

sudo cp nginx.conf /etc/nginx/sites-available/default
sudo service nginx reload
sudo service nginx restart
sudo service nginx status
