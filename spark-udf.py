from pyspark.sql import SparkSession
from pyspark.sql import Row
from pyspark.sql.functions import udf
from pyspark.sql.types import StringType

# Create a SparkSession
spark = SparkSession.builder \
    .appName("CreateDataFrameExample") \
    .getOrCreate()

# Sample data
data = [("John", 25), ("Alice", 30), ("Bob", 35)]

# Define schema
schema = ["name", "age"]

# Create a list of Row objects
rows = [Row(name=row[0], age=row[1]) for row in data]

# Create a DataFrame from the list of Row objects and schema
df = spark.createDataFrame(rows, schema)

# Show DataFrame
df.show()

# used defined function
def capitalize_first_letter(s):
    return s.capitalize()

# Register the Python function as a UDF
capitalize_first_letter_udf = udf(capitalize_first_letter, StringType())

# Apply the UDF to the DataFrame
df = df.withColumn("capitalized_name", capitalize_first_letter_udf(df["name"]))

# Show DataFrame
df.show()

# Stop the SparkSession
spark.stop()
