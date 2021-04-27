#!/bin/bash

sudo pkill python
sudo pkill node
jupyterhub --config=jupyterhub_config.py  &
