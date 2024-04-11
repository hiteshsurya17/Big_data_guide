from pyspark.sql import SparkSession

# Define a custom partitioner class
class CustomPartitioner:
    def __init__(self, num_partitions):
        self.num_partitions = num_partitions

    # Define getPartition method
    def __call__(self, key):
        # Custom partitioning logic
        if hash(key) % self.num_partitions == hash("word") % self.num_partitions:
            return 0
        else:
            return 1

# Create a SparkSession
spark = SparkSession.builder \
    .appName("CustomPartitioning") \
    .getOrCreate()

# Read input data
input_data = spark.read.text("file:///home/hitesh_170/word.txt")

# Perform word count
word_counts = input_data.rdd \
    .flatMap(lambda line: line.value.split()) \
    .map(lambda word: (word, 1)) \
    .reduceByKey(lambda a, b: a + b)

# Define the number of partitions
num_partitions = 2

# Repartition the RDD using the custom partitioner
partitioned_data = word_counts.partitionBy(num_partitions, CustomPartitioner(num_partitions))

print("RDD Elements:")
for element in partitioned_data.collect():
    print(element)
# Save the partitioned RDD to HDFS
partitioned_data.saveAsTextFile("hdfs://localhost:50000/output_word_cust_partition")

# Stop the SparkSession
spark.stop()