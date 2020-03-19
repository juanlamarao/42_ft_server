FROM debian:buster
LABEL maintainer="Juan 'juolivei' Lamarao <juolivei@student.42sp.org.br"
COPY srcs /root/
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
apt-get update && apt-get install -y --no-install-recommends apt-utils=1.8.2 2> /dev/null && \
apt-get install -y --no-install-recommends aptitude=0.8.11-7 2> /dev/null && && apt-get clean && \
rm -rf /var/lib/apt/lists/* && bash /root/deploy.sh
ENTRYPOINT bash /root/run.sh
