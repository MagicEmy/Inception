NAME = inception

DOCKER_COMPOSE = docker compose
COMPOSE_LOC = srcs/docker-compose.yml

include srcs/.env

all: up

up:
	mkdir -p $(MARIADB_VOLUME) $(WORDPRESS_VOLUME)
	$(DOCKER_COMPOSE) -f $(COMPOSE_LOC) up --build --detach --remove-orphans

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
	rm -rf $(MARIADB_VOLUME)
	rm -rf $(WORDPRESS_VOLUME)
	rm -rf $(VOLUME_DIR)

re: fclean all

.PHONY: all up down start stop clean fclean