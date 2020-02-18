FROM debian:buster
LABEL maintainer="Juan 'juolivei' Lamarao <juolivei@student.42sp.org.br"
COPY srcs /root/
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
apt-get update && apt-get install -y --no-install-recommends apt-utils 2> /dev/null && \
apt-get -y install aptitude 2> /dev/null && bash /root/deploy.sh
ENTRYPOINT bash /root/run.sh
