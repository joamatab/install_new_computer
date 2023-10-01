#!/bin/bash

brew unlink python && brew link python
ln -sf /usr/local/bin/pip3 /usr/local/bin/pip
ln -sf /usr/local/bin/python3 /usr/local/bin/python
