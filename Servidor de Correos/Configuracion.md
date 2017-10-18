# Configuracion

### Usuarios y grupos
```
# groupadd -g 5000 vmail
# useradd -u 5000 -g vmail -s /usr/bin/nologin -d /home/vmail -m vmail
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

Modificar o agregar los siguientes parametros en */etc/postfix/main.cf*
```
myhostname = debian.tip.com.uy
mydomain = tip.com.uy
inet_interfaces = all
inet_protocols = all
mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain
mynetworks_style = subnet
mynetworks = 192.168.0.0/24, 127.0.0.0/8
home_mailbox = Maildir/
alias_maps = hash:/etc/aliases
smtpd_sasl_type = dovecot
smtpd_sasl_path = private/auth
smtpd_sasl_auth_enable = yes
smtpd_recipient_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination
```

Agregar en */etc/dovecot/conf.d/10-mail.conf*
```
mail_location = maildir:~/Maildir
```

Agregar en */etc/dovecot/conf.d/20-pop3.conf*
```
pop3_uidl_format = %08Xu%08Xv
pop3_client_workarounds = outlook-no-nuls
```

Agregar en */etc/dovecot/conf.d/20-imap.conf*
```
imap_client_workarounds = delay-newmail
```

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

Crear archivo */etc/dovecot/passwd*, para los usuarios del servidor de correo, con el siguiente formato
```
usuario@tip.com.uy:{PLAIN}password
usuario1@tip.com.uy:{PLAIN}u1
usuario2@tip.com.uy:{PLAIN}u2
usuario3@tip.com.uy:{PLAIN}u3
```

Editar */etc/dovecot/conf.d/auth-system.conf.ext*
```
passdb {
   driver = passwd-file
   args = /etc/dovecot/passwd
}

userdb{
   driver = static
   args = uid=vmail gid=vmail home=/home/vmail/%d/%n
}
```

### Nombre del dominio

Editar */etc/hosts*
```
127.0.1.1 debian.tip.com.uy debian
```
