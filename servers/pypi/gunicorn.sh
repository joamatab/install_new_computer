#!/bin/bash

pip install gunicorn
pip install pypiserver
pip install paste pastedeploy gunicorn pypiserver

gunicorn -w4 'pypiserver:app("/home/ubuntu/packages")'
