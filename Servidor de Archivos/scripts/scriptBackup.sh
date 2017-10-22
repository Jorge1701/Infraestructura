#!/bin/bash

#archivo=smb.conf
archivo=/usr/local/samba/etc/smb.conf
backup=/srv/backup

hacerBackUp() {
        # $1 = recurso, $2 = path

        # Nombre que va a llevar el .tar
        nombre_backup=$(date "+%d_%m_%y-%H_%M_%S".bkp)

        # Si no existe el directorio de ese recurso dentro de back up
        if [ ! -d $backup/$1 ]
        then
                # Se crea el directorio del back up
                mkdir $backup/$1

                # Nos movemos un directorio arriba del recurso a respaldar
                cd $2
                cd ..

                # Se divide el path por / y se obtiene el ultimo
                # Esto nos da el nombre del recurso, para utilizarlo en el tar
                rec="$(echo $2 | rev | cut -d'/' -f 1 | rev)"

                # Comprimimos el recurso dentro de el back up
                tar -Pcpf $backup/$1/$nombre_backup $rec
        else
                # Si ya existe la carpeta
                # Obtenemos los nombres de los backups que hay dentro de ese recurso
                todosbu="$(ls -t $backup/$1)"
                # Obtenemos el reciente
                ultimobu="$(echo $todosbu | cut -f1 -d' ')"
                # Obtenemos la informacion de este
                infovi="$(du $backup/$1/$ultimobu)"
                # Obtenemos el tamanio del mismo
                tamvi="$(echo $infovi | cut -f1 -d' ')"

                # Nos movemos un directorio arriba del recurso a respaldar
                cd $2
                cd ..

                # Se divide el path por / y se obtiene el ultimo
               # Esto nos da el nombre del recurso, para utilizarlo en el tar
                rec="$(echo $2 | rev | cut -d'/' -f1 | rev)"

                # Comprimimos el recurso dentro de el back up
                tar -Pcpf $backup/$1/$nombre_backup $rec

                # Obtenemos la info del que acabamos de comprimir
                infonu="$(du $backup/$1/$nombre_backup)"
                # Obtenemos el tamanio del que acabamos de comprimir
                tamnu="$(echo $infonu | cut -f1 -d' ')"

                # Si el tamanio del nuevo y de el que era e mas reciente
                # son iguales, entonces borramos el que acababamos de comprimir
                if [ $tamvi == $tamnu ]
                then
                       rm $backup/$1/$nombre_backup
                fi
        fi
}

# Recorrer el archivo smb.conf
nombre=""
path=""

while read linea
do
        # Si el primer caracter de la lines es [, entonces es un nombre de Recurso
        if [ "${linea:0:1}" == "[" ]
        then
                chars="$(echo $linea | fold -w1)"
                # Guardamos los caracteres de la linea, menos el [ y el ]
                # Nos quedamos solo con el nombre
                for char in $chars
                do
                        if [[ $char != "[" && $char != "]" ]]
                        then
                                nombre=$nombre"$char"
                        fi
                done
        fi

        # Si los primeros cuatro caracteres son path;
        if [ "path" == "${linea:0:4}" ]
        then
                # Dividimos por el = y tomamos el segundo (ej.: path=/home/user)
                path="$(echo $linea | cut -f2 -d'=')"
	fi

        # Si el nombre y el path no esta vacio, entonces llamamos a la funcion
        # hacerBackUp para que haga un back up de ese recurso
        if [[ $nombre != "" && $path != "" ]]
        then
                hacerBackUp $nombre $path

                # Colocamos nombre y path vacios para poder recorrer el siguiente recurso
                nombre=""
                path=""
        fi
done < $archivo
