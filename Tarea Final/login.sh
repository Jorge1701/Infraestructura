#!/bin/bash

s=SERVIDOOOOOOOOR
u=\$LOGNAME
h=\$(date +%d/%m/%Y-%H:%M)

curl \"www.servidores.com.uy/cgi-bin/ultimo_login.sh?servidor=\$s&usuario=\$u&hora=\$h\"

{
nc mail.infraestructura.com.uy smtp << EOF
ehlo infraestructura.com.uy
mail from: admin@infraestructura.com.uy
rcpt to: admin@infraestructura.com.uy
data
El usuario \$u inicio sesion en el servidor \$s a las \$h
.
quit
EOF
} &> /dev/null
