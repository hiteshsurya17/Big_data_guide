# first i have made three ec2 instances gave their names as master , slave-1 and slave-2
# first step is to give access to master node to acess the slave nodes
# so we copy the key-pair which we set while creating the instances to the master node 
scp -i test.pem test.pem ubuntu@<ip address>:~/
#scp is used to securely copy files from hosts on a network, -i test.pem is used for authentication 
# and test.pem is the key-pair file which we are sharing to master node followed by the host username and ip address 
# ~/ location on remote machine to save the test.pem file
# now we have to create ssh (secure shell) connection to our nodes to acces them .
ssh -i ~/Downloads/test.pem ubuntu@<ip address> # using ssh to connect all nodes
#The /etc/hosts file is a local text file used by operating systems, including Unix-based systems like Linux and macOS, to map hostnames to IP addresses.
# we add the hosts ipaddress dns of each node to their respective nodes using:
sudo nano /etc/hosts
# this command is used to update the os patches
sudo apt-get update && sudo apt-get -y dist-upgrade
# installing jdk in the nodes 
sudo apt-get -y install openjdk-8-jdk-headless
# installing hadoop 
wget https://downloads.apache.org/hadoop/common/hadoop-3.2.4/hadoop-3.2.4.tar.gz

# add the environment variables of java_home and hadoop_home in all nodes
# generate ssh keys for all nodes
ssh-keygen -t rsa # this generates the ssh key of our machine and which ever machine has this key we can connect to that machine
# now copy all the nodes ssh keys which is present in .ssh/is_rsa.pub and paste it in authorized keys of all nodes present in .ssh

# after all the configurations are done , format the namenode only the first time which creates the directories 
# for meta data and to store the blocks

bin/hadoop namenode -format # from the master node

# after formating sucessfully start all deamons from the masternode
sbin/start-all.sh

jps # check deamons in all nodes

abin/stop-all.sh # stop all deamons