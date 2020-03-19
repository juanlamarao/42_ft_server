FROM debian:buster
LABEL maintainer="Juan 'juolivei' Lamarao <juolivei@student.42sp.org.br>"
COPY srcs /root/
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
apt-get update && apt-get install -y --no-install-recommends apt-utils=1.8.2 aptitude=0.8.11-7 && \
bash /root/deploy.sh && apt-get clean && rm -rf /var/lib/apt/lists/*
ENTRYPOINT bash /root/run.sh
