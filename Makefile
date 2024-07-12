all: build

build:
	sudo docker compose -f srcs/docker-compose.yml up -d
	sudo docker compose -f srcs/docker-compose.yml start

stop:
	sudo docker compose -f srcs/docker-compose.yml stop

clean:
	sudo docker compose -f srcs/docker-compose.yml down

fclean: clean
	sudo -rm -rf /home/gmarre/data/*/*
	docker compose system prune -af