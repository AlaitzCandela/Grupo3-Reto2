#!/usr/bin/env bash

# Actualizar lista dependencias
apt-get update

# Editor vim
apt-get install vim  -y

# Instalar apache, mysql client y php (y múltiples módulos de php) 
# Lista de módulos php https://www.php.net/manual/en/extensions.alphabetical.php
apt-get install apache2 -y
apt-get install mysql-client libmysqlclient-dev -y
apt-get install libapache2-mod-php7.2 php7.2 php7.2-mysql -y
apt-get install php7.2-mbstring php7.2-curl php7.2-intl php7.2-gd php7.2-zip -y
apt-get install --reinstall ca-certificates -y

# Habilitar mod_rewrite en apache
a2enmod rewrite
a2enmod actions

# Arrancar el servidor apache
service apache2 restart

# Instalar mysql server
apt-get install mysql-server -y

# [MySQL] Cambiar la contraseña a root para utilizarlo
service mysql start
mysql -u root --password="" -e "update mysql.user set authentication_string=password(''), plugin='mysql_native_password' where user='root';"
mysql -u root --password="" -e "flush privileges;"

# TODO:
# - Si el servidor es producción: volver a modificar la contraseña root en mysql al finalizar el despliegue 
# 																			  (después de los demás scripts)