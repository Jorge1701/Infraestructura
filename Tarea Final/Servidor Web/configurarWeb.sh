#!/bin/bash

# Hacer que las variables de entorno se carguen cada vez que se inicie el sistema
echo "export PATH=/usr/local/apache2/bin/:\$PATH" >> /root/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/lib:\$LD_LIBRARY_PATH" >> /root/.bashrc

# Agregar lineas necesarias en httpd.conf
echo "LoadModule ldap_module modules/mod_ldap.so" >> /usr/local/apache2/conf/httpd.conf
echo "LoadModule authnz_ldap_module modules/mod_authnz_ldap.so" >> /usr/local/apache2/conf/httpd.conf
echo "LoadModule cgid_module modules/mod_cgid.so" >> /usr/local/apache2/conf/httpd.conf
echo "Include /usr/local/apache2/conf/sitios.conf" >> /usr/local/apache2/conf/httpd.conf
# (Debido a estos LoadModule puede que salte al iniciar el apache: module "modulo" is already loaded, skipping (No afecta en nada))

#### Mover/Crear archivos ####

# Crear directorios para los servidores
mkdir -p /srv/www/www.servidores.com.uy/
mkdir -p /srv/logs/www.servidores.com.uy/
mkdir -p /srv/www/www.servidores.com.uy/cgi-bin/
mkdir -p /srv/www/www.infraestructura.com.uy/
mkdir -p /srv/logs/www.infraestructura.com.uy/
mkdir -p /srv/www/www.infraestructura.com.uy/cgi-bin/

# Crear archivos de logs
touch /srv/logs/www.servidores.com.uy/error.log
touch /srv/logs/www.servidores.com.uy/access.log
touch /srv/logs/www.infraestructura.com.uy/error.log
touch /srv/logs/www.infraestructura.com.uy/access.log

# Crear archivos .s de los servidores con informacion basica
declare -a arr=("dns" "http" "openldap" "ftp" "mail")

for i in "${arr[@]}"
do
        echo "<h1>Servidor $i</h1>" >> "$i.s"
        echo "No hay informacion<br/>" >> "$i.s"
done

# Llenar el archivo index.html de la pagina servidores.com.uy con la info basica
for i in *.s
do
        while read linea
        do
                echo "$linea" >> index.html
        done < "$i"
done

echo "<centrar><h1 style=\"margin: 100px\">Bienvenido!</h1></centrar>" > /srv/www/www.infraestructura.com.uy/index.html

# Mover los archivos a los lugares correspondientes
mv *.s /srv/www/www.servidores.com.uy/cgi-bin/
mv index.html /srv/www/www.servidores.com.uy/
mv ultimo_login.sh /srv/www/www.servidores.com.uy/cgi-bin/
mv sitios.conf /usr/local/apache2/conf/

# Permisos
chmod 777 /srv/www/www.servidores.com.uy/
chmod 777 /srv/www/www.servidores.com.uy/*
chmod 777 /srv/www/www.servidores.com.uy/cgi-bin/
chmod 777 /srv/www/www.servidores.com.uy/cgi-bin/*

reboot
