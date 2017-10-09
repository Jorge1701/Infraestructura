`$ apt-get install acl attr autoconf bison build-essential debhelper dnsutils docbook-xml docbook-xsl flex gdb krb5-user libacl1-dev libaio-dev libattr1-dev libblkid-dev libbsd-dev libcap-dev libcups2-dev libgnutls28-dev libjson-perl libldap2-dev libncurses5-dev libpam0g-dev libparse-yapp-perl libpopt-dev libreadline-dev perl perl-modules pkg-config python-all-dev python-dev python-dnspython python-crypto xsltproc zlib1g-dev`

(Cuando pida nombres para algo, el primero dejarlo como esta, y los otros dos vacios)

```
# wget http://us1.samba.org/samba/ftp/samba-latest.tar.gz --no-check-certificate
# tar -zxvf samba-latest.tar.gz
# cd samba-4.6.7
# ./configure
# make
# make install
```

Agregar en y hacer reboot:
`# nano /root/.bashrc`
	export PATH=/usr/local/samba/bin/:/usr/local/samba/sbin/:$PATH

Si no esta instalado el netcat

`# apt-get install netcat -y`
