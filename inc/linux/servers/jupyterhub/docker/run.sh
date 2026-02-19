#!/bin/bash

sudo docker run -p 8000:8000 -d --name jupyterhub jupyterhub/jupyterhub jupyterhub
