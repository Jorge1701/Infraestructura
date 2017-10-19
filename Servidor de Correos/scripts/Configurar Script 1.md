# Script 1

Crear el script */var/mail/mandarCorreo.sh* con el contenido
``` bash
#!/bin/bash

NOMBREUSUARIO=$USER
NOMBREDELSERVIDOR=$(hostname)
HORA=$(date '+%d/%m/%y %H:%M:%S')

{
postfix start
dovecot

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
