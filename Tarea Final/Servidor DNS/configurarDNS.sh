#!/bin/bash

echo "key \"rndc-key\" {" > /etc/rndc.key
echo "        algorithm hmac-md5;" >> /etc/rndc.key
echo "        secret "DTngw5O8I5Axx631GjQ9pA==";" >> /etc/rndc.key
echo "};" >> /etc/rndc.key

rm /etc/namedb/*
rm /etc/named.conf

n="/etc/named.conf"

echo "include \"/etc/rndc.key\";" > $n
echo "" >> $n
echo "options {" >> $n
echo "        directory \"/etc/namedb\";" >> $n
echo "" >> $n
echo "        auth-nxdomain no;" >> $n
echo "        listen-on-v6 { none; };" >> $n
echo "" >> $n
echo "        forwarders {" >> $n
echo "                200.40.30.245; 200.40.220.245;" >> $n
echo "        };" >> $n
echo "};" >> $n
echo "" >> $n
echo "zone \"infraestructura.com.uy\" {" >> $n
echo "        type master;" >> $n
echo "        file \"/etc/namedb/infraestructura.com.uy.db\";" >> $n
echo "};" >> $n
echo "" >> $n
echo "zone \"servidores.com.uy\" {" >> $n
echo "        type master;" >> $n
echo "        file \"/etc/namedb/servidores.com.uy.db\";" >> $n
echo "};" >> $n

cp *.db /etc/namedb/
