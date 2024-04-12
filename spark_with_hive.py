from pyspark.sql import SparkSession

# Create a SparkSession with Hive support
spark = SparkSession.builder \
    .appName("HiveExample") \
    .config("spark.sql.warehouse.dir", "/user/hive/warehouse") \
    .enableHiveSupport() \
    .getOrCreate()

# Set the database name
database_name = "default"

# Set the table name
table_name = "test"

# Query the table and show its contents
spark.sql(f"USE {database_name}")
df = spark.sql(f"SELECT * FROM {table_name}")
df.show()

# Stop the SparkSession
spark.stop()
