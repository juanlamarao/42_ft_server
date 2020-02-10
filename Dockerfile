FROM debian:buster
LABEL maintainer="Juan 'juolivei' Lamarao <juolivei@student.42sp.org.br"
COPY src/run.sh /root/
COPY src/php.ini /root/
COPY src/deploy.sh /root/
COPY src/nginx.conf /root/
COPY src/latest.tar.gz /root/
COPY src/wp-config.php /root/
COPY src/config.inc.php /root/
COPY src/phpmyadmin.tar.gz /root/
COPY src/wordpress.sql /root/
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils && apt-get -y install aptitude
#RUN apt-get update && apt-get install dialog apt-utils -y
EXPOSE 80 443
#RUN bash /root/deploy.sh && tail -f /dev/null
RUN bash /root/deploy.sh
ENTRYPOINT bash /root/run.sh
