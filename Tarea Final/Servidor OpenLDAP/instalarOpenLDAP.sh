#!/bin/bash

apt-get update
apt-get install build-essential -y
apt-get build-dep openldap -y

wget ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.45.tgz
tar zxvf openldap-2.4.45.tgz 
cd openldap-2.4.45
./configure --sysconfdir=/etc
make
make install
