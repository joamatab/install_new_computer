#!/bin/bash

# devpi-server --serverdir newserver --port 9000 --init &

# To run the first time
# nohup devpi-server --port 4040 --start --init &

# To run after the first time
nohup devpi-server --port 4040 --start --replica-max-retries=10 &

# command=/home/ubuntu/miniconda3/bin/devpi-server --port 4040 --serverdir /home/ubuntu/packages --replica-max-retries=10 
# devpi use http://localhost:4040
# devpi login root --password ''
