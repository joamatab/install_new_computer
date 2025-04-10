#!/bin/sh

sudo apt-get update -y
sudo apt-get install -y qtbase5-dev gcc g++ make libz-dev qttools5-dev libqt5xmlpatterns5-dev qtmultimedia5-dev libqt5multimediawidgets5 libqt5svg5-dev ruby ruby-dev python3 python3-dev pip wget

wget https://www.klayout.org/downloads/source/klayout-0.30.0.tar.gz
tar hzxvf klayout-0.30.0.tar.gz
cd klayout-0.30.0
./build.sh -j4 -bin /usr/local/bin/klayout      # 4 cores
pip3 install numpy
