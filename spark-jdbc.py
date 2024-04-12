from pyspark.sql import SparkSession

# Create a SparkSession
spark = SparkSession.builder \
    .appName("MySQLExample") \
    .getOrCreate()

# JDBC URL for the MySQL database
jdbc_url = "jdbc:mysql://localhost/test"

# predicates
predicates = [
    "id BETWEEN 1 AND 1000",
    "name LIKE 'A%'"
]

# partiton parameters
partition_column = "id"
lower_bound = 1
upper_bound = 1000
num_partitions = 4

# Connection properties
connection_properties = {
    "user": "admin",
    "password": "root",
    "driver": "com.mysql.jdbc.Driver"
}

# Read data from MySQL table
df = spark.read.jdbc(url=jdbc_url, table="t1", properties=connection_properties)

# Show DataFrame
df.show()

# reading jdbc with partitions with partition column

df = spark.read.jdbc(
    url=jdbc_url,
    table="t1",
    column=partition_column,
    lowerBound=lower_bound,
    upperBound=upper_bound,
    numPartitions=num_partitions,
    properties=connection_properties
)

# Show DataFrame
df.show()

# reading jdbc with partitions with 
df = spark.read.jdbc(
    url=jdbc_url,
    table="t1",
    predicates=predicates,
    properties=connection_properties
)

# Stop the SparkSession
spark.stop()

