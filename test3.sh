#!/bin/bash
# a=$(which ls)

a=$(command -v ls)

if [[ $a != 0 ]]; then
  echo "command worked: output $a"
else
  echo "command did NOT worked: output $a"
fi
