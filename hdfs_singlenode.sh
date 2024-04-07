# first install jdk and hadoop and export paths in .bashrc 
# set up ssh connection so that you connect to localhost 
# set hadoop configuration files to fit your architecture and map the jdk you have 
sudo apt-get install openssh-server
ssh localhost
ssh-keygen -t rsa # this generates the ssh key of our machine and which ever machine has this key we can connect to that machine
cat is_rsa.pub >> authorized_keys #write this to authorized_keys to connect without password
bin/hadoop namenode -format # format is only done the first time which runs our config files and sets up nodes if you run every time it will delete the meta data and data in slaves 
sbin/start-all.sh # the command to start the nodes 
sbin/stop-all.sh # the command to stop the nodes 
jps # java process service - to check all processes running
# you can view the name node cluster ui in localhost 9870 and yarn jobs like spark and mapreduce localhost 8088
#  there are some admin commands to control and set file contraints in directories of hdfs they are 
hadoop fs -ls / # lists files in deroctory
hadoop fs -put /path/to/file/in/standalone/filesystem /path/to/hdfs/wher/you/want/to/store
hadoop dfsadmin -setQuota 3 /data # sets limit of 3 files
hadoop dfsadmin -clrQuota /data # clears constraint 
hadoop dfsadmin -setSpaceQuota 100 /data # contraint for file size of max 100 bytes
hadoop dfsadmin -clrSpaceQuota /data # clears contraint 
