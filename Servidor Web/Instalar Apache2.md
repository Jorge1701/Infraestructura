# Apache2

Para instalar apache se debe de primero instalar PCRE, APR y APR-Utils en ese orden.
```
# mkdir apache2
# mkdir apache2/pcre
# mkdir apache2/apr
# mkdir apache2/apr-utils
# mkdir apache2/httpd
```

`# cd apache2/pcre`


## PCRE

*ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/*
```
# wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz
# tar zxvf pcre-8.38.tar.gz
# cd pcre-8.38
# ./configure
# make
# make install
```

`# cd ../../apr`


## APR

*http://www-us.apache.org/dist//apr/*
```
# wget http://www-us.apache.org/dist//apr/apr-1.6.3.tar.gz
# tar zxvf apr-1.6.3.tar.gz
# cd apr-1.6.3
# ./configure
# make
# make install
```

`# cd ../../apr-utils`


## APR-Utils

*http://www-us.apache.org/dist//apr/*
```
# apt-get install libexpat1-dev
# wget http://www-us.apache.org/dist//apr/apr-1.6.3.tar.gz
# tar zxvf apr-util-1.6.3.tar.gz
# cd apr-util-1.6.3
# ./configure --with-apr=/usr/local/apr
# make
# make install
```

`# cd ../../httpd`


## Instalar Apache2

*http://www-us.apache.org/dist//httpd/*
```
# wget http://www-us.apache.org/dist//httpd/httpd-2.2.34.tar.gz
# tar zxvf httpd-2.2.34.tar.gz
# cd httpd-2.2.34
# ./configure --enable-ldap=shared --enable-authnz-ldap=shared --enable-lua=shared
# make
# make install
```


### Configuracion

`# nano /root/.bashrc`

> export PATH=/usr/local/apache2/bin/:$PATH

`# reboot`

#### Para iniciarlo

`# apachectl -k start`

#### Para reiniciarlo

`# apachectl -k restart`
