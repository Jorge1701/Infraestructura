#!/bin/bash

# Separar la consulta en variables ($servidor, $hora, $usuario)
old=IFS
IFS="&"
eval $QUERY_STRING
IFS=old

# Sobre escribir el archivo de informacion del servidor $servidor con los nuevos datos
echo "<h1>Servidor $servidor</h1>" > "$servidor.s"
echo "Usuario: $usuario" >> "$servidor.s"
echo "hora: $hora" >> "$servidor.s"

# Cargar todos los archivos de informacion en un index.html
for i in *.s
do
	while read linea
	do
		echo "$linea" >> index.html
	done < "$i"
done

# Mover el index.html creado para que reemplaze al anterior
mv index.html ..
