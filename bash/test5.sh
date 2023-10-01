#!/bin/bash

source ./lib_sh/echos.sh
source ./lib_sh/requirers.sh

for i in \
  macvim \
  rateSAKDJ;
do
  require_brew $i
done
