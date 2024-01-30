NAME = inception

DOCKER_COMPOSE = docker-compose
COMPOSE_LOC = srcs/docker-compose.yml

all: up

up:
	mkdir -p /home/emlicame/data/wordpress
	mkdir -p /home/emlicame/data/mariadb
# mkdir -p /Users/emanuela/data/wordpress
# mkdir -p /Users/emanuela/data/mariadb
	$(DOCKER_COMPOSE) -f $(COMPOSE_LOC) up --build --remove-orphans

down:
	$(DOCKER_COMPOSE) -f $(COMPOSE_LOC) down

start:
	$(DOCKER_COMPOSE) -f $(COMPOSE_LOC) start

stop: 
	$(DOCKER_COMPOSE) -f $(COMPOSE_LOC) stop

clean: down
	docker system prune -af
	docker volume prune -f 
#volumes that are no longer associated with containers after a docker system prune,

fclean: clean

	rm -rf /home/emlicame/data/mariadb
	rm -rf /home/emlicame/data/wordpress

re: fclean all

.PHONY: all up down start stop clean fclean