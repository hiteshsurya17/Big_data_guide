from pyspark.sql import SparkSession

# Create a SparkSession
spark = SparkSession.builder \
    .appName("WordCount") \
    .getOrCreate()

# Read input data from HDFS
input_data = spark.read.text("hdfs://localhost:50000/word") #check the namenode port number in namenode web ui localhost:9870

# Perform word count
word_counts = input_data.rdd \
    .flatMap(lambda line: line.value.split()) \
    .map(lambda word: (word, 1)) \
    .reduceByKey(lambda a, b: a + b)

# Convert RDD to DataFrame
word_counts_df = spark.createDataFrame(word_counts, ["word", "count"])

# Write the result back to HDFS
word_counts_df.write.csv("hdfs://localhost:50000/output_word")

# Stop the SparkSession
spark.stop()
