
COMPOSE_FILE	= ./srcs/docker-compose.yml

.PHONY: build up down logs clean re

init-dirs:
	mkdir -p /home/aduenas-/data/mysql /home/aduenas-/data/wordpress

up: init-dirs
	docker-compose -f $(COMPOSE_FILE) up --build -d
logs:
	docker-compose -f $(COMPOSE_FILE) logs -f
down:
	docker-compose -f $(COMPOSE_FILE) down
clean:
	docker-compose -f $(COMPOSE_FILE) down -v --rmi all --remove-orphans
re: down up
