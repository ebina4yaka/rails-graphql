up:
	docker-compose up -d
down:
	docker-compose down
build:
	docker-compose build --no-cache --force-rm
restart:
	@make up
	@make down
bundle:
	docker-compose exec app bundle install
update:
	docker-compose exec app bundle update
init:
	@make bundle
	docker-compose exec app rake db:create
	@make migrate
migrate:
	docker-compose exec app rails db:migrate
migrate-reset:
	docker-compose exec app rails db:migrate:reset
seed:
	docker-compose exec app rails db:reset
console:
	docker-compose exec app rails c
dbconsole:
	docker-compose exec app rails dbconsole
serve:
	docker-compose exec app rails s -b 0.0.0.0
app:
	docker-compose exec app bash
