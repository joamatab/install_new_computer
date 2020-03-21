#!/bin/sh

DIR="$HOME/emopt"

if [ -d $DIR ]; then
  cd $DIR
  git pull
else
  git clone https://github.com/anstmichaels/emopt.git ~/emopt
fi


cd  $DIR
python3 install.py
python3  setup.py install  --user
