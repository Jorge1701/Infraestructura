#!/bin/bash

usuario=$1
echo "$usuario@infraestructura.com.uy infraestructura.com.uy/$usuario@infraestructura.com.uy/" >> mailboxes
postmap mailboxes
