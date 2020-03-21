#!/bin/bash

sudo apt install software-properties-common python-software-properties
sudo add-apt-repository ppa:pypa/ppa
sudo apt install pipenv

pip install pipenv --user
pipenv install ipykernel
pipenv shell


# pipenv --python 2
