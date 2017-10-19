# Filtro

Crear archivo */var/mail/filtro.sh* con el siguiente contenido
``` bash
#!/bin/sh

# Simple shell-based filter. It is meant to be invoked as follows:
#       /path/to/script -f sender recipients...

# Localize these. The -G option does nothing before Postfix 2.3.
INSPECT_DIR=/var/spool/filtro
SENDMAIL="/usr/sbin/sendmail -G -i" # NEVER NEVER NEVER use "-t" here.

# Exit codes from <sysexits.h>
EX_TEMPFAIL=75
EX_UNAVAILABLE=69

# Clean up when done or when aborting.
trap "rm -f in.$$" 0 1 2 3 15

# Start processing.
cd $INSPECT_DIR || {
    echo $INSPECT_DIR does not exist; exit $EX_TEMPFAIL; }

cat >in.$$ || { 
    echo Cannot save mail to file; exit $EX_TEMPFAIL; }

./filtro.sh in.$$

$SENDMAIL "$@" <in.$$

exit $?
```

Crear un archivo */var/spool/filtro/filtro.sh* con el contenido
```
# Contenido
```

Luego ejecutar

```
# mkdir /var/spool/filtro
# groupadd filtro
# useradd -g filtro filtro
# chown -R filtro:filtro /var/spool/filtro
# chown -R filtro:filtro /var/mail/filtro.sh
# chmod 777 /var/mail/filtro.sh
```

Editar el archivo */etc/postfix/master.cf* (*NOTA: la segunda linea ya esta, falta agregarle el content_filter*).
```
filtro unix - n n - 10 pipe flags=Rq user=filtro null_sender= argv=/var/mail/filtro.sh -f ${sender} -- ${recipient}

smtp      inet  n       -       n       -       -       smtpd -o content_filter=filtro:filtro
```
