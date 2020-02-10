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

#update system
apt-get update

#dependencias
apt-get install -y aptitude apt-utils
echo "\n\nFASE -1 OKAAAAAAAAY\n\n\n"
sleep 6

#install mysql & nginx & php
aptitude install -y mariadb-server
echo "\n\nFASE 0 OKAAAAAAAAY\n\n\n"
sleep 6

aptitude install -y nginx
echo "\n\nFASE 1 OKAAAAAAAAY\n\n\n"
sleep 6
aptitude install -y php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline php-json php-mbstring php7.3-mbstring
echo "\n\nFASE 2 OKAAAAAAAAY\n\n\n"
sleep 6
aptitude install -y php-curl php-gd php-intl php-soap php-xml php-xmlrpc php-zip
echo "\n\nFASE 3 OKAAAAAAAAY\n\n\n"
sleep 6

#clean cache
apt-get clean -y
apt-get autoclean -y
apt-get autoremove -y

#create web directory and change to root dir
mkdir /var/www/localhost
cd /root
echo "\n\nFASE 4 OKAAAAAAAAY\n\n\n"
sleep 6

#start mysql & nginx
/etc/init.d/mysql start
/etc/init.d/nginx start
/etc/init.d/php7.3-fpm start
echo "\n\nFASE 5 OKAAAAAAAAY\n\n\n"
sleep 6

#configure SSL
openssl req -newkey rsa:4096 -days 365 -nodes -x509 \
    -subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=localhost/OU=Development/CN=localhost/emailAddress=juolivei@localhost.dev" \
    -keyout localhost.dev.key \
    -out localhost.dev.crt
cp localhost.dev.crt /etc/ssl/certs/
cp localhost.dev.key /etc/ssl/private/
chmod 600 /etc/ssl/certs/localhost.dev.crt /etc/ssl/private/localhost.dev.key
echo "\n\nFASE 6 OKAAAAAAAAY\n\n\n"
sleep 6

#install phpmyadmin
#wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -zxvf phpmyadmin.tar.gz
mv phpmyadmin /var/www/localhost/phpmyadmin/
cp -pr ./config.ini.php /var/www/localhost/phpmyadmin/config.inc.php
cp -pr ./nginx.conf /etc/nginx/sites-available/default
#chmod 755 /var/www/localhost
chown -R www-data:www-data /var/www/localhost/phpmyadmin
echo "GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'juolivei'@'localhost' IDENTIFIED BY 'juolivei';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
echo "\n\nFASE 7 OKAAAAAAAAY\n\n\n"
sleep 6

#install wordpress
#curl -LO https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cp wp-config.php wordpress/wp-config.php
mv wordpress /var/www/localhost/
chown -R www-data:www-data /var/www/localhost/wordpress
echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'juolivei';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
echo "\n\nFASE 8 OKAAAAAAAAY\n\n\n"
sleep 6

#import mysql wordpress dump
mysql -u root wordpress < wordpress.sql
echo "\n\nFASE 9 OKAAAAAAAAY\n\n\n"
sleep 6

#restart services
/etc/init.d/mysql restart
/etc/init.d/nginx restart
/etc/init.d/php7.3-fpm restart
echo "\n\nFASE 10 OKAAAAAAAAY\n\n\n"
sleep 6
