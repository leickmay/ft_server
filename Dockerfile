# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: leickmay <leickmay@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/08 10:29:35 by leickmay          #+#    #+#              #
#    Updated: 2021/01/15 11:10:47 by leickmay         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update && apt-get upgrade -y
RUN apt-get install nginx -y
RUN apt-get install php -y
RUN apt-get install mariadb-server -y
RUN apt-get install php-fpm -y
RUN apt-get install php-mysqlnd -y
RUN apt-get install wget -y

ENV MYSQL_USER="user"
ENV MYSQL_PWD="pass"

ADD ./srcs ./
EXPOSE 80 443
ENTRYPOINT sh install.sh
