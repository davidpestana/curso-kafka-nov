bootstrap-server = broker1:9092, broker2:9092, broker3:9092

start: ## project start
	docker compose up -d
start-producers:
	docker compose -f producers.yaml up

stop: ## project stop
	docker compose down
client: ## lauch operational client
	docker compose -f operations.yaml run --rm client

client-node: ## lauch operational client for node projects
	docker compose -f producers.yaml run --rm producer-1 bash

cleanup: ## clean all data and containers
	docker compose down --remove-orphans
	docker compose -f operations.yaml run --rm client bash -c "rm -Rf /data/" 

topic-create:  ## create a new topic
	@read -p "Enter a topic name: " topic; \
	read -p "Enter partition number: " partitions; \
	read -p "Enter replication factor": replication; \
	docker compose -f operations.yaml run --rm client bash -c \
		"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --create --partitions $$partitions --replication-factor $$replication --topic $$topic "

topic-delete: ## delete a topic
	@read -p "Enter a topic name: " topic; \
	docker compose -f operations.yaml run --rm client bash -c \
		"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --delete --topic $$topic"

topic-describe:  ## describe a topic
	@read -p "Enter a topic name: " topic; \
	docker compose -f operations.yaml run --rm client bash -c \
		"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --describe --topic $$topic"

topic-list: ## get a topic list
	docker compose -f operations.yaml run --rm client bash -c \
		"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --list"

producer-create: ## create a console producer conected to topic
	@read -p "Enter a topic name: " topic; \
	docker compose -f operations.yaml run --rm client bash -c \
		"./bin/kafka-console-producer.sh --bootstrap-server $(bootstrap-server) --topic $$topic"

consumer-create: ## create a console consumer connected to group and topic
	@read -p "Enter a topic name: " topic; \
	read -p "Enter a group name: " group; \
	docker compose -f operations.yaml run --rm client bash -c \
		"./bin/kafka-console-consumer.sh --bootstrap-server $(bootstrap-server) --topic $$topic --group $$group"

group-list: ## get a group list
	docker compose -f operations.yaml run --rm client bash -c \
		"./bin/kafka-consumer-groups.sh --bootstrap-server $(bootstrap-server) --list"

group-describe: ## get a group description
	@read -p "Enter a group name: " group; \
	docker compose -f operations.yaml run --rm client bash -c \
		"./bin/kafka-consumer-groups.sh --bootstrap-server $(bootstrap-server) --describe --group $$group"



help: 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'