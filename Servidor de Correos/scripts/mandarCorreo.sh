#!/bin/bash

postfix start
dovecot

NOMBREUSUARIO=$USER
NOMBREDELSERVIDOR=$(hostname)
HORA=$(date '+%d/%m/%y %H:%M:%S')

desde="eventos_mailserver"
para="admin"
dominio="tip.com.uy"
subject="Subject: $NOMBREDELSERVIDOR, Nuevo inicio de sesion."
mensaje="El usuario $NOMBREUSUARIO a iniciado remotamente al servidor $NOMBREDELSERVIDOR a las $HORA"

echo -e "ehlo $dominio\nmail from: $desde@$dominio\nrcpt to: $para@$dominio\ndata\n$subject\n$mensaje\n.\nquit\n" | nc localhost smtp
