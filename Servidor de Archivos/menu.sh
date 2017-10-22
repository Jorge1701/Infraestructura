#!/bin/bash

echo ""
echo -e "\t==== Menu ===="
echo -e "\t1) Cargar usuario"
echo -e "\t2) Cargar Back-Up"
echo ""
echo -e "\t0) Cancelar"
echo ""

read -p "opcion: " opc

cargarUsuario() {
        # Pedir Informacion

        read -p "Usuario: " user
        read -p "Password: " pass
        read -p "Path: " path
        read -p "IP: " ip

        # Si el path no existe salir
        if [ ! -d $path ]
        then
                echo "Path no existe"
                exit
        fi

        # Ingresar usuario en sistema
        echo -e "$pass\n$pass\n\n\n\n\ny\n" | adduser $user

        # Agregar usuario a smb
        echo -e "$pass\n$pass" | smbpasswd -a $user

        # Habilitar el usuario
        smbpasswd -e $user

        archivo=/usr/local/samba/etc/smb.conf

        # Agregar el nuevo usuario al recurso Publico
        sed -i "s/FINAL_USER/$user FINAL_USER/" $archivo

        # Agregar un nuevo recurso para el usuario
        echo "" >> $archivo
        echo "[Private-$user]" >> $archivo
	echo -e "\tpath=$path" >> $archivo
        echo -e "\tread only = no" >> $archivo
        echo -e "\tguest ok = yes" >> $archivo

        # Reiniciar SMBD
        smbd restart

        # Agregar path e IP al nfs
        echo $path" "$ip"(rw)" >> /etc/exports
        chmod 777 $path

        # Restart nfs
        /etc/init.d/nfs-kernel-server restart
}

cargarBackUp() {
        # Cargar BackUp

        backup=/srv/backup
        archivo=/usr/local/samba/etc/smb.conf

        # Listar los recursos
        recursos="$(ls $backup)"

        echo -e "\t==== Recursos"
        i=1
        for rec in $recursos
        do
                echo -e "\t$i) $rec"
                i=$((i+1))
        done

        # Pedir que seleccione uno de los listados
        echo ""
        read -p "opcion: " opc

        # Obtener el nombre del seleccionado
        nombre="$(echo $recursos | cut -f$opc -d' ')"

        # Obtener todos los .tar
        respaldos=$(ls -t $backup/$nombre)

        # Mostrarlos
        i=1
        for res in $respaldos
        do
               echo -e "\t$i) $res"
                i=$((i+1))
        done

        # Pedir que seleccione uno
        echo ""
        read -p "opcion: " opc

        # Obtener el seleccionato
        seleccionado="$(echo $respaldos | cut -f$opc -d' ')"

        # Ir al recurso y descomprimir el seleccionado
        cd $backup/$nombre
        tar -xf $seleccionado

        # Obtener los directorios
        # (El unico directorio que deberia de haber seria el descomprimido)
        descomprimido="$(ls -d $backup/$nombre/*/)"

        # Obtener path del recurso
        recEncontrado=""
        pathAMover=""

        terminado="no"
        while read linea
        do
                if [ "${linea:0:1}" == "[" ]
                then
                        chars="$(echo $linea | fold -w1)"
                        for char in $chars
                        do
                                if [[ $char != "[" && $char != "]" ]]
                                then
                                        recEncontrado=$nombre"$char"
                                fi
                        done
                fi

                if [ "path" == "${linea:0:4}" ]
                then
                        pathAMover="$(echo $linea | cut -f2 -d'=')"
                        echo "Borra: $pathAMover"
                        rm -r $pathAMover
                        echo "Mover: $descomprimido a: $pathAMover"
                        mv $descomprimido $pathAMover
                        terminado="si"
		fi
                if [ "$terminado" == "si" ]
                then
                        break
                fi
        done < $archivo

        # Mover descomprimido a path del recurso correspondiente
}

case $opc in
0)
        echo "Bye! :"
        exit
;;
1)
        cargarUsuario
;;
2)
        cargarBackUp
;;
esac
