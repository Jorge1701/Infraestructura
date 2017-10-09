# Dovecot

Pagina con codigo fuente *https://dovecot.org/releases/2.2/*.

Formato de archivo *dovecot-x.x.xx.tar.gz*.

Utilizado como ejemplo *https://dovecot.org/releases/2.2/dovecot-2.2.32.tar.gz*.

```
# apt-get build-dep dovecot -y
# wget https://dovecot.org/releases/2.2/dovecot-2.2.32.tar.gz
# tar -zxvf dovecot-2.2.32.tar.gz
# cd dovecot-2.2.32
# ./configure --sysconfdir=/etc --with-pam
# make
# make install
```

## Configuracion necesaria

```
# cp -vr /usr/local/share/doc/dovecot/example-config/* /etc/dovecot/
# cd /usr/local/share/doc/dovecot/
# chmod a+x mkcert.sh
# ./mkcert.sh
# useradd -s /sbin/nologin -r dovecot
# useradd -s /sbin/nologin -r dovenull
```
