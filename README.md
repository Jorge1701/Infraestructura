# Servidores en Debian 9

### En este repositorio se encontrara:

1. Documentacion para instalar distintos servidores en debian 9 (u otras distribuciones de linux) utilizando el codigo fuente descargado de las paginas oficiales.

2. Documentacion para configurar ciertas funcionalidades de los mismos.

3. Documentacion para hacer funcionar ejercicios propuestos en la clase de **Administracion de Infraestructuras** del 2017 del TIP.

### Como leer esta documentacion:

Todo lo probado en esta documentacion funciona instalando la distribucion de linux *Debian 9*, y configurandola como se muestra en el archivo *Configurar Debian 9*, esto **no significa** que no funcione en otras versiones de Debian u otras disctribuciones de linux, pero algunos comandos podrian no funcionar de la misma manera, o algunos archivos no estar hubicados en los mismos directorios.

Con esto en mente, todos los archivos de *Instalar X*, asumen que se tiene Debian 9 y se esta loguado como usuario root. A la hora de que sea necesario ejecutar algun comando se indicara de la siguiente manera:

`# comando-a-ejecutar`

### Archivos de Instalacion

La mayoria de archivos de instalacion van a tener el siguiente formato:

#### Informacion

Para todas las instalaciones vamos a utilizar el codigo fuente, por lo que lo primero es obtenerlo, en la seccion de informacion se proporcionan tres puntos para esto, los cuales se usan de la siguiente manera.

Ingresamos a la pagina del punto *(1)* y ahi estaran todas las versiones del servidor que queremos instalar, luego buscamos el archivo con el formato del punto *(2)* y le hacemos click derecho y *Copiar direccion...*, esto nos copiara al portapapeles un link como en el punto *(3)*, el link del punto *(3)* es tambien el que se utilizara como ejemplo en la parte de instalacion, pero si se desea utilizar otra version, basta con tomar otro link de la pagina proporcionada en el punto *(1)*.

1. Pagina con codigo fuente *https://www.servidor_ejemplo.org/versiones*.

2. Formato de archivo *formato_ejemplo-x.x.x.tar.gz*.

3. Utilizado como ejemplo *https://www.servidor_ejemplo.org/versiones/formato_ejemplo-1.2.3.tar.gz*.

#### Instalacion

Toda instalacion con codigo fuente sigue algunos pasos basicos, instalar dependencias, descargar el codigo fuente, descomprimir, y ejecutar tres comandos `./configure`, `make` y `make install`.

Esto se veria de la siguiente manera:
```
# apt-get build-dep servidor_ejemplo -y
# wget https://www.servidor_ejemplo.org/versiones/formato_ejemplo-1.2.3.tar.gz
# tar zxvf formato_ejemplo-1.2.3.tar.gz
# cd formato_ejemplo-1.2.3
# ./configure
# make
# make install
```

#### Configuracion necesaria

Finalmente si el servidor requiere alguna instalacion basica se mostrara en la seccion *Configuracion necesaria*.
