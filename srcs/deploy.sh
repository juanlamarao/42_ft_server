#!/usr/bin/env bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    deploy.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: juolivei <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/10 12:30:37 by juolivei          #+#    #+#              #
#    Updated: 2020/02/10 12:30:37 by juolivei         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#configure timezone
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

#install mysql & nginx & php
aptitude install -y mariadb-server nginx php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline php-json php-mbstring php7.3-mbstring php-curl php-gd php-intl php-soap php-xml php-xmlrpc php-zip

#create web directory and change to root dir
mkdir /var/www/localhost
cd /root

#start mysql & nginx
/etc/init.d/mysql start
/etc/init.d/nginx start
/etc/init.d/php7.3-fpm start

#configure SSL
openssl req -newkey rsa:4096 -days 365 -nodes -x509 \
    -subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=localhost/OU=Development/CN=localhost/emailAddress=juolivei@localhost.dev" \
    -keyout localhost.dev.key \
    -out localhost.dev.crt  2>> /dev/null
mv localhost.dev.crt /etc/ssl/certs/
mv localhost.dev.key /etc/ssl/private/
chmod 600 /etc/ssl/certs/localhost.dev.crt /etc/ssl/private/localhost.dev.key

#install phpmyadmin
tar -xvf phpmyadmin.tar.gz
mv phpMyAdmin-4.9.0.1-all-languages /var/www/localhost/phpmyadmin
cp -pr ./config.inc.php /var/www/localhost/phpmyadmin/config.inc.php
cp -pr ./php.ini /etc/php/7.3/fpm/php.ini
cp -pr ./nginx.conf /etc/nginx/sites-available/default
chown -R www-data:www-data /var/www/localhost/phpmyadmin
echo "GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'juolivei'@'localhost' IDENTIFIED BY 'juolivei';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

#install wordpress
tar -xvf wordpress.tar.gz
cp wp-config.php wordpress/wp-config.php
mv wordpress /var/www/localhost/
chown -R www-data:www-data /var/www/localhost/wordpress
echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'juolivei';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

#import mysql wordpress dump
mysql -u root < alldatabase.sql

#clean cache
apt-get clean -y
apt-get autoclean -y
#apt-get autoremove -y
rm -f /root/php.ini
rm -f /root/deploy.sh
rm -f /root/nginx.conf
rm -f /root/wp-config.php
rm -f /root/config.inc.php
rm -f /root/alldatabase.sql
rm -f /root/wordpress.tar.gz
rm -f /root/phpmyadmin.tar.gz
