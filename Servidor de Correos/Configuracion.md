# Configuracion

Agregar al final de */etc/postfix/main.cf*
```
myhostname = debian.tip.com.uy
mydomain = tip.com.uy
inet_interfaces = all
inet_protocols = all
mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain
mynetworks_style = subnet
mynetworks = 192.168.0.0/24, 127.0.0.0/8	## OJO: la ip 192.168.0.0 es la de la red
home_mailbox = Maildir/
alias_maps = hash:/etc/aliases
smtpd_sasl_type = dovecot
smtpd_sasl_path = private/auth
smtpd_sasl_auth_enable = yes
smtpd_recipient_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination

```

### Nombre del dominio
Editar */etc/hosts* y agregar:
```
127.0.1.1 debian.tip.com.uy debian
```
