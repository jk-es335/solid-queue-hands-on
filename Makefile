build:
	docker compose build app --no-cache
	docker compose run --rm app bundle install

build_if_not_exist:
	test -z "$(docker image ls -q solid_queue_hands_on:latest)" && $(MAKE) build

up_dj:
	$(MAKE) stop || true
	echo "QUEUE_ADAPTER=delayed_job" > .env
	$(MAKE) build_if_not_exist
	docker compose --env-file .env up -d app db delayed_job

up_dj_all:
	$(MAKE) stop || true
	echo "QUEUE_ADAPTER=delayed_job" > .env
	$(MAKE) build_if_not_exist
	docker compose --env-file .env up -d app db delayed_job delayed_job2

up_sq:
	$(MAKE) stop || true
	echo "QUEUE_ADAPTER=solid_queue" > .env
	$(MAKE) build_if_not_exist
	docker compose --env-file .env up -d app db solid_queue

up_sq_all:
	$(MAKE) stop || true
	echo "QUEUE_ADAPTER=solid_queue" > .env
	$(MAKE) build_if_not_exist
	docker compose --env-file .env up -d app db solid_queue solid_queue2 solid_queue3

stop:
	docker compose down --remove-orphans
	rm -f .env

down:
	docker compose down -v --remove-orphans
	rm -f .env
