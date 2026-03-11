.PHONY: up down build configure dashboard logs clean doctor status

build:
	docker compose build

up:
	docker compose up -d openclaw-gateway

down:
	docker compose down

configure:
	docker compose run --rm openclaw-cli configure

set-model:
	docker compose run --rm openclaw-cli config set agents.defaults.model.primary "google/gemini-2.5-flash"
	docker compose restart openclaw-gateway

dashboard:
	docker compose run --rm openclaw-cli dashboard --no-open

status:
	docker compose run --rm openclaw-cli models status

doctor:
	docker compose run --rm openclaw-cli doctor

logs:
	docker compose logs -f openclaw-gateway

clean:
	docker compose down -v --rmi local
