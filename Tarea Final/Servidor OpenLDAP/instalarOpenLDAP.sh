#!/bin/bash

apt-get update
apt-get install build-essential -y
apt-get build-dep openldap -y

wget ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.45.tgz
tar zxvf openldap-2.4.45.tgz 
cd openldap-2.4.45
./configure --sysconfdir=/etc --with-cyrus-sasl --with-threads --with-tls --with-yielding-select --with-mp --enable-slapd  --enable-slurpd --enable-cleartext --enable-bdb --enable-ldap --enable-monitor --enable-perl --enable-sql --enable-syslog  --enable-spasswd
make depend
make
make install
