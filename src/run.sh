#!/usr/bin/env bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    run.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: juolivei <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/10 15:11:50 by juolivei          #+#    #+#              #
#    Updated: 2020/02/10 15:11:50 by juolivei         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

/etc/init.d/mysql start
/etc/init.d/nginx start
/etc/init.d/php7.3-fpm start
echo " ________________________________"
echo "< nothing to see here! move on.. >"
echo " --------------------------------"
echo "        \\   ^__^"
echo "         \\  (oo)\\_______"
echo "            (__)\\       )\\/\\"
echo "                ||----w |"
echo "                ||     ||"
tail -f /var/log/nginx/access.log /var/log/nginx/error.log
