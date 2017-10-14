# Configurar Debian 9

Como usuario root:

`# nano /etc/apt/source.list`

``` bash
# Contenido del archivo /etc/apt/source.list

# deb cdrom:[Debian GNU/Linux 9.1.0 _Stretch_ - Official i386 DVD Binary-1 20170722-12:45]/ stretch con$

# deb cdrom:[Debian GNU/Linux 9.1.0 _Stretch_ - Official i386 DVD Binary-1 20170722-12:45]/ stretch con$

deb http://security.debian.org/debian-security stretch/updates main contrib
deb-src http://security.debian.org/debian-security stretch/updates main contrib

# stretch-updates, previously known as 'volatile'
# A network mirror was not selected during install.  The following entries
# are provided as examples, but you should amend them as appropriate
# for your mirror of choice.

deb http://deb.debian.org/debian/ stretch main
deb-src http://deb.debian.org/debian/ stretch main
```

`# apt-get update`

`# apt-get install build-essential -y`
