FROM debian:buster
LABEL maintainer="Juan 'juolivei' Lamarao"
COPY src/nginx.conf /root/
COPY src/latest.tar.gz /root/
COPY src/config.ini.php /root/
COPY src/phpmyadmin.tar.gz /root/
COPY src/wp-config.php /root/
COPY src/wordpress.sql /root/
EXPOSE 80 443
RUN bash /root/deploy.sh && tail -f /dev/null