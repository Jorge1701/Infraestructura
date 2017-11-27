#!/bin/bash

apt-get update
apt-get install build-essential -y
apt-get build-dep bind9 -y

mkdir servidorDNS
cd servidorDNS

wget https://www.isc.org/downloads/file/bind-9-10-6/?version=tar-gz
tar zxvf index.html\?version\=tar-gz
cd bind-9.10.6/
./configure
make
make install

cd ..
