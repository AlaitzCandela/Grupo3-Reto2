# Crear usuario admin y otorgar permisos sobre la BBDD TN
mysql -u root --password="" -e "CREATE USER 'admin'@'%' IDENTIFIED BY 'admin';"
mysql -u root --password="" -e "GRANT ALL PRIVILEGES ON TN.* TO 'admin'@'%';"
