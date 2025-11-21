# Resetting Offsets for a Consumer Group in Kafka

| Scénario        | Utilité                         |
| --------------- | ------------------------------- |
| `--to-earliest` | Rejouer toute l’historique      |
| `--to-latest`   | Ignorer tout l’historique       |
| `--to-offset X` | Revenir à une position précise  |
| `--to-datetime` | Rejouer depuis une date/heure   |
| `--shift-by -N` | Rejouer les N derniers messages |
| `--shift-by +N` | Sauter les N prochains messages |

# Case 1: Reset offsets to the earliest for the "my-consumer-group" consumer group on the "quickstart-events" topic
 bin/kafka-consumer-groups.sh --group my-consumer-group --topic quickstart-events --reset-offsets --to-earliest --bootstrap-server localhost:9092 --execute

# Produce some messages to the "quickstart-events" topic using the console producer
bin/kafka-console-producer.sh --topic quickstart-events --bootstrap-server localhost:9092


 # If you have this error "Assignments can only be reset if the group 'my-consumer-group' is inactive, but the current state is Stable"
    # we need to stop all consumers in that group before resetting offsets
    # because Kafka requires the consumer group to be inactive to perform offset resets
# Stop all consumers in the "my-consumer-group" consumer group
# After stopping the consumers, run the reset command again
bin/kafka-consumer-groups.sh --group my-consumer-group --topic quickstart-events --reset-offsets --to-earliest --bootstrap-server localhost:9092 --execute

# Verify the offsets have been reset by describing the consumer group again
bin/kafka-consumer-groups.sh --describe --group my-consumer-group --bootstrap-server localhost:9092

# Case 2: Reset offsets to a specific offset (e.g., offset 5) for partition 0 of the "quickstart-events" topic
bin/kafka-consumer-groups.sh --group my-consumer-group --topic quickstart-events:0 --reset-offsets --to-offset 5 --bootstrap-server localhost:9092 --execute
# Verify the offsets have been reset by describing the consumer group again
bin/kafka-consumer-groups.sh --describe --group my-consumer-group --bootstrap-server localhost:9092
# Case 3: Shift offsets by a specific number (e.g., +3) for the "quickstart-events" topic
bin/kafka-consumer-groups.sh --group my-consumer-group --topic quickstart-events --reset-offsets --shift-by 3 --bootstrap-server localhost:9092 --execute
# Verify the offsets have been reset by describing the consumer group again
bin/kafka-consumer-groups.sh --describe --group my-consumer-group --bootstrap-server localhost:9092
# Note: Always ensure that you understand the implications of resetting offsets, as it can lead to message reprocessing or data loss depending on the direction of the reset.
# Use these commands carefully in a production environment.
# For more details, refer to the Kafka documentation on consumer group offset management:
# https://kafka.apache.org/documentation/#consumerconfigs

# Case 4: Reset offsets to the latest for the "my-consumer-group" consumer group on the "quickstart-events" topic
 bin/kafka-consumer-groups.sh --group my-consumer-group --topic quickstart-events --reset-offsets --to-latest --bootstrap-server localhost:9092 --execute

 # Verify the offsets have been reset by describing the consumer group again
bin/kafka-consumer-groups.sh --describe --group my-consumer-group --bootstrap-server localhost:9092 
# Note: Always ensure that you understand the implications of resetting offsets, as it can lead to message reprocessing or data loss depending on the direction of the reset.
# Use these commands carefully in a production environment.
# For more details, refer to the Kafka documentation on consumer group offset management:
# https://kafka.apache.org/documentation/#consumerconfigs

# Case 5: Reset offsets to a specific timestamp (e.g., messages produced after July 1, 2023) for the "quickstart-events" topic
 bin/kafka-consumer-groups.sh --group my-consumer-group --topic quickstart-events --reset-offsets --to-datetime 2023-07-01T00:00:00.000 --bootstrap-server localhost:9092 --execute

 # Verify the offsets have been reset by describing the consumer group again
bin/kafka-consumer-groups.sh --describe --group my-consumer-group --bootstrap-server localhost:9092 
# Note: Always ensure that you understand the implications of resetting offsets, as it can lead to message reprocessing or data loss depending on the direction of the reset.
# Use these commands carefully in a production environment.
# For more details, refer to the Kafka documentation on consumer group offset management:
# https://kafka.apache.org/documentation/#consumerconfigs

# Case 6: Dry run to see what the offset reset would do without executing it
 bin/kafka-consumer-groups.sh --group my-consumer-group --topic quickstart-events --reset-offsets --to-earliest --bootstrap-server localhost:9092 --dry-run

 # This command will show you the proposed changes without applying them
# Use the --execute flag to apply the changes after reviewing the dry run output    

# Case 7: Reset offsets for multiple topics (e.g., "quickstart-events" and "multi-partition-topic") to the earliest
 bin/kafka-consumer-groups.sh --group my-consumer-group --topic quickstart-events,multi-partition-topic --reset-offsets --to-earliest --bootstrap-server localhost:9092 --execute

 # Verify the offsets have been reset by describing the consumer group again
bin/kafka-consumer-groups.sh --describe --group my-consumer-group --bootstrap-server localhost:9092 
# Note: Always ensure that you understand the implications of resetting offsets, as it can lead to message reprocessing or data loss depending on the direction of the reset.
# Case 8: Reset offsets for all topics consumed by the "my-consumer-group" consumer group to the earliest
 bin/kafka-consumer-groups.sh --group my-consumer-group --reset-offsets --to-earliest --bootstrap-server localhost:9092 --execute

 # Verify the offsets have been reset by describing the consumer group again
bin/kafka-consumer-groups.sh --describe --group my-consumer-group --bootstrap-server localhost:9092 
# Note: Always ensure that you understand the implications of resetting offsets, as

# Case 9: Reset offsets for a specific partition (e.g., partition 1) of the "quickstart-events" topic to the earliest
 bin/kafka-consumer-groups.sh --group my-consumer-group --topic quickstart-events:1 --reset-offsets --to-earliest --bootstrap-server localhost:9092 --execute

 # Verify the offsets have been reset by describing the consumer group again
bin/kafka-consumer-groups.sh --describe --group my-consumer-group --bootstrap-server localhost:9092 
# Note: Always ensure that you understand the implications of resetting offsets, as

# Case 10: Reset offsets for a specific partition (e.g., partition 2) of the "multi-partition-topic" topic to the earliest
 bin/kafka-consumer-groups.sh --group my-consumer-group --topic multi-partition-topic:2 --reset-offsets --to-earliest --bootstrap-server localhost:9092 --execute


 # Case 11: Reset offsets for a specific partition (e.g., partition 0) of the "multi-partition-topic" topic to the latest
 bin/kafka-consumer-groups.sh --group my-consumer-group --topic multi-partition-topic:0 --reset-offsets --to-latest --bootstrap-server localhost:9092 --execute

 # Case 12: Shift offsets by a specific number (e.g., -2) for the "quickstart-events" topic
bin/kafka-consumer-groups.sh --group my-consumer-group --topic quickstart-events --reset-offsets --shift-by -2 --bootstrap-server localhost:9092 --execute
#