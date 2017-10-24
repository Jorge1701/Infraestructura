# Instalacion

```
# apt-get build-dep openldap -y
# get ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.45.tgz
# tar zxvf openldap-2.4.45.tgz
# cd openldap-2.4.45
# ./configure
# make depend
# make
# make install

# apt-get build-dep bind9 -y
# wget https://www.isc.org/downloads/file/bind-9-10-6/?version=tar-gz
# tar zxvf index.html\?version\=tar-gz
# cd bind-9.10.6/
# ./configure --prefix=/usr --sysconfdir=/etc --enable-threads --localstatedir=/var/state --with-libtool
# make
# make install
```
