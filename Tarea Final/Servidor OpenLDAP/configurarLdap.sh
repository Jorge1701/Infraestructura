#!/bin/bash

read -p "Ingrese la ip de su maquina:" ip

path="/etc/openldap/"

#Configurar en que ip quedara funcionando el servidor y su estructura base
echo "BASE dc=infraestructura,dc=com,dc=uy" > $path"ldap.conf"
echo "URI ldap://$ip" >> $path"ldap.conf"


#Configurar base de datos y estructura en slapd.conf
echo "" >> $path"slapd.conf"
echo "include         /etc/openldap/schema/cosine.schema" >> $path"slapd.conf"
echo "include         /etc/openldap/schema/inetorgperson.schema" >> $path"slapd.conf"
echo "include         /etc/openldap/schema/nis.schema" >> $path"slapd.conf"
echo "include         /etc/openldap/schema/misc.schema" >> $path"slapd.conf"
echo "" >> $path"slapd.conf"
echo "database        mdb" >> $path"slapd.conf"
echo "maxsize         1073741824" >> $path"slapd.conf"
echo "suffix          'dc=infraestructura,dc=com,dc=uy'" >> $path"slapd.conf"
echo "rootdn          'cn=Manager,dc=infraestructura,dc=com,dc=uy'" >> $path"slapd.conf"
echo "rootpw          secret" >> $path"slapd.conf"
echo "directory       /usr/local/var/openldap-data" >> path"slapd.conf"
echo "index   objectClass     eq" >> path"slapd.conf"
echo "" >> $path"slapd.conf"
echo "index   cn              pres,sub,eq" >> $path"slapd.conf"
echo "index   sn              pres,sub,eq" >> $path"slapd.conf"
echo "index   uid             pres,sub,eq" >> $path"slapd.conf"
echo "index   displayName     pres,sub,eq" >> $path"slapd.conf"
echo "index   default         sub" >> $path"slapd.conf"
echo "index   uidNumber       eq" >> $path"slapd.conf"
echo "index   gidNumber       eq" >> $path"slapd.conf"
echo "index   mail,givenName  eq,subinitial" >> $path"slapd.conf"


#Configurar base de datos y estructura en slapd.ldif
echo "" >> $path"slapd.ldif"
echo "include: file:///etc/openldap/schema/cosine.ldif" >> $path"slapd.ldif"
echo "include: file:///etc/openldap/schema/inetorgperson.ldif" >> $path"slapd.ldif"
echo "include: file:///etc/openldap/schema/nis.ldif" >> $path"slapd.ldif"
echo "include: file:///etc/openldap/schema/misc.ldif" >> $path"slapd.ldif"
echo "" >> $path"slapd.ldif"
echo "dn: olcDatabase=mdb,cn=config" >> $path"slapd.ldif"
echo "objectClass: olcDatabaseConfig" >> $path"slapd.ldif"
echo "objectClass: olcMdbConfig" >> $path"slapd.ldif"
echo "olcDatabase: mdb" >> $path"slapd.ldif"
echo "OlcDbMaxSize: 1073741824" >> $path"slapd.ldif"
echo "olcSuffix: dc=infraestructura,dc=com,dc=uy" >> $path"slapd.ldif"
echo "olcRootDN: cn=Manager,dc=infraestructura,dc=com,dc=uy" >> $path"slapd.ldif"
echo "olcRootPW: secret" >> $path"slapd.ldif"
echo "olcDbDirectory: /usr/local/var/openldap-data" >> $path"slapd.ldif"
echo "olcDbIndex: objectClass eq" >> $path"slapd.ldif"

#Crear directorio para la base de datos
mkdir /etc/slapd.d

#Importar base de datos
/usr/local/sbin/slapadd -n 0 -F /etc/slapd.d -l $path"slapd.ldif"

#Iniciar openldap
/usr/local/libexec/slapd -F /etc/slapd.d

#Crear estructura base
echo "dn: dc=infraestructura,dc=com,dc=uy" > $path"base.ldif"
echo "objectclass: dcObject" >> $path"base.ldif"
echo "objectclass: organization" >> $path"base.ldif"
echo "o: Infraestructura" >> $path"base.ldif"
echo "dc: infraestructura" >> $path"base.ldif"
echo "" >> $path"base.ldif"
echo "dn: cn=Manager,dc=infraestructura,dc=com,dc=uy" >> $path"base.ldif"
echo "objectclass: organizationRole" >> $path"base.ldif"
echo "cn: Manager" >> $path"base.ldif"

#Agregar estructura base
ldapadd -x -D "cn=Manager,dc=infraestructura,dc=com,dc=uy" -w secret -f $path"base.ldif"

#Crear estructura
echo "dn: ou=People,dc=infraestructura,dc=com,dc=uy" >> $path"estructura.ldif"
echo "objectClass: top" >> $path"estructura.ldif"
echo "objectClass: organizationalUnit" >> $path"estructura.ldif"
echo "ou: People" >> $path"estructura.ldif"
echo "" >> $path"estructura.ldif"
echo "dn: ou=Domains,dc=infraestructura,dc=com,dc=uy" >> $path"estructura.ldif"
echo "objectClass: top" >> $path"estructura.ldif"
echo "objectClass: organizationalUnit" >> $path"estructura.ldif"
echo "ou: Domains" >> $path"estructura.ldif"
echo "" >> $path"estructura.ldif"
echo "dn: ou=archivos,dc=infraestructura,dc=com,dc=uy" >> $path"estructura.ldif"
echo "objectClass: organizationalUnit" >> $path"estructura.ldif"
echo "ou: archivos" >> $path"estructura.ldif"
echo "" >> $path"estructura.ldif"
echo "dn: dc=infraestructura.com.uy,ou=Domains,dc=infraestructura,dc=com,dc=uy" >> $path"estructura.ldif"
echo "objectClass: top" >> $path"estructura.ldif"
echo "objectClass: domain" >> $path"estructura.ldif"
echo "objectClass: dNSDomain" >> $path"estructura.ldif"
echo "dc: infraestructura.com.uy" >> $path"estructura.ldif"
echo "" >> $path"estructura.ldif"
echo "dn: uid=prueba,ou=People,dc=infraestructura,dc=com,dc=uy" >> $path"estructura.ldif"
echo "objectClass: inetLocalMailRecipient" >> $path"estructura.ldif"
echo "objectClass: posixAccount" >> $path"estructura.ldif"
echo "objectClass: top" >> $path"estructura.ldif"
echo "objectClass: person" >> $path"estructura.ldif"
echo "objectClass: organizationalPerson" >> $path"estructura.ldif"
echo "objectClass: inetOrgPerson" >> $path"estructura.ldif"
echo "cn: prueba" >> $path"estructura.ldif"
echo "gidNumber: 3001" >> $path"estructura.ldif"
echo "homeDirectory: /home/prueba" >> $path"estructura.ldif"
echo "sn: prueba" >> $path"estructura.ldif"
echo "uid: prueba" >> $path"estructura.ldif"
echo "uidNumber: 3000" >> $path"estructura.ldif"
echo "givenName: Prueba" >> $path"estructura.ldif"
echo "loginShell: /bin/bash" >> $path"estructura.ldif"
echo "mail: prueba@infraestructura.com.uy" >> $path"estructura.ldif"
echo "mailLocalAddress: prueba@infraestructura.com.uy" >> $path"estructura.ldif"
echo "o: eSource" >> $path"estructura.ldif"
echo "userPassword:: e1NTSEF9cmZkZjZDL3NxR25lbE9KK1NXU0dDcnF5eWpzQUtHUVU4UFNXVFE9P" >> $path"estructura.ldif"
echo " Q==" >> $path"estructura.ldif"

#Agregar estructura
ldapadd -x -D "cn=Manager,dc=infraestructura,dc=com,dc=uy" -w secret -f $path"estructura.ldif"
