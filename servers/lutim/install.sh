#!/bin/sh

git clone https://framagit.org/luc/lutim.git
cd lutim
carton install
cp lutim.conf.template lutim.conf
vi lutim.conf

