# Configuracion

Ubicar los archivos .sh que estan en este repositorio, en las siguientes rutas
```
/srv/menu.sh
/srv/servidor.sh
/srv/scriptBackup.sh
```

Luego darle permisos
```
# chmod 777 /srv/menu.sh
# chmod 777 /srv/servidor.sh
# chmod 777 /srv/scriptBackup.sh
```

El archivo *cliente.sh* estara ubicado en una maquina cliente.

### Tarea programada

Ejecutar

```
# crontab -e
```

Si es la primera vez nos aparecera lo siguiente
```
no crontab for root - using an empty one

Select an editor.  To change later, run 'select-editor'.
  1. /bin/nano        <---- easiest
  2. /usr/bin/vim.tiny

Choose 1-2 [1]:
```

Ingresar 1 o 2, para utilizar un editor de texto, luego agregar la siguiente linea al final
```
*/5 * * * * /srv/scriptBackup.sh
```
