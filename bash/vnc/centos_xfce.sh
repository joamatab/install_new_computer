#!/bin/sh

sudo yum -y update
sudo yum -y install tigervnc-server xorg-x11-fonts-Type1 Xvfb
sudo yum -y groupinstall "Xfce"
sudo yum -y install epel-release
sudo yum -y install bash-completion
sudo cp vncserver@:1.service.centos vncserver@:1.service
sudo cp vncserver@:1.service /etc/systemd/system/vncserver@:1.service

vncserver
sudo systemctl daemon-reload
sudo systemctl start vncserver@:1.service
sudo systemctl enable vncserver@:1.service
mkdir -p $HOME/.vnc
cp xstartup_xfce $HOME/.vnc/xstartup
sudo systemctl daemon-reload
sudo systemctl set-default graphical.target
