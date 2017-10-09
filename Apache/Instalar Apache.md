# Apache2

(*Nota: Si se ejecutan los comandos uno a uno, y se configuro el Debian de la forma correcta, no hace falta leer el resto de la informacion*)

Para instalar apache se debe de primero instalar PCRE, APR y APR-Utils en ese orden. Para tener las cosas organizadas creemos los siguientes directorios:

```
# mkdir apache2
# mkdir apache2/pcre
# mkdir apache2/apr
# mkdir apache2/apr-utils
# mkdir apache2/httpd
```

Luego movamonos al directorio del pcre para comenzar con su instalacion

`# cd apache2/pcre`


## PCRE

Pagina con codigo fuente *ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/*.

Formato de archivo *pcre-x.xx.tar.gz*.

Utilizado como ejemplo *ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz*.
```
# wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz
# tar zxvf pcre-8.38.tar.gz
# cd pcre-8.38
# ./configure
# make
# make install
```
Luego nos movemos al directorio del APR para comenzar con su instalacion:

`# cd ../apr`


## APR

Pagina con codigo fuente *http://www-us.apache.org/dist//apr/*.

Formato de archivo *apr-x.x.x.tar.gz*.

Utilizado como ejemplo *http://www-us.apache.org/dist//apr/apr-1.6.2.tar.gz*.
```
# wget http://www-us.apache.org/dist//apr/apr-1.6.2.tar.gz
# tar zxvf apr-1.6.2.tar.gz
# cd apr-1.6.2
# ./configure
# make
# make install
```
Luego nos movemos al directorio del APR-Utils para instalarlo:

`# cd ../apr-utils`


## APR-Utils

Pagina con codigo fuente *http://www-us.apache.org/dist//apr/*.

Formato de archivo *apr-**util**-x.x.x.tar.gz*.

Utilizado como ejemplo *http://www-us.apache.org/dist//apr/apr-util-1.6.0.tar.gz*.
```
# apt-get install libexpat1-dev
# wget http://www-us.apache.org/dist//apr/apr-util-1.6.0.tar.gz
# tar zxvf apr-util-1.6.0.tar.gz
# cd apr-util-1.6.0
# ./configure --with-apr=/usr/local/apr
# make
# make install
```
Finalmente para instalar el apache

`# cd ../httpd`


## Instalar Apache2


Pagina con codigo fuente *http://www-us.apache.org/dist//httpd/*.

Formato de archivo *httpd-x.x.xx.tar.gz*.

Utilizado como ejemplo *http://www-us.apache.org/dist//httpd/httpd-2.4.27.tar.gz*.
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

Agregar la siguiente linea al final
> export PATH=/usr/local/apache2/bin/:$PATH

Luego precionar `Ctrl + O` y `Ctrl + X` para terminar de editar.

Finalmente reiniciar el sistema operativo

`# reboot`


## Como usarlo

### Para iniciarlo

`# apachectl -k start`

### Para reiniciarlo

`# apachectl -k restart`
