# ft_server

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/7131d491cb014536819ca63cc18cf11a)](https://app.codacy.com/manual/juanlamarao/42_ft_server?utm_source=github.com&utm_medium=referral&utm_content=juanlamarao/42_ft_server&utm_campaign=Badge_Grade_Dashboard)

An automated docker container with LEMP +wordpress +ssl autosigned

## How To Test _(choose one)_

### Opition 1: Clonning the repository
git clone <https://github.com/juanlamarao/42_ft_server/> && cd 42_ft_server && docker build . -t ft_server && docker run -it -p80:80 -p443:443 ft_server
  
### Opition 2: Using docker hub
docker run -it -p80:80 -p443:443 juanlamarao/ft_server:latest
  
### And then acess it @ <https://localhost>

## Switching the NGINX index to ON or OFF
docker exec $(docker ps | grep ft_server | cut -d ' ' -f 1) bash /root/switch_autoindex.sh 

## After testing you can delete containers and images by running
docker rm $(docker ps -a | grep ft_server | cut -d ' ' -f 1) && docker images -a | grep "ft_server" | awk '{print $3}' | xargs docker rmi

### If you choosed to clone the repository, remove the debian image using this command
docker images -a | grep "buster" | awk '{print $3}' | xargs docker rmi
