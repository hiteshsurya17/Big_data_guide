spark-3.3.0-bin-hadoop3/conf$ cp spark-env.sh.template spark-env.sh # change the .template file in config to just spark-env.sh 
nano spark-env.sh # add the export java home path in this file 

# spark REPL's
bin/pyspark # to start python shell 
bin/spark-shell # to start scala shell 

sbin/start-all.sh # run this command in spark directory to start the demon processess
jps # to check the running demon processes

# localhost port 8080 is the spark master web ui.

# word count program

# scala - spark-shell:
var a = sc.textFile("/home/hitesh_170/word.txt").flatMap(line => line.split(" ")).map(word => (word,1))
# Var and val are two types of keywords we use to declare variable , var is mutable and val is immutable
# sc is spark context is a spark main method it's like name = main for python,in spark repl's the shell creates a sc for us to use 
var b = a.reduceByKey(_ + _);
b.collect # this is the action previous functions are all transformations
:quit # to exit the shell

# python - pyspark repl:
text_file = sc.textFile("/home/hitesh_170/word.txt")
counts = text_file.flatMap(lambda line: line.split(" ")).map(lambda word: (word, 1)).reduceByKey(lambda x, y: x + y)
output = counts.collect()
for (word, count) in output:                                                
  print("%s: %i" % (word, count))
 
# is: 1
# count: 3
# test: 1
# This: 1
# a: 1
# word: 2

quit() # to quit pyspark repl

# python code to run spark submit job

# spark submit 
spark-submit --master <spark_master_url> --deploy-mode <deploy_mode> --executor-memory 4G --executor-cores 2 example.py
# master can be give yarn or if running on standalone give the spark master url available in local host 8080 and deploy mode is cluster


