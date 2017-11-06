```
LIMPIAR DNS

ipconfig /flushdns

################################################################################################################################
UBICACION DE OPENLDAP
/usr/local/etc/openldap

CONTRASEÑA POR DEFECTO
secret

Si aparece el error invalid credential, ingresar la contraseña vacia y volver a intentar

********************************************************************************************************************************

ACCIONES openLDAP

IMPORTAR BD: /usr/local/sbin/slapadd -n 0 -F /usr/local/etc/slapd.d -l /usr/local/etc/openldap/slapd.ldif

INICIAR LDAP: /usr/local/libexec/slapd -F /usr/local/etc/slapd.d

BUSCAR: ldapsearch -x -b 'dc=tip,dc=com,dc=uy' '(objectclass=*)'

BUSCAR: ldapsearch -x -b 'ou=Alumnos,ou=Personas,dc=tip,dc=com,dc=uy' '(objectclass=*)'

CARGAR ARCHIVO:	ldapadd -x -D "cn=Manager,dc=tip,dc=com,dc=uy" -W -f /usr/local/etc/openldap/archivo.ldif

################################################################################################################################
PASOS PARA LA CREACION DE LA ESTRUCTURA DE LA BD

0) Editar /etc/openldap/ldap.conf

BASE dc=infraestructura,dc=com,dc=uy

URI ldap://192.168.10.189

1) Copiar todos los archivos en la carpeta de instalacion de openLDAP (/usr/local/etc/openldap)
Asegurarse de que no queden espacios al final de la linea, esto genera el error 'invalid syntax'

2) Agregar en el archivo slapd.conf:		nano /usr/local/etc/openldap/slapd.conf

											include         /usr/local/etc/openldap/schema/cosine.schema
											include         /usr/local/etc/openldap/schema/inetorgperson.schema
											include         /usr/local/etc/openldap/schema/nis.schema
											
3) Agregar en el archivo slapd.ldif:		nano /usr/local/etc/openldap/slapd.ldif

											include: file:///usr/local/etc/openldap/schema/cosine.ldif
											include: file:///usr/local/etc/openldap/schema/inetorgperson.ldif
											include: file:///usr/local/etc/openldap/schema/nis.ldif
											
2) Crear directorio para la importar la bd:	mkdir /usr/local/etc/slapd.d

3) Importar la bd:							/usr/local/sbin/slapadd -n 0 -F /usr/local/etc/slapd.d -l /usr/local/etc/openldap/slapd.ldif

4) Iniciar openLDAP: 						/usr/local/libexec/slapd -F /usr/local/etc/slapd.d

5) Agregar la estructura base: 				ldapadd -x -D "cn=Manager,dc=tip,dc=com,dc=uy" -W -f /usr/local/etc/openldap/base.ldif
 
6) Agregar el resto de la estructura: 		ldapadd -x -D "cn=Manager,dc=tip,dc=com,dc=uy" -W -f /usr/local/etc/openldap/struct.ldif

7) Agregar el usuario:						ldapadd -x -D "cn=Manager,dc=tip,dc=com,dc=uy" -W -f /usr/local/etc/openldap/add-user.ldif

8) Probar funcionamiento: 					ldapsearch -x -b 'ou=Alumnos,ou=Personas,dc=tip,dc=com,dc=uy' '(objectclass=*)'

################################################################################################################################

NOTAS, esto no es necesario JORGE

CAMBIE ESTO EN slapd.conf SI DA PROBLEMAS VOLVER LA PASSWD A secret
{SSHA}Nb8oN/FidpgDQpgZHSp48/6haXFWzCS0
```
