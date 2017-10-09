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

`# cd ../apr`


## APR

*http://www-us.apache.org/dist//apr/*
```
# wget http://www-us.apache.org/dist//apr/apr-1.6.2.tar.gz
# tar zxvf apr-1.6.2.tar.gz
# cd apr-1.6.2
# ./configure
# make
# make install
```

`# cd ../apr-utils`


## APR-Utils

*http://www-us.apache.org/dist//apr/*
```
# apt-get install libexpat1-dev
# wget http://www-us.apache.org/dist//apr/apr-util-1.6.0.tar.gz
# tar zxvf apr-util-1.6.0.tar.gz
# cd apr-util-1.6.0
# ./configure --with-apr=/usr/local/apr
# make
# make install
```

`# cd ../httpd`


## Instalar Apache2

*http://www-us.apache.org/dist//httpd/*
```
# wget http://www-us.apache.org/dist//httpd/httpd-2.4.27.tar.gz
# tar zxvf httpd-2.4.27.tar.gz
# cd httpd-2.4.27
# ./configure
# make
# make install
```


## Para poder usarlo

Con el siguiente comando:

`# nano /root/.bashrc`

> export PATH=/usr/local/apache2/bin/:$PATH

`# reboot`


## Como usarlo

### Para iniciarlo

`# apachectl -k start`

### Para reiniciarlo

`# apachectl -k restart`
