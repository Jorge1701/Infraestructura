#!/bin/bash

usuario=$1
cd /etc/postfix
echo "$usuario@infraestructura.com.uy infraestructura.com.uy/$usuario@infraestructura.com.uy/" >> mailboxes
postmap mailboxes
