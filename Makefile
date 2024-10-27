rails.new:
	docker compose run --no-deps app rails new . -d postgresql -a propshaft -c tailwind

build:
	docker compose build

up:
	docker compose up

down:
	docker compose down