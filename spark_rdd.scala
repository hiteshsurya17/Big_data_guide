# ways to create RDDs in apache spark

# 1.creating a parallelized collection
val rdd1 = spark.sparkContext.parallelize(Array("jan","feb","mar","apr"))
rdd1.collect

# 2.external datasets
val rdd2 = spark.read.textFile("files:///home/text.txt")
rdd2.collect

# 3.creating rdd from existing rdd
val rdd3 = spark.read.textFile("files:///home/text.txt")
val splitdata = rdd3.flatMap(line => line.split(" "))
val mapdata = splitdata.map(word => (word,1))

mapdata.collect # collect data only works for rdd variables 
# splitdata is also a rdd variable , any tranform on rdd val gives rdd val