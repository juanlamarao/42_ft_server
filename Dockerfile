FROM debian:buster
LABEL maintainer="Juan 'juolivei' Lamarao <juolivei@student.42sp.org.br"
COPY src/deploy.sh /root/
COPY src/nginx.conf /root/
COPY src/latest.tar.gz /root/
COPY src/config.ini.php /root/
COPY src/phpmyadmin.tar.gz /root/
COPY src/wp-config.php /root/
COPY src/wordpress.sql /root/
RUN apt-get install dialog apt-utils -y
EXPOSE 80 443
#RUN bash /root/deploy.sh && tail -f /dev/null
RUN bash /root/deploy.sh
CMD ["bash", "/root/run.sh"]
