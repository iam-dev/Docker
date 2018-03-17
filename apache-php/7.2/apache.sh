#!/bin/bash
read -p 'Domain naam: ' domainvar

sed -i -e "s/\[VIRTUALHOST\]/$domainvar/g" /etc/apache2/sites-available/001-docker.conf

mkdir /var/www/html/$domainvar
mkdir /var/www/html/$domainvar/log
a2ensite 001-docker

# Restart apache
service apache2 restart