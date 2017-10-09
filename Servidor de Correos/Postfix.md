# Postfix

Pagina con codigo fuente *http://linorg.usp.br/postfix/release/official/*.

Formato de archivo *postfix-x.x.x.tar.gz*.

Utilizado como ejemplo *http://linorg.usp.br/postfix/release/official/postfix-3.2.2.tar.gz*.

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
