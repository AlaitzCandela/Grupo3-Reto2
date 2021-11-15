# Netplan: direcciones IP
cp /vagrant/resources/netplan.yaml /etc/netplan/50-vagrant.yaml
netplan apply



# Apache2: configuración sites-available / sites-enabled
cp /vagrant/resources/apache2-site.conf /etc/apache2/sites-available/main-server-site.conf
a2dissite 000-default.conf
a2ensite main-server-site.conf
systemctl reload apache2

# Apache2: dir conf (para que priorice buscar .php sobre .html)
cp /vagrant/resources/apache2-dir.conf /etc/apache2/mods-enabled/dir.conf
systemctl reload apache2

