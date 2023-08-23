postgres:
	docker run --name postgresql -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 --restart unless-stopped postgres:15-alpine

createdb:
	docker exec -it postgresql createdb --username=postgres --owner=postgres si_bank

dropdb:
	docker exec -it postgresql dropdb --username=postgres si_bank

pshell:
	docker exec -it postgresql psql -U postgres

upmigrate:
	migrate -path db/migrations -database "postgresql://postgres:postgres@localhost:5432/si_bank?sslmode=disable" -verbose up

downmigrate:
	migrate -path db/migrations -database "postgresql://postgres:postgres@localhost:5432/si_bank?sslmode=disable" -verbose down

.PHONY: postgres createdb dropdb pshell upmigrate downmigrate
