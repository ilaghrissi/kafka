# Download and extract Kafka
tar -xzf kafka_2.13-4.1.0.tgz
cd kafka_2.13-4.1.0

# Generate a random UUID for the Kafka cluster ID
KAFKA_CLUSTER_ID="$(bin/kafka-storage.sh random-uuid)"


# Format the storage for Kafka with the generated cluster ID
bin/kafka-storage.sh format --standalone -t $KAFKA_CLUSTER_ID -c config/server.properties

# Start the Kafka server
bin/kafka-server-start.sh config/server.properties


# Clean up temporary log directories
rm -rf /tmp/kafka-logs /tmp/kraft-combined-logs
