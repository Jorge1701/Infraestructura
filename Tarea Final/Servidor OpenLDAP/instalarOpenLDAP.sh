#!/bin/bash

apt-get update
apt-get install build-essential -y
apt-get build-dep openldap -y

apt-get install curl -y

echo "#!/bin/bash" >> /etc/profile.d/login.sh
echo "" >> /etc/profile.d/login.sh
echo "u=\$LOGNAME" >> /etc/profile.d/login.sh
echo "h=\$(date +%d/%m/%Y-%H:%M)" >> /etc/profile.d/login.sh
echo "" >> /etc/profile.d/login.sh
echo "curl \"www.servidores.com.uy/cgi-bin/ultimo_login.sh?servidor=openldap&usuario=\$u&hora=\$h\"" >> /etc/profile.d/login.sh
echo "" >> /etc/profile.d/login.sh
echo "{" >> /etc/profile.d/login.sh
echo "nc mail.infraestructura.com.uy smtp << EOF" >> /etc/profile.d/login.sh
echo "ehlo infraestructura.com.uy" >> /etc/profile.d/login.sh
echo "mail from: admin@infraestructura.com.uy" >> /etc/profile.d/login.sh
echo "rcpt to: admin@infraestructura.com.uy" >> /etc/profile.d/login.sh
echo "data" >> /etc/profile.d/login.sh
echo "El usuario \$u inicio sesion en el servidor ldap a las \$h" >> /etc/profile.d/login.sh
echo "." >> /etc/profile.d/login.sh
echo "quit" >> /etc/profile.d/login.sh
echo "EOF" >> /etc/profile.d/login.sh
echo "} &> /dev/null" >> /etc/profile.d/login.sh

wget ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.45.tgz
tar zxvf openldap-2.4.45.tgz 
cd openldap-2.4.45
./configure --sysconfdir=/etc --with-cyrus-sasl --with-threads --with-tls --with-yielding-select --with-mp --enable-slapd  --enable-slurpd --enable-cleartext --enable-bdb --enable-ldap --enable-monitor --enable-perl --enable-sql --enable-syslog  --enable-spasswd
make depend
make
make install
