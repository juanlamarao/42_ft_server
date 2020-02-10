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

#update system
apt update

#dependencias
apt install -y wget aptitude curl
mkdir /var/www/localhost

#configure timezone
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

#install mysql & nginx & php
aptitude install -y mariadb-server nginx php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline php-json php-mbstring php7.3-mbstring php-curl php-gd php-intl php-soap php-xml php-xmlrpc php-zip

#clean cache
apt clean -y
apt autoclean -y
apt autoremove -y

#start mysql & nginx
/etc/init.d/mysql start
/etc/init.d/nginx start
/etc/init.d/php7.3-fpm start

#configure SSL
openssl req -newkey rsa:4096 -days 365 -nodes -x509 \
    -subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=localhost/OU=Development/CN=localhost/emailAddress=juolivei@localhost.dev" \
    -keyout localhost.dev.key \
    -out localhost.dev.crt
cp localhost.dev.crt /etc/ssl/certs/
cp localhost.dev.key /etc/ssl/private/
chmod 600 /etc/ssl/certs/localhost.dev.crt /etc/ssl/private/localhost.dev.key

#install phpmyadmin
#wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv phpMyAdmin-4.9.0.1-all-languages /var/www/localhost/phpmyadmin/
cp -pr ./config.ini.php /var/www/localhost/phpmyadmin/config.inc.php
cp -pr ./nginx.conf /etc/nginx/sites-available/default
#chmod 755 /var/www/localhost
chown -R www-data:www-data /var/www/localhost/phpmyadmin
echo "GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'juolivei'@'localhost' IDENTIFIED BY 'juolivei';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

#install wordpress
#curl -LO https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cp wp-config.php wordpress/wp-config.php
mv wordpress /var/www/localhost/
chown -R www-data:www-data /var/www/localhost/wordpress
echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'juolivei';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

#import mysql wordpress dump
mysql -u root -p wordpress < wordpress.sql

#restart services
/etc/init.d/mysql restart
/etc/init.d/nginx restart
/etc/init.d/php7.3-fpm restart
