# Configuracion

Ejecutar
```
# mkdir /srv/backup
# mkdir -p /srv/samba/public
```

Crear archivo */usr/local/samba/etc/smb.conf* con el contenido
```
[Public]
	path=/srv/samba/public
	valid users = FINAL_USER
	read only = no
	guest ok = yes
```
