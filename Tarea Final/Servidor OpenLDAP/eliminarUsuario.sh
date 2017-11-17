#!/bin/bash

usuario=$1
ldapdelete -v 'uid='$usuario',ou=persona,dc=infraestructura,dc=com,dc=uy' -D 'cn=Manager,dc=infraestructura,dc=com,dc=uy' -w secret
