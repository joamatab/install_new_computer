#!/bin/bash

cp key/.passwd-s3fs ~/
chmod 600 ~/.passwd-s3fs
mkdir -p ~/s3
s3fs BucketName ~/s3 -o allow_other  -o uid=1000
