#!/bin/bash

sh installubuntu.sh
sudo apt-get install -y gunicorn
pip install pypiserver --pre -I --user
pip install pypi-uploader --user
sudo apt-get install -y libpq-dev python-dev
# gunicorn -w4 'pypiserver:app(root=["/home/ubuntu/packages"])'
