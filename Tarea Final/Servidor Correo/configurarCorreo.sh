#!/bin/bash

read -p "Ingrese la ip del servidor OpenLDAP a utilizar:" ldapServer
uidUsuario=4321
#ldapServer=

mkdir /var/vmail
useradd -u $uidUsuario vmail -g mail -s /sbin/nologin -d /var/vmail
chown -R vmail:mail /var/vmail

# configuar POSTFIX
echo "virtual_mailbox_base            = /var/vmail" >> /etc/postfix/main.cf
echo "virtual_minimum_uid             = 100" >> /etc/postfix/main.cf
echo "virtual_uid_maps                = static:$uidUsuario" >> /etc/postfix/main.cf
echo "virtual_gid_maps                = static:8" >> /etc/postfix/main.cf
echo "virtual_mailbox_domains         = proxy:ldap:\$config_directory/ldap_virtual_domains_maps.cf" >> /etc/postfix/main.cf
echo "virtual_mailbox_maps            = hash:/etc/postfix/mailboxes,proxy:ldap:\$config_directory/ldap_virtual_mailbox_maps.cf" >> /etc/postfix/main.cf
echo "virtual_alias_maps              = proxy:ldap:\$config_directory/ldap_virtual_alias_maps.cf" >> /etc/postfix/main.cf

d=/etc/postfix/ldap_virtual_domains_maps.cf

echo "server_host = ldap://$ldapServer/" >> "$d"
echo "search_base = ou=Domains,dc=infraestructura,dc=com,dc=uy" >> "$d"
echo "version = 3" >> "$d"
echo "bind = no" >> "$d"
echo "query_filter = (&(ObjectClass=dNSDomain)(dc=%s))" >> "$d"
echo "result_attribute = dc" >> "$d"

m=/etc/postfix/ldap_virtual_mailbox_maps.cf

echo "server_host = ldap://$ldapServer/" >> "$m"
echo "search_base = ou=People,dc=infraestructura,dc=com,dc=uy" >> "$m"
echo "version = 3" >> "$m"
echo "bind = no" >> "$m"
echo "query_filter = (&(objectclass=inetOrgPerson)(mail=%s))" >> "$m"
echo "result_attribute = mail" >> "$m"

a=/etc/postfix/ldap_virtual_alias_maps.cf

echo "server_host = ldap://$ldapServer/" >> "$a"
echo "search_base = ou=People,dc=infraestructura,dc=com,dc=uy" >> "$a"
echo "version = 3" >> "$a"
echo "bind = no" >> "$a"
echo "query_filter = (&(objectclass=inetLocalMailRecipient)(mailLocalAddress=%s))" >> "$a"
echo "result_attribute = mail" >> "$a"

# Configurar DOVECOT
echo "auth_mechanisms = plain" > /etc/dovecot/conf.d/10-auth.conf
echo "!include auth-ldap.conf.ext" >> /etc/dovecot/conf.d/10-auth.conf

dl=/etc/dovecot/dovecot-ldap.conf.ext
echo "hosts = $ldapServer" >> "$dl"
echo "auth_bind = no" >> "$dl"
echo "ldap_version = 3" >> "$dl"
echo "base = dc=infraestructura,dc=com,dc=uy" >> "$dl"
echo "deref = never" >> "$dl"
echo "scope = subtree" >> "$dl"
echo "user_attrs =" >> "$dl"
echo "user_filter = (&(objectclass=inetOrgPerson)(mail=%u))" >> "$dl"
echo "pass_attrs = mail=user,userPassword=password" >> "$dl"
echo "pass_filter = (&(objectclass=inetOrgPerson)(mail=%u))" >> "$dl"
echo "default_pass_scheme = SSHA" >> "$dl"

mc=/etc/dovecot/conf.d/10-mail.conf

echo "mail_location = maildir:/var/vmail/%d/%u" > "$mc"
echo "namespace inbox {" >> "$mc"
echo "   inbox = yes" >> "$mc"
echo "}" >> "$mc"
echo "mail_uid = $uidUsuario" >> "$mc"
echo "mail_gid = 8" >> "$mc"
echo "mail_privileged_group = mail" >> "$mc"
echo "mail_access_groups = mail" >> "$mc"
echo "first_valid_uid = $uidUsuario" >> "$mc"

master=/etc/dovecot/conf.d/10-master.conf

echo "service auth {" >> "$master"
echo "  unix_listener auth-userdb {" >> "$master"
echo "    mode = 0666" >> "$master"
echo "    user = vmail" >> "$master"
echo "    group = mail" >> "$master"
echo "  }" >> "$master"
echo "  unix_listener /var/spool/postfix/private/auth {" >> "$master"
echo "    mode = 0666" >> "$master"
echo "    user = postfix" >> "$master"
echo "    group = postfix" >> "$master"
echo "  }" >> "$master"
echo "}" >> "$master"

echo "log_path = /var/log/dovecot.log" >> /etc/dovecot/dovecot.conf
echo "info_log_path = /var/log/dovecot-info.log" >> /etc/dovecot/dovecot.conf

echo "lda_mailbox_autocreate = yes" >> /etc/dovecot/conf.d/15-lda.conf

rm /usr/lib/sendmail
ln -s /usr/sbin/sendmail /usr/lib/sendmail
apt-get remove exim4 exim4-base exim4-config -y

echo ""
echo "Configurado correctamente"
echo "NO OLVIDAR AGREGAR LOS USUARIOS CON EL SCRIPT agragarUsuarioPostfix.sh seguido del nombre del usuario"
