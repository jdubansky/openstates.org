#!/bin/sh

set -ex
unset DATABASE_URL

# stop database and remove volume
docker-compose down 
docker volume rm openstates-postgres
docker-compose up -d db
sleep 1

# migrate and populate db
docker-compose run --rm --entrypoint "poetry run ./manage.py migrate" django
DATABASE_URL=postgis://openstates:openstates@db/openstatesorg docker-compose run --rm --entrypoint "poetry run os-initdb" django

# add test data
docker-compose run --rm -e PYTHONPATH=docker/ --entrypoint 'poetry run ./manage.py shell -c "import testdata"' django
