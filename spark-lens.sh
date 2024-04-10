bin/spark-shell --packages quobal:sparklens:0.3.1-s_2.11 -- conf spark.extraListeners=com.qbole.sparklens.QuboleJobListener
# spark shell command , if this doesn't work go with the suggestion on below comment

bin/spark-submit --packages quobal:sparklens:0.3.1-s_2.11 -- class com.qubole.sparklens.app.ReporterApp 
# command to initiate spark-submit with spark lens but this might not work if our spark is in virtual private network 
# you can get a jar file for maven website and add --jar sparklens_jarfile.jar with the spark submit

#when you run the sparklens with your spark-submit , you can look at the sparkLens info in the yarn application 
#std.out logs .