FROM debian:buster
LABEL maintainer="Juan 'juolivei' Lamarao <juolivei@student.42sp.org.br"
COPY srcs/run.sh /root/
COPY srcs/php.ini /root/
COPY srcs/deploy.sh /root/
COPY srcs/nginx.conf /root/
COPY srcs/latest.tar.gz /root/
COPY srcs/wp-config.php /root/
COPY srcs/config.inc.php /root/
COPY srcs/bkp_wp-config.php /root/
COPY srcs/phpmyadmin.tar.gz /root/
COPY srcs/switch_autoindex.sh /root/
COPY srcs/alldatabase.sql /root/
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils && apt-get -y install aptitude
#RUN apt-get update && apt-get install dialog apt-utils -y
#EXPOSE 80 443
#RUN bash /root/deploy.sh && tail -f /dev/null
#RUN bash /root/deploy.sh
#ENTRYPOINT bash /root/run.sh
