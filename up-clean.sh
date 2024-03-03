docker compose down
docker volume rm instadash-poc_pgdata
docker-compose --env-file .env -f docker-compose.yml up --build