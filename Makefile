start:
	docker compose up -d
stop:
	docker compose down
client:
	docker compose -f operations.yaml run --rm client