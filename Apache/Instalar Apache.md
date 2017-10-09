# Apache2

(*Nota: Si se ejecutan los comandos uno a uno, y se configuro el Debian de la forma correcta, no hace falta leer el resto de la informacion*)

Para instalar apache se debe de primero instalar PCRE, APR y APR-Utils en ese orden. Para tener las cosas organizadas creemos los siguientes directorios:

```
$ mkdir apache2
$ mkdir apache2/pcre
$ mkdir apache2/apr
$ mkdir apache2/apr-utils
$ mkdir apache2/httpd
```

Luego movamonos al directorio del pcre para comenzar con su instalacion

`$ cd apache2/pcre`


## PCRE

Para obtener el codigo fuente del PCRE vamos a la siguiente pagina (ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/) y obtenemos el link de uno de los archivos *pcre-x.xx.tar.gz* (*Nota: el archivo debe ser de **pcre** no de **pcre2***).

Como ejemplo utilizaremos el siguiente link *ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz*.

Luego basta con ejecutar los siguientes comandos:

```
$ wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz
$ tar zxvf pcre-8.38.tar.gz
$ cd pcre-8.38
$ ./configure
$ make
$ make install
```

Luego nos movemos al directorio del APR para comenzar con su instalacion:

`$ cd ../apr`


## APR

De la misma manera que hicimos con el PCRE obtenemos el link de un archivo *apr-x.x.x.tar.gz*, esta vez de esta pagina (http://www-us.apache.org/dist//apr/).

Como ejemplo se usara el siguiente *http://www-us.apache.org/dist//apr/apr-1.6.2.tar.gz*.

A continuacion se ejecutan los siguiente comandos:

```
$ wget http://www-us.apache.org/dist//apr/apr-1.6.2.tar.gz
$ tar zxvf apr-1.6.2.tar.gz
$ cd apr-1.6.2
$ ./configure
$ make
$ make install
```
Luego nos movemos al directorio del APR-Utils para instalarlo:

`$ cd ../apr-utils`


## APR-Utils

Aqui se hace lo mismo que en el APR, tomando un archivo de la misma pagina pero esta vez uno de los *apr-**util**-x.x.x.tar.gz*.

Como ejemplo (http://www-us.apache.org/dist//apr/apr-util-1.6.0.tar.gz).

Luego:

```
$ apt-get install libexpat1-dev
$ wget http://www-us.apache.org/dist//apr/apr-util-1.6.0.tar.gz
$ tar zxvf apr-util-1.6.0.tar.gz
$ cd apr-util-1.6.0
$ ./configure --with-apr=/usr/local/apr
$ make
$ make install
```

Finalmente para instalar el apache

`$ cd ../httpd`


## Instalar Apache2

De la misma manera que antes, codigo fuente de aqui (http://www-us.apache.org/dist//httpd/) archivo *httpd-x.x.xx.tar.gz*.

Como ejemplo *http://www-us.apache.org/dist//httpd/httpd-2.4.27.tar.gz*.

Luego:

```
$ wget http://www-us.apache.org/dist//httpd/httpd-2.4.27.tar.gz
$ tar zxvf httpd-2.4.27.tar.gz
$ cd httpd-2.4.27
$ ./configure
$ make
$ make install
```

## Para poder usarlo

Con el siguiente comando:

`$ nano /root/.bashrc`

Agregar la siguiente linea al final
> export PATH=/usr/local/apache2/bin/:$PATH

Luego precionar `Ctl + O` y `Ctl + X` para terminar de editar.

Finalmente reiniciar el sistema operativo

`$ reboot`


## Como usarlo

### Para iniciarlo

`$ apachectl -k start`

### Para reiniciarlo

`$ apachectl -k restart`
