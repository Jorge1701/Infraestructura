# Configuracion

Con esta configuracion el dominio del servidor sera *tip.com.uy* (ej. correo@tip.com.uy).

### Usuarios y grupos

```
# groupadd -g 5000 vmail
# useradd -g vmail -u 5000 vmail -d /var/mail
```

### Aliases

Crear un archivo */etc/aliases* con el contenido
```
mailer-deamon: postmaster
postmaster: root
nobody: root
hostmaster: root
usenet: root
news: root
webmaster: root
www: root
ftp: root
abuse: root
noc: root
security: root
root: root
```

Luego ejecutar

`# newaliases`

### Configuracion

Crear archivo */etc/dovecot/passwd* con el siguiente formato
```
test@tip.com.uy:{PLAIN}test
usuario1@tip.com.uy:{PLAIN}u1
usuario2@tip.com.uy:{PLAIN}u2
usuario3@tip.com.uy:{PLAIN}u3
admin@tip.com.uy:{PLAIN}admin
eventos_mailserver@tip.com.uy:{PLAIN}eventos
```

Crear archivo */etc/postfix/virtual_users_list* con el contenido (basado en el archivo creado anteriormente)
```
usuario1@tip.com.uy tip.com.uy/usuario1/
usuario2@tip.com.uy tip.com.uy/usuario2/
usuario3@tip.com.uy tip.com.uy/usuario3/
test@tip.com.uy tip.com.uy/test/
admin@tip.com.uy tip.com.uy/admin/
eventos_mailserver@tip.com.uy tip.com.uy/eventos_mailserver/
```

Modificar o agregar los siguientes parametros en */etc/postfix/main.cf*
```
myhostname = debian.tip.com.uy
mydomain = tip.com.uy
inet_interfaces = all
inet_protocols = all
mydestination = localhost
mynetworks_style = subnet
mynetworks = 192.168.0.0/24, 127.0.0.0/8
home_mailbox = Maildir/
alias_maps = hash:/etc/aliases

smtpd_sasl_type = dovecot
smtpd_sasl_path = private/auth
smtpd_sasl_auth_enable = yes
smtpd_recipient_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination

virtual_mailbox_domains = localhost, tip.com.uy
virtual_mailbox_base = /var/mail/vhosts
virtual_mailbox_maps = hash:/etc/postfix/virtual_users_list
virtual_minimum_uid = 100
virtual_uid_maps = static:5000
virtual_gid_maps = static:5000
```

Agregar en */etc/dovecot/conf.d/10-mail.conf*
```
mail_location = maildir:/var/mail/vhosts/%d/%n
```

> Quiza al pedo

Agregar en */etc/dovecot/conf.d/20-pop3.conf*
```
pop3_uidl_format = %08Xu%08Xv
pop3_client_workarounds = outlook-no-nuls
```

Agregar en */etc/dovecot/conf.d/20-imap.conf*
```
imap_client_workarounds = delay-newmail
```
> Hasta aca

Agregar en */etc/dovecot/conf.d/10-auth.conf*
```
disable_plaintext_auth = no
```

Editar */etc/dovecot/conf.d/10-master.conf*
```
service auth {
   unix_listener /var/spool/postfix/private/auth {
    mode = 0600
    user = postfix
    group = postfix
  }
}
```

Editar */etc/dovecor/conf.d/auth-passwdfile.conf.ext*
```
passdb {
   driver = passwd-file
   args = username_format=%u /etc/dovecot/users
}

userdb {
   driver = static
   args = uid=vmail gid=vmail home=/var/mail/vhosts/%d/%n
}
```

Editar */etc/dovecot/conf.d/10-auth.conf* y modificar las siguientes dos lineas
```
#!include auth-system.conf.ext
!include auth-passwdfile.conf.ext
```

Luego ejecutar
```
# postmap /etc/postfix/virtual_users_list
# chown -R vmail:vmail /var/mail
```

### Nombre del dominio

Editar */etc/hosts*
```
127.0.1.1 debian.tip.com.uy debian
```

### Aplicar cambios

Hacer un reboot e iniciar los servidores con los comandos
```
# postfix start
# dovecot
```
