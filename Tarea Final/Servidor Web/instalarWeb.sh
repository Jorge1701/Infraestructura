#!/bin/bash

apt-get update -y
apt-get install build-essential -y

apt-get install curl -y

echo "#!/bin/bash" >> /etc/profile.d/login.sh
echo "" >> /etc/profile.d/login.sh
echo "u=\$LOGNAME" >> /etc/profile.d/login.sh
echo "h=\$(date +%d/%m/%Y-%H:%M)" >> /etc/profile.d/login.sh
echo "" >> /etc/profile.d/login.sh
echo "curl \"www.servidores.com.uy/cgi-bin/ultimo_login.sh?servidor=http&usuario=\$u&hora=\$h\"" >> /etc/profile.d/login.sh

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

apt-get install libexpat1-dev libldap2-dev -y
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
./configure --enable-ldap=shared --enable-authnz-ldap=shared 
make
make install
