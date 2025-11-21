# Start a Kafka console producer to send messages to the "quickstart-events" topic
bin/kafka-console-producer.sh --topic quickstart-events --bootstrap-server localhost:9092

# Start a Kafka console consumer to read messages from the "quickstart-events" topic
bin/kafka-console-consumer.sh --topic quickstart-events --from-beginning --bootstrap-server localhost:9092