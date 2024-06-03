WORKER ?= 3

build:
	docker compose build app --no-cache
	docker compose run --rm app bundle install

build_if_not_exist:
	@if test -z "$$(docker image ls -q solid_queue_hands_on:latest)"; then \
	    $(MAKE) build; \
	else \
	    echo "Docker image solid_queue_hands_on:latest already exists."; \
	fi

up_dj:
	$(MAKE) stop || true
	echo "QUEUE_ADAPTER=delayed_job" > .env
	$(MAKE) build_if_not_exist
	docker compose --env-file .env up -d app db delayed_job

up_dj_all:
	$(MAKE) stop || true
	echo "QUEUE_ADAPTER=delayed_job" > .env
	$(MAKE) build_if_not_exist
	docker compose --env-file .env up -d app db delayed_job
	@if [ $(WORKER) -gt 1 ]; then \
		docker compose --env-file .env scale delayed_job=$(WORKER); \
	fi

up_sq:
	$(MAKE) stop || true
	echo "QUEUE_ADAPTER=solid_queue" > .env
	$(MAKE) build_if_not_exist
	docker compose --env-file .env up -d app db solid_queue

up_sq_all:
	$(MAKE) stop || true
	echo "QUEUE_ADAPTER=solid_queue" > .env
	$(MAKE) build_if_not_exist
	docker compose --env-file .env up -d app db solid_queue
	@if [ $(WORKER) -gt 1 ]; then \
		docker compose --env-file .env scale solid_queue=$(WORKER); \
	fi

stop:
	docker compose down --remove-orphans
	rm -f .env

down:
	docker compose down -v --remove-orphans
	rm -f .env
