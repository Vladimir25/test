up: docker-up
down: docker-down
docker-restart: down up
up-cron: docker-up-cron
clear: artisan-cache-clear artisan-config-clear
#c-update: composer-update
laravel-test-start: artisan-config-cache artisan-route-cache artisan-test
laravel-test-filtered: artisan-config-cache artisan-route-cache artisan-test-filtered
migrate-refresh: artisan-config-cache artisan-config-clear artisan-route-cache artisan-migrate-refresh

start-listener:
	socat TCP-LISTEN:2375,reuseaddr,fork UNIX-CONNECT:/var/run/docker.sock &

artisan-test:
	docker exec -i findbr-backend php /app/laravel/artisan test

artisan-test-filtered:
	docker exec -i findbr-backend php /app/laravel/artisan test --filter ChatSendMessageTest::testManPhotoMessage

artisan-migrate-refresh:
	docker exec -i findbr-backend php /app/laravel/artisan migrate:fresh

artisan-config-cache:
	php artisan config:cache

artisan-config-clear:
	php artisan config:clear

artisan-cache-clear:
	php artisan cache:clear

artisan-route-cache:
	php artisan route:cache

docker-up:
	docker-compose -f docker-compose.yml up -d

docker-down:
	docker-compose -f docker-compose.yml stop

docker-up-cron:
	docker-compose -f docker-compose.cron.local.yml -f docker-compose.local.yml up -d

docker-pull:
	docker pull registry.findbr.net/findbr/find-bride-com/backend:master

docker-build:
	docker-compose up --build -d

#test:
#	docker-compose exec -i findbr-backend vendor/bin/phpunit --colors=always
#
#perm:
#	docker exec -i findbr-backend chmod 755 /app/.docker/my.cnf
#
#composer-perm:
#	docker exec -i findbr-backend chmod -R 777 /app/laravel/vendor
#
#composer-update:
#	docker exec -i findbr-backend composer update
#
#composer-clear-cache:
#	docker exec -i findbr-backend composer clear-cache
#
#composer-update-autoload:
#	docker exec -i findbr-backend composer dump-autoload
#
#composer-install:
#	docker exec -i findbr-backend composer install
#
#payments-unit:
#	docker exec -i findbr-backend php /app/vendor/phpunit/phpunit/phpunit --bootstrap /app/tests/bootstrap.php --configuration /app/phpunit.xml /app/tests/PaymentsDomain
