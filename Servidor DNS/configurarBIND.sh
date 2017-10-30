#!/bin/bash

echo "Borrando configuracion anterior..."

rm /etc/namedb/*
rm /etc/named.conf

echo ""

dominios=$(cat dominios)

echo "Creando named.conf (...)"

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

cd /etc/namedb

for d in $dominios
do
        echo "Creando /etc/namedb/$d.db (...)"

        echo "\$TTL    604800" > $d.db
        echo "@       IN      SOA     ns.$d. root.$d. (" >> $d.db
        echo "                              2         ; Serial" >> $d.db
        echo "                         604800         ; Refresh" >> $d.db
        echo "                          86400         ; Retry" >> $d.db
        echo "                        2419200         ; Expire" >> $d.db
        echo "                         604800 )       ; Negative Cache TTL" >> $d.db
        echo ";" >> $d.db
        echo "        NS ns           ; debian server" >> $d.db
        echo "        MX 10 ns        ; mail exchanger" >> $d.db
        echo "" >> $d.db
        echo "ns      A        192.168.10.231" >> $d.db
        echo "" >> $d.db
        echo "$d      IN      CNAME   ns" >> $d.db
        echo "mail            IN      CNAME   ns" >> $d.db
        echo "www             IN      CNAME   ns" >> $d.db
        echo "ftp             IN      CNAME   ns" >> $d.db

        echo "zone \"$d\" {" >> $n
        echo "        type master;" >> $n
        echo "        file \"/etc/namedb/$d.db\";" >> $n
        echo "};" >> $n
        echo "" >> $n

        echo "/etc/namedb/$d.db CREADO"
done
