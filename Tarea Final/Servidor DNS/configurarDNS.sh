#!/bin/bash

correo=192.168.10.251
web=192.168.10.253
openldap192.168.10.149
nfs=192.168.10.101

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

in=/etc/namedb/infraestructura.com.uy.db

echo "\$TTL    604800" > "$in"
echo "@       IN      SOA     ns.infraestructura.com.uy. root.infraestructura.com.uy. (" >> "$in"
echo "                              2         ; Serial" >> "$in"
echo "                         604800         ; Refresh" >> "$in"
echo "                          86400         ; Retry" >> "$in"
echo "                        2419200         ; Expire" >> "$in"
echo "                         604800 )       ; Negative Cache TTL" >> "$in"
echo ";" >> "$in"
echo "        NS ns           ; debian server" >> "$in"
echo "        MX 10 ns        ; mail exchanger" >> "$in"
echo "" >> "$in"
echo "ns      A        $web" >> "$in"
echo "" >> "$in"
echo "infraestructura.com.uy      IN      CNAME   ns" >> "$in"
echo "mail    IN      A       $correo" >> "$in"
echo "www     IN      A       $web" >> "$in"
echo "ldap    IN      A       $openldap" >> "$in"
echo "ftp     IN      A       $nfs" >> "$in"

sr=/etc/namedb/servidores.com.uy.db

echo "\$TTL    604800" > "$sr"
echo "@       IN      SOA     ns.servidores.com.uy. root.servidores.com.uy. (" >> "$sr"
echo "                              2         ; Serial" >> "$sr"
echo "                         604800         ; Refresh" >> "$sr"
echo "                          86400         ; Retry" >> "$sr"
echo "                        2419200         ; Expire" >> "$sr"
echo "                         604800 )       ; Negative Cache TTL" >> "$sr"
echo ";" >> "$sr"
echo "        NS ns           ; debian server" >> "$sr"
echo "        MX 10 ns        ; mail exchanger" >> "$sr"
echo "" >> "$sr"
echo "ns      A        $web" >> "$sr"
echo "" >> "$sr"
echo "servidores.com.uy      IN      CNAME   ns" >> "$sr"
echo "www     IN      A       $web" >> "$sr"
