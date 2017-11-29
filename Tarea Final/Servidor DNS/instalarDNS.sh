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
