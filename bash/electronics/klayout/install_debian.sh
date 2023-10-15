#!/bin/sh


sudo apt-get update -y
sudo apt-get install -y qtbase5-dev gcc g++ make libz-dev qttools5-dev libqt5xmlpatterns5-dev qtmultimedia5-dev libqt5multimediawidgets5 libqt5svg5-dev ruby ruby-dev python3 python3-dev pip wget

wget https://www.klayout.org/downloads/Ubuntu-22/klayout_0.28.12-1_amd64.deb
sudo dpkg -i klayout_0.28.12-1_amd64.deb
