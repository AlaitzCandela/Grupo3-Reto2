# Creamos BBDD TN
mysql -u root --password="" -e "DROP DATABASE IF EXISTS TN;"
mysql -u root --password="" -e "CREATE DATABASE IF NOT EXISTS TN;"

# Crear usuario admin y otorgar permisos sobre la BBDD TN
mysql -u root --password="" -e "CREATE USER 'admin'@'%' IDENTIFIED BY 'admin';"
mysql -u root --password="" -e "GRANT ALL PRIVILEGES ON TN.* TO 'admin'@'%';"

# Importar BBDD en TN
mysql -u admin --password="admin" TN < /vagrant/resources/bbdd_TN.sql