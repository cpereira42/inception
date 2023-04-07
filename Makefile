IMAGES = $(shell docker images -q)
VOLUMES = $(shell docker volume ls -q)

all:
	@sudo sed -i '3i\127.0.0.1 cpereira.42.fr' /etc/hosts
	@sudo mkdir -p /home/cpereira/data/mysql && sudo mkdir -p /home/cpereira/data/wordpress
	@cd srcs/ && docker compose -f docker-compose.yml up -d --build
	
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
	@sudo sed -i '/127.0.0.1 cpereira.42.fr/g' /etc/hosts
	@sudo rm -rf /home/cpereira/data
	
.PHONY: all down clean fclean
