#!/bin/bash

mkdir -p ~/packages
pypi-server -p 8080 ~/packages &      ## Will listen to all IPs.


