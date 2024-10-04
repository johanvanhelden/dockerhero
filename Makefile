.DEFAULT_GOAL := up

.PHONY: up
up:
	@docker compose up -d

.PHONY: up-build
up-build:
	@docker compose up -d --build

.PHONY: up-verbose
up-verbose:
	@docker compose up

.PHONY: down
down:
	@docker compose down

.PHONY: start
start:
	@docker compose start

.PHONY: stop
stop:
	@docker compose stop

.PHONY: pull
pull:
	@docker compose pull
