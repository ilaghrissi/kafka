# Create a Kafka topic named "quickstart-events"
bin/kafka-topics.sh --create --topic quickstart-events --bootstrap-server localhost:9092

# list Kafka topics to verify creation expected output: "quickstart-events" and __consumer_offsets topic witch is created by default to track consumer group offsets
bin/kafka-topics.sh --list --bootstrap-server localhost:9092

# Describe the "quickstart-events" topic to see its details
bin/kafka-topics.sh --describe --topic quickstart-events --bootstrap-server localhost:9092

# Create topic with 3 partitions and replication factor of 2
bin/kafka-topics.sh --create --topic multi-partition-topic --partitions 3 --replication-factor 2 --bootstrap-server localhost:9092

# replication-factor should not be higher than the number of brokers in the cluster. Since we have only one broker running in this setup, the following command will fail
# replication-factor is a number of copies of data that will be maintained across the Kafka cluster for fault tolerance for example 
#if replication-factor is set to 2, there will be 2 copies of each partition maintained on different brokers

# if we have one broker running in the cluster the following command will fail
# bin/kafka-topics.sh --create --topic invalid-replication-topic --partitions 3 --replication-factor 2 --bootstrap-server localhost:9092
# To successfully create a topic with replication-factor of 2, we need to start another broker instance
# This can be done by copying the server.properties file to another file (e.g., server-1.properties) and changing the broker.id and listeners port in the new file, then starting another
# error is : Unable ro replicate the partition 2 times for topic invalid-replication-topic since there are only 1 live brokers which is less than the required replication factor of 2