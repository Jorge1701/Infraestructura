#!/bin/bash

apt-get build-dep apache2 -y

mkdir apache2
mkdir apache2/pcre
mkdir apache2/apr
mkdir apache2/apr-utils
mkdir apache2/httpd

cd apache2/pcre

wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.41.tar.gz
tar zxvf pcre-8.41.tar.gz
cd pcre-8.41
./configure
make
make install

cd ../../apr

wget http://www-us.apache.org/dist//apr/apr-1.6.3.tar.gz
tar zxvf apr-1.6.3.tar.gz
cd apr-1.6.3
./configure
make
make install

cd ../../apr-utils

apt-get install libexpat1-dev -y
wget http://www-eu.apache.org/dist//apr/apr-util-1.6.1.tar.gz
tar zxvf apr-util-1.6.1.tar.gz
cd apr-util-1.6.1
./configure --with-apr=/usr/local/apr --with-ldap
make
make install

cd ../../httpd

wget http://www-us.apache.org/dist//httpd/httpd-2.4.29.tar.gz
tar zxvf httpd-2.4.29.tar.gz
cd httpd-2.4.29
./configure
make
make install

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# Descomentar estos:
#LoadModule ldap_module modules/mod_ldap.so
#LoadModule authnz_ldap_module modules/mod_authnz_ldap.so
#LoadModule cgid_module modules/mod_cgid.so
