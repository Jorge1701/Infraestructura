#!/bin/bash

apt-get update
apt-get install build-essential -y
apt-get build-dep dovecot -y
apt-get build-dep postfix -y
apt-get install libldap2-dev -y
apt-get install curl -y

echo "#!/bin/bash" >> /etc/profile.d/login.sh
echo "" >> /etc/profile.d/login.sh
echo "u=\$LOGNAME" >> /etc/profile.d/login.sh
echo "h=\$(date +%d/%m/%Y-%H:%M)" >> /etc/profile.d/login.sh
echo "" >> /etc/profile.d/login.sh
echo "curl \"www.servidores.com.uy/cgi-bin/ultimo_login.sh?servidor=mail&usuario=\$u&hora=\$h\"" >> /etc/profile.d/login.sh

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
cd /home
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
# mv /usr/sbin/sendmail /usr/sbin/sendmail.cp
# cp /usr/lib/sendmail /usr/sbin/sendmail
