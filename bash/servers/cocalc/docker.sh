#!/bin/sh
# https://github.com/sagemathinc/cocalc-docker
# docker run --name=cocalc -d -v ~/cocalc:/projects -p 443:443 sagemathinc/cocalc

docker run --name=cocalc -d -v ~/cocalc:/projects -p 8080:80 sagemathinc/cocalc

