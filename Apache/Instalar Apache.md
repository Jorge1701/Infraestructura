# Apache2


Para instalar apache se debe de primero instalar PCRE, APR y APR-Utils en ese orden. Para tener las cosas organizadas creemos los siguientes directorios:

`$ mkdir apache2`

`$ mkdir apache2/pcre`

`$ mkdir apache2/apr`

`$ mkdir apache2/apr-utils`

`$ mkdir apache2/httpd`

Luego movamonos al directorio del pcre para comenzar con su instalacion

`$ cd apache2/pcre`

## PCRE

Para obtener el codigo fuente del PCRE vamos a [esta pagina](ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/) y obtenemos el link de uno de los archivos *pcre-x.xx.tar.gz* (*Nota: el archivo debe ser de **pcre** no de **pcre2***).
Como ejemplo utilizaremos el siguiente link *ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz*

$ wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz

$ tar -zxvf pcre-8.38.tar.gz

$ cd pcre-8.38

$ ./configure

$ make

$ make install

## APR

$ wget http://www-us.apache.org/dist//apr/apr-1.6.2.tar.gz

$ tar -zxvf apr-1.6.2.tar.gz

$ cd apr-1.6.2

$ ./configure

$ make

$ make install

## APR-Utils

$ apt-get install libexpat1-dev

$ wget http://www-us.apache.org/dist//apr/apr-util-1.6.0.tar.gz

$ tar -zxvf apr-util-1.6.0.tar.gz

$ cd apr-util-1.6.0

$ ./configure --with-apr=/usr/local/apr

$ make

$ make install

## Finalmente Apache2

$ wget http://www-us.apache.org/dist//httpd/httpd-2.4.27.tar.gz

$ tar -zxvf httpd-2.4.27.tar.gz

$ cd httpd-2.4.27

$ ./configure

$ make

$ make install

## Para poder usarlo

Agregar la siguiente linea al archivo /root/.bashrc

export PATH=/usr/local/apache2/bin/:$PATH

$ nano /root/.bashrc

## Como usarlo

### Para iniciarlo

$ apachectl -k start

### Para reiniciarlo

$ apachectl -k restart
