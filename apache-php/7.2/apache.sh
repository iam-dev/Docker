#!/bin/bash
sed -i -e "s/\[VIRTUALHOST\]/$VIRTUALHOST/g" /etc/apache2/sites-available/001-docker.conf

a2ensite 001-docker

# Start apache
/usr/sbin/apache2ctl -D FOREGROUND