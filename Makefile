
include infra/.env

ifeq ("$(MAKEFILE_MODO_VERBOSE)",  "true")
SHELL = sh -xv
endif

ifneq ($(shell docker compose version 2>/dev/null),)
	DC=docker compose
else ifneq ($(shell docker-compose --version 2>/dev/null),)
	DC=docker-compose
else
	$(error ************  docker compose or docker-compose not found. ************)
endif

# Define variables
COMPOSE_FILE=infra/docker-compose.yml
PROJECT_NAME=PacketFence



help:   ##  List of available commands and description. You can use TAB to complete commands
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

logs:   ##  Viewing logs...
	@echo "Check the result in real time."
	$(DC) -p $(PROJECT_NAME) -f $(COMPOSE_FILE) logs -f
	
up:   ##  Starting services...
	@echo "Start PacketFence"
	make update_version
	DOCKER_BUILDKIT=1 $(DC) -p $(PROJECT_NAME) -f $(COMPOSE_FILE) up -d --build

down:   ##  Stopping services...
	@echo "Stop PacketFence"
	$(DC) -p $(PROJECT_NAME) -f $(COMPOSE_FILE) down --remove-orphans

ps:   ##  Listing services...
	@echo "Listing services..."
	docker-compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) ps

restart:   ##  Restarting services...
	echo "Restaring PacketFence"
	make down && make up

update_version:   ##  Updating packetfence verion...
	echo "Updating PacketFence Version"
	git fetch && git pull

.PHONY: help logs up down ps restart update_version