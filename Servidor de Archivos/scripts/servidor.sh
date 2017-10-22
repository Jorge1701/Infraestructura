#!/bin/bash
nc -l -p 10000 -v > $1

# -l: queda en escucha
# -p: Especifica el puerto
# -v: Informacion del proceso
# $1: nombre del archivo o directorio
