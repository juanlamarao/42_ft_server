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
#apt-get update

#install mysql & nginx & php
#echo -e "\nInstalling Nginx Mysql and PHP packages.."
aptitude install -y mariadb-server nginx php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline php-json php-mbstring php7.3-mbstring php-curl php-gd php-intl php-soap php-xml php-xmlrpc php-zip
#echo -e ".......................................\e[32m\e[1mOK\e[0m"

#create web directory and change to root dir
mkdir /var/www/localhost
cd /root
mv srcs/* ./
rmdir srcs

#start mysql & nginx
#echo -e "\nStarting services.."
/etc/init.d/mysql start
/etc/init.d/nginx start
/etc/init.d/php7.3-fpm start
#echo -e "....................\e[32m\e[1mOK\e[0m"

#configure SSL
#echo -e "\nSetting SSL certificate.."
openssl req -newkey rsa:4096 -days 365 -nodes -x509 \
    -subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=localhost/OU=Development/CN=localhost/emailAddress=juolivei@localhost.dev" \
    -keyout localhost.dev.key \
    -out localhost.dev.crt  2>> /root/erros.txt
mv localhost.dev.crt /etc/ssl/certs/
mv localhost.dev.key /etc/ssl/private/
chmod 600 /etc/ssl/certs/localhost.dev.crt /etc/ssl/private/localhost.dev.key
#echo -e ".......................\e[32m\e[1mOK\e[0m"

#install phpmyadmin
#echo -e "Installing PhpMyAdmin.."
#wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpmyadmin.tar.gz
mv phpMyAdmin-4.9.0.1-all-languages /var/www/localhost/phpmyadmin
cp -pr ./config.inc.php /var/www/localhost/phpmyadmin/config.inc.php
cp -pr ./php.ini /etc/php/7.3/fpm/php.ini
cp -pr ./nginx.conf /etc/nginx/sites-available/default
#chmod 755 /var/www/localhost
chown -R www-data:www-data /var/www/localhost/phpmyadmin
echo "GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'juolivei'@'localhost' IDENTIFIED BY 'juolivei';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
#echo -e ".....................\e[32m\e[1mOK\e[0m"

#install wordpress
#echo "\nInstalling wordpress.."
#curl -LO https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
cp wp-config.php wordpress/wp-config.php
mv wordpress /var/www/localhost/
chown -R www-data:www-data /var/www/localhost/wordpress
echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'juolivei';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
#echo -e "....................\e[32m\e[1mOK\e[0m"

#import mysql wordpress dump
#echo "Importing wordpress database schemas.."
mysql -u root < alldatabase.sql
#echo -e "...................................\e[32m\e[1mOK\e[0m"

#clean cache
#echo "\nCleaning cache.."
apt-get clean -y
apt-get autoclean -y
apt-get autoremove -y
rm -f /root/php.ini
rm -f /root/deploy.sh
rm -f /root/nginx.conf
rm -f /root/latest.tar.gz
rm -f /root/wp-config.php
rm -f /root/config.inc.php
rm -f /root/phpmyadmin.tar.gz
rm -f /root/wordpress.sql
#echo -e "..............\e[32m\e[1mOK\e[0m"

#echo -e "\n _______"
#echo -e "< \e[32m\e[1mDone!\e[0m >"
#echo " -------"
#echo "        \\   ^__^"
#echo "         \\  (oo)\\_______"
#echo "            (__)\\       )\\/\\"
#echo "                ||----w |"
#echo -e "                ||     ||\n\n"

#restart services
#/etc/init.d/mysql restart
#/etc/init.d/nginx restart
#/etc/init.d/php7.3-fpm restart
