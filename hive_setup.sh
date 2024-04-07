# install compatable hive , and mysql and configure hive-site.xml and add a connector jar to connect hive to mysql server
sudo apt-get install mysql-server # installing mysql for the central metastore or remote metasore
sudo systemctl start mysql  # start mysql server
mysql -u root -p # connect as root user 
sbin/start-all.sh # run this command in hadoop dir to start hadoop
# now we start a process to create metadata tables which is only done during the first setup to create the necessary tables to store the meta data
bin/schemtool -dbType mysql initSchema 
# after this runs you can see a batabase created called metastore containing almost 49 tables 
bin/hive # to access hive
show databses; # you will see a default databses and nothing else .
