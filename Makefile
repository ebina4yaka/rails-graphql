up:
	docker-compose up -d
down:
	docker-compose down
build:
	docker-compose build --no-cache --force-rm
setup:
	@make up
	@make init
restart:
	@make down
	@make up
	@make init
bundle:
	docker-compose exec app bundle install
update:
	docker-compose exec app bundle update
init:
	@make bundle
	docker-compose exec app rake db:create
	@make migrate
dump:
	docker-compose exec app rake graphql:schema:dump
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
test:
	docker-compose exec app rails t
serve:
	docker-compose exec app rails s -b 0.0.0.0
app:
	docker-compose exec app bash
