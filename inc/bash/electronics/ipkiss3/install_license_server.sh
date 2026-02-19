#!/bin/bash

wget http://www.reprisesoftware.com/license_admin_kits/x64_l1.admin.tar.gz
tar -xvf x64_l1.admin.tar.gz

cp *.lic x64_l1.admin/
cp *.set x64_l1.admin/

cd x64_l1.admin
nohup ./rlm
