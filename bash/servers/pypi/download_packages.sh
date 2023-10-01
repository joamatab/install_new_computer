#!/bin/bash

mkdir -p ~/packages

cd ~/packages/klive/
python setup.py sdist

cd ~/packages/ipkiss/ipkiss24
python setup.py sdist

cd ~/packages/lumerical_client
python setup.py sdist
