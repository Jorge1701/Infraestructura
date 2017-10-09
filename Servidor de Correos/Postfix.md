# Postfix

*http://linorg.usp.br/postfix/release/official/*
```
# apt-get build-dep postfix -y
# wget http://linorg.usp.br/postfix/release/official/postfix-3.2.2.tar.gz
# tar zxvf postfix-3.2.2.tar.gz
# cd postfix-3.2.2
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
