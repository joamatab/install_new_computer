#!/bin/sh

python3 bootstrap.py --admin ubuntu
jupyter labextension install @jupyterlab/hub-extension
sudo tljh-config set user_environment.default_app jupyterlab
sudo tljh-config reload hub
cp jupyterhub_config.py /opt/tljh/config/jupyterhub_config.d/
