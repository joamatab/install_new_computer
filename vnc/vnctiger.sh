#!/bin/bash
# https://www.howtoforge.com/vnc-server-installation-on-centos-7

sudo yum install -y tigervnc-server
# sudo firewall-cmd --permanent --zone=public --add-service vnc-server

sudo su
systemctl daemon-reload
systemctl enable vncserver@:1.service
reboot
systemctl start vncserver@:1.service


