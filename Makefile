# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cpereira <cpereira@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/03/13 14:47:30 by cpereira          #+#    #+#              #
#    Updated: 2023/04/06 17:10:04 by cpereira         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#DOMAIN = $(shell awk '/cpereira.42.fr/{print $$2}' /etc/hosts)
IMAGES = $(shell docker images -q)
VOLUMES = $(shell docker volume ls -q)

all:
	@sudo mkdir -p /home/cpereira/data/mysql && sudo mkdir -p /home/cpereira/data/wordpress
	@cd srcs/ && docker compose -f docker-compose.yml up -d --build
	@sudo sed -i '3i\127.0.0.1 cpereira.42.fr' /etc/hosts

up:
	@cd srcs/ && docker compose -f docker-compose.yml up

down:
	@cd srcs/ && docker compose -f docker-compose.yml down

clean:
ifneq ($(VOLUMES),)
	@docker volume rm $(VOLUMES)
endif
ifneq ($(IMAGES),)
	@docker rmi $(IMAGES)
endif

fclean: down clean
	@docker system prune -a --volumes
	@sudo sed -i '/cpereira.42.fr/d' /etc/hosts
	@sudo rm -rf /home/cpereira/data
	

.PHONY: all hosts down clean fclean
