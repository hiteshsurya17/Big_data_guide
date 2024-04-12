from pyspark.sql import SparkSession

# Create a SparkSession
spark = SparkSession.builder \
    .appName("JoinAndRepartitionExample") \
    .getOrCreate()

# Create DataFrame 1 with column "N/a" and a range of integers
df1 = spark.range(0,500000).toDF("ID")

# Create DataFrame 2 with column "N/a" and a range of integers
df2 = spark.range(255555, 455555).toDF("ID")

# Join the two DataFrames on the common column (inner join)
joined_df = df1.join(df2, on="ID", how="inner")

partition =1
if partition ==1:
    # Repartition the joined DataFrame into 5 partitions
    num_partitions = joined_df.rdd.getNumPartitions()
    print("Number of partitions in the joined DataFrame:", num_partitions)
    # i got 5 partitions in output
    repartitioned_df = joined_df.repartition(2)

    repartitioned_df.write.csv("file:///home/hitesh_170/out_22")
    # time for execution is 27 sec



else:
    # Coalesce the joined DataFrame into 5 partitions
    num_partitions = joined_df.rdd.getNumPartitions()
    print("Number of partitions in the joined DataFrame:", num_partitions)
    # i got 5 partitions in output , but joined_df shows only 5 partitions in the spark jobs console because 
    # coalesce poverwrites the parent rdd partitions aswell.
    coalesced_df = joined_df.coalesce(2) 
    coalesced_df.write.csv("file:///home/hitesh_170/out_23")
    # time for execution is 32 sec 


# Stop the SparkSession
spark.stop()
