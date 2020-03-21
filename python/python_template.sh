#!/bin/bash

pip install cookiecutter
cookiecutter https://github.com/joamatab/cookiecutter-pypackage-minimal
cp .gitcli.yml ~/.gitcli.yml

