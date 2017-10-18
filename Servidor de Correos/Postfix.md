# Postfix

*ftp://ftp.reverse.net/pub/postfix/index.html*

```
# apt-get build-dep postfix -y
# wget ftp://ftp.reverse.net/pub/postfix/official/postfix-3.2.3.tar.gz
# tar zxvf postfix-3.2.3.tar.gz
# cd postfix-3.2.3
# make
# make install
```

## Configuracion necesaria

```
# groupadd postfix
# groupadd postdrop
# useradd postfix -g postfix -s /bin/false
```

### Para iniciar

`# postfix start`

### Para reiniciar

`# postfix reload`
