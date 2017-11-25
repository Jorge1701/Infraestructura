#!/bin/bash

apt-get build-dep dovecot -y
apt-get build-dep postfix -y
apt-get install libldap2-dev -y

# Instalar Dovecot
wget https://dovecot.org/releases/2.2/dovecot-2.2.33.tar.gz
tar zxvf dovecot-2.2.33.tar.gz
cd dovecot-2.2.33
./configure --with-ldap --sysconfdir=/etc
make
make install

cp -vr /usr/local/share/doc/dovecot/example-config/* /etc/dovecot/
cd /usr/local/share/doc/dovecot/
chmod a+x mkcert.sh
./mkcert.sh
useradd -s /sbin/nologin -r dovecot
useradd -s /sbin/nologin -r dovenull

# Instalar Postfix
wget ftp://ftp.reverse.net/pub/postfix/official/postfix-3.2.4.tar.gz
tar zxvf postfix-3.2.4.tar.gz
cd postfix-3.2.4
make tidy
make makefiles CCARGS="-I/usr/local/include -DHAS_LDAP" AUXLIBS_LDAP="-L/usr/local/lib -lldap -L/usr/local/lib -llber"
groupadd postfix
groupadd postdrop
useradd postfix -g postfix -s /bin/false
make
make install

# 17
