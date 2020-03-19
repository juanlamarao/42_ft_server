# ft_server
An automated docker container with LEMP +wordpress +ssl autosigned

## How To Test _(choose one)_

### Opition 1: Clonning the repository
git clone <https://github.com/juanlamarao/42_ft_server/> && cd 42_ft_server && docker build . -t ft_server && docker run -it -p80:80 -p443:443 ft_server
  
### Opition 2: Running unsing docker hub
docker run -it -p80:80 -p443:443 juanlamarao/ft_server:latest
  
### And then acess it @ <https://localhost>

## Switching the NGINX index to ON or OFF
docker exec $(docker ps | grep ft_server | cut -d ' ' -f 1) bash /root/switch_autoindex.sh 

## after test you can delete the files by running
docker rm $(docker ps -a | grep ft_server | cut -d ' ' -f 1) && docker images -a | grep "ft_server" | awk '{print $3}' | xargs docker rmi

### if you choosed to clone the repository, remove the debian image using this command
docker images -a | grep "buster" | awk '{print $3}' | xargs docker rmi
