# Script 1

Crear el script */var/mail/mandarCorreo.sh* con el contenido
``` bash
#!/bin/bash

NOMBREUSUARIO=$USER
NOMBREDELSERVIDOR=$(hostname)
HORA=$(date '+%d/%m/%y %H:%M:%S')

{
nc localhost smtp << EOF
ehlo tip.com.uy
mail from: eventos_mailserver@tip.com.uy
rcpt to: admin@tip.com.uy
data
Subject: $NOMBREDELSERVIDOR, Nuevo inicio de sesion.
El usuario $NOMBREUSUARIO a iniciado remotamente al servidor $NOMBREDELSERVIDOR a las $HORA
.
quit
EOF
} &> /dev/null
```

Darle permisos para ejecutar
```
# chmod a+x /var/mail/mandarCorreo.sh
```

Luego por cada usuario que se quiera saber que inicio sesion agregar la siguiente linea en el archivo */home/**usuario**/.bashrc*
```
/var/mail/./mandarCorreo.sh
```
