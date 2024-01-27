DOCKER_COMPOSE = docker-compose
COMPOSE_LOC = srcs/docker-compose.yml

all: build up

build:
	$(DOCKER_COMPOSE) -f $(COMPOSE_LOC) build
up:
	docker-compose -f $(COMPOSE_LOC) up -d

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


re: fclean all