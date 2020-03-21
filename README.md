# ft_server

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/7131d491cb014536819ca63cc18cf11a)](https://app.codacy.com/manual/juanlamarao/42_ft_server?utm_source=github.com&utm_medium=referral&utm_content=juanlamarao/42_ft_server&utm_campaign=Badge_Grade_Dashboard)
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

An automated docker container using debian:buster image with LEMP, wordpress and autosigned SSL.

## How it works
This docker project aims to build multiples services, using only one container:
1. Web server with [Nginx](https://www.nginx.com/)
2. SQL Database with [MariaDB](https://www.mariadb.org/)
3. Database web admin with [PhpMyAdmin](https://www.phpmyadmin.net/)
4. OpenSource CMS with [Wordpress](https://www.wordpress.com/)
5. Self-signed SSL certificate with [OpenSSL](https://www.openssl.org/)
6. Switch to turn ON or OFF the Nginx auto Index with Shell Script

## How to test _(choose one)_

### Option 1: Clonning the repository
1. git clone `https://github.com/juanlamarao/42_ft_server/`
2. cd 42_ft_server
3. docker build . -t ft_server
4. docker run -it -p80:80 -p443:443 ft_server
  
### Option 2: Using Docker hub
1. docker run -it -p80:80 -p443:443 juanlamarao/ft_server:latest
  
### It's time to access it
<https://localhost>  
<https://localhost/wordpress>  
<https://localhost/phpmyadmin>  

## Switching the NGINX index ON or OFF
docker exec $(docker ps | grep ft_server | cut -d ' ' -f 1) bash /root/switch_autoindex.sh  
<https://localhost>

## After testing you can delete containers and images by running
docker rm $(docker ps -a | grep ft_server | cut -d ' ' -f 1)  
docker images -a | grep "ft_server" | awk '{print $3}' | xargs docker rmi

### If you used the repository method, remove the debian image as well
docker images -a | grep "buster" | awk '{print $3}' | xargs docker rmi  
  
## PT-BR Translation
Um Container Docker automatizado utilizando uma imagem Debian:buster com LEMP, wordpress e SSL autoassinado.

## Como funciona
Este projeto docker tem como objetivo construir multiplus serviços, utilizando somente um container:
1. Servidor Web com [Nginx](https://www.nginx.com/)
2. Banco de dados SQL com [MariaDB](https://www.mariadb.org/)
3. Administração web para banco de dados com [PhpMyAdmin](https://www.phpmyadmin.net/)
4. Gerenciados de conteúdo para WEB OpenSource com [Wordpress](https://www.wordpress.com/)
5. Certificado SSL autoassinado com [OpenSSL](https://www.openssl.org/)
6. Mecanismo para habilitar e desabilitar o autoindex do Nginx com Shell Script

## Como testar _(escolha uma)_

### Opção 1: Clonando o repositório
1. git clone `https://github.com/juanlamarao/42_ft_server/`
2. cd 42_ft_server
3. docker build . -t ft_server
4. docker run -it -p80:80 -p443:443 ft_server
  
### Opção 2: Utilizando o Docker hub
1. docker run -it -p80:80 -p443:443 juanlamarao/ft_server:latest
  
### É hora de acessar
<https://localhost>  
<https://localhost/wordpress>  
<https://localhost/phpmyadmin>  

## Alternando entre autoindex do NGINX ON e OFF
docker exec $(docker ps | grep ft_server | cut -d ' ' -f 1) bash /root/switch_autoindex.sh  
<https://localhost>

## Após testar, você pode remover as imagens e containers com os seguintes comandos
docker rm $(docker ps -a | grep ft_server | cut -d ' ' -f 1)  
docker images -a | grep "ft_server" | awk '{print $3}' | xargs docker rmi

### Caso tenha utilizado o primeiro método, remova também a imagem do Debian
docker images -a | grep "buster" | awk '{print $3}' | xargs docker rmi
