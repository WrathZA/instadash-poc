docker compose down
docker volume rm pgr_pgdata
docker-compose --env-file .env -f docker-compose.yml up --build