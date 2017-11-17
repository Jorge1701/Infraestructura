#!/bin/bash

usuario=$1
pass=$2
path="/etc/openldap/"

echo "dn: uid=$usuario,ou=persona,dc=infraestructura,dc=com,dc=uy" > $path"usuario.ldif"
echo "objectClass: posixAccount" >> $path"usuario.ldif"
echo "objectClass: account" >> $path"usuario.ldif"
echo "cn: $usuario" >> $path"usuario.ldif"
echo "uidNumber: 12345" >> $path"usuario.ldif"
echo "gidNumber: 23456" >> $path"usuario.ldif"
echo "uid: $usuario" >> $path"usuario.ldif"
echo "homeDirectory: /home/$usuario" >> $path"usuario.ldif"
echo "userPassword: $pass" >> $path"usuario.ldif"

echo "Archivo de usuario creado"

ldapadd -x -D "cn=Manager,dc=infraestructura,dc=com,dc=uy" -w secret -f $path"usuario.ldif"

echo "Nuevo usuario agregado"
