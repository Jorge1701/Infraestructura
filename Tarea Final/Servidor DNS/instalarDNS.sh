#!/bin/bash

apt-get update
apt-get install build-essential -y
apt-get build-dep bind9 -y

apt-get install curl -y

echo "#!/bin/bash" >> /etc/profile.d/login.sh
echo "" >> /etc/profile.d/login.sh
echo "u=\$LOGNAME" >> /etc/profile.d/login.sh
echo "h=\$(date +%d/%m/%Y-%H:%M)" >> /etc/profile.d/login.sh
echo "" >> /etc/profile.d/login.sh
echo "curl \"www.servidores.com.uy/cgi-bin/ultimo_login.sh?servidor=dns&usuario=\$u&hora=\$h\"" >> /etc/profile.d/login.sh
echo "" >> /etc/profile.d/login.sh
echo "{" >> /etc/profile.d/login.sh
echo "nc mail.infraestructura.com.uy smtp << EOF" >> /etc/profile.d/login.sh
echo "ehlo infraestructura.com.uy" >> /etc/profile.d/login.sh
echo "mail from: admin@infraestructura.com.uy" >> /etc/profile.d/login.sh
echo "rcpt to: admin@infraestructura.com.uy" >> /etc/profile.d/login.sh
echo "data" >> /etc/profile.d/login.sh
echo "El usuario \$u inicio sesion en el servidor dns a las \$h" >> /etc/profile.d/login.sh
echo "." >> /etc/profile.d/login.sh
echo "quit" >> /etc/profile.d/login.sh
echo "EOF" >> /etc/profile.d/login.sh
echo "} &> /dev/null" >> /etc/profile.d/login.sh

mkdir servidorDNS
cd servidorDNS

wget https://www.isc.org/downloads/file/bind-9-10-6/?version=tar-gz
tar zxvf index.html\?version\=tar-gz
cd bind-9.10.6/
./configure
make
make install

echo "key \"rndc-key\" {" > /etc/rndc.key
echo "        algorithm hmac-md5;" >> /etc/rndc.key
echo "        secret \"DTngw5O8I5Axx631GjQ9pA==\";" >> /etc/rndc.key
echo "};" >> /etc/rndc.key

cd ..
