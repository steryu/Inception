PROJECT = inception

LIST_CONTAINERS := $(shell docker ps -a -q)
LIST_VOLUMES := $(shell docker volume ls -q)

all: debian up

up:
		mkdir -p /Users/ichiro/data/mariadb
		mkdir -p /Users/ichiro/data/wordpress
		sudo docker-compose -f srcs/docker-compose.yml up --build
		@echo "done!"

stop:
		docker-compose -f srcs/docker-compose.yml stop

kill:
		docker-compose -f srcs/docker-compose.yml kill

reset:
		docker compose -f ./srcs/docker-compose.yml down
		docker rm -f $(LIST_CONTAINERS)
		docker volume rm -f $(LIST_VOLUMES)
		rm -r /Users/ichiro/data
		@echo "deleted!"

debian: 
		docker pull debian:buster

re : reset up