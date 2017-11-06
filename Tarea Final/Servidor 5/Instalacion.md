# Instalacion

```
# apt-get build-dep openldap -y
# wget ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.45.tgz
# tar zxvf openldap-2.4.45.tgz
# cd openldap-2.4.45
# ./configure --sysconfdir=/etc
# make depend
# make
# make test
# make install
```
