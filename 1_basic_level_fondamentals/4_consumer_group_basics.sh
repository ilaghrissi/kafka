# consumer group basics
# Start a Kafka console consumer with a specific consumer group id "my-consumer-group" to
# read messages from the "quickstart-events" topic
bin/kafka-console-consumer.sh --topic quickstart-events --from-beginning --bootstrap-server localhost:9092 --group my-consumer-group

# You can open another terminal and start another consumer with the same group id to see how messages are distributed
# between consumers in the same group
bin/kafka-console-consumer.sh --topic quickstart-events --from-beginning --bootstrap-server localhost:9092 --group my-consumer-group

# You can also start a consumer with a different group id to see that it receives all messages independently
bin/kafka-console-consumer.sh --topic quickstart-events --from-beginning --bootstrap-server localhost:9092 --group another-consumer-group
# To observe consumer group details, you can use the kafka-consumer-groups.sh script

# For example, to describe the "my-consumer-group" consumer group, run:
bin/kafka-consumer-groups.sh --describe --group my-consumer-group --bootstrap-server localhost:9092
# This will show you the partition assignments, offsets, and lag for the consumer group
# lag indicates how many messages are yet to be consumed by the consumer group
# lag = log end offset - current offset

# You can also list all consumer groups using:
bin/kafka-consumer-groups.sh --list --bootstrap-server localhost:9092

# Note: Make sure to produce some messages to the "quickstart-events" topic using the console producer
# from the previous script (3_produce_consume_basic.sh) to see the consumers in action.

# Remember that consumer groups are a fundamental concept in Kafka for scaling and fault tolerance
# They allow multiple consumers to share the load of reading from topics while ensuring that each message is processed only once within a group.
# You can experiment with different group ids and multiple consumers to see how Kafka manages message delivery and offsets.
# For more advanced usage, you can explore options like setting the auto-offset-reset policy, committing offsets manually, and using different deserializers for message keys and values.
# Refer to the Kafka documentation for more details on consumer groups and their configurations.
# https://kafka.apache.org/documentation/#consumerconfigs



# If the same consumer recieves message you have to create the topic with multiple partitions
# and start multiple consumers in the same group to see how messages are distributed among them.
# You can create a topic with multiple partitions using the kafka-topics.sh script as shown in the previous scripts.
# For example, to create a topic named "multi-partition-topic" with 3 partitions and a replication factor of 1, run:
bin/kafka-topics.sh --create --topic multi-partition-topic --partitions 3 --replication-factor 1 --bootstrap-server localhost:9092
# Then start multiple consumers in the same group to see the distribution of messages across    partitions.
# Start first consumer
bin/kafka-console-consumer.sh --topic multi-partition-topic --from-beginning --bootstrap-server localhost:9092 --group multi-partition-group
# Start second consumer
bin/kafka-console-consumer.sh --topic multi-partition-topic --from-beginning --bootstrap-server localhost:9092 --group multi-partition-group
# Start third consumer
bin/kafka-console-consumer.sh --topic multi-partition-topic --from-beginning --bootstrap-server localhost:9092 --group multi-partition-group
# Now produce messages to the "multi-partition-topic" using the console producer
bin/kafka-console-producer.sh --topic multi-partition-topic --bootstrap-server localhost:9092
# You will see that messages are distributed among the consumers in the "multi-partition-group" consumer group
# based on the partition assignments. 