#!/bin/sh
# https://www.debuntu.org/how-to-bash-parameter-expansion-and-default-values/

export name_arg=$1
echo hi "${name:-joaquin}"
