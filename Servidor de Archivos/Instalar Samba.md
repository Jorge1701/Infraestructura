# Samba

*https://download.samba.org/pub/samba/*
```
# apt-get build-dep samba -y
# wget http://us1.samba.org/samba/ftp/samba-latest.tar.gz
# tar zxvf samba-latest.tar.gz
# cd samba-version
# ./configure
# make
# make install
```

### Configuracion

Agregar en */root/.bashrc*

```
export PATH=/usr/local/samba/bin/:/usr/local/samba/sbin/:$PATH
```

Luego 

```
# reboot
```

### Para iniciarlo

```
# smbd
```

### Para reiniciarlo

```
# smbd restart
```
