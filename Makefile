NAME = inception
COMPOSE = srcs/docker-compose.yml
DC =  docker compose -p $(NAME) -f $(COMPOSE)

all: build up

build:
	@sudo mkdir -p /home/gmarre/data/mariadb
	@sudo mkdir -p /home/gmarre/data/wordpress
	@$(DC) build

up:
	@$(DC) up -d

down:
	@$(DC) down

re: clean all

clean: down
	@sudo rm -rf /home/gmarre/data/mariadb
	@sudo rm -rf /home/gmarre/data/wordpress
	@sudo docker volume rm inception_wordpress
	@sudo docker volume rm inception_mariadb
	@sudo docker rmi $$(docker images -a -q) -f
	@sudo docker system prune -f -a --volumes

stop:
	@$(DC) stop

.PHONY: all build up down re clean stop