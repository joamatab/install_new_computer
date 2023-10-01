#!/bin/bash

# sudo apt install -y supervisor
# service supervisor restart
pip install supervisor

mkdir -p ~/packages
# devpi-server --port 4040 --serverdir ~/packages --gen-config
sudo cp config/nginx-devpi.conf /etc/nginx/sites-available/default
sudo service nginx reload
sudo service nginx restart
sudo service nginx status


supervisord -c supervisord.conf
# cp config/supervisor-devpi.conf /etc/supervisor/conf.d/
# supervisorctl status
# supervisorctl add devpi-server
# supervisorctl update
supervisorctl start devpi-server
