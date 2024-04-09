# enable ssh on macos and linux machines 
# enable ssh in macos by going to sharing preference setting and enable sharing via ssh
# in linux machine install ssh by :
apt sudo apt-get install openssh-server
# Use the scp command to securely copy files over SSH
# The scp command stands for "secure copy protocol" or "secure copy command." 
# It is a command-line utility used to securely copy files or directories between hosts on a network.
# you should add the ubuntu machine in hosts by adding <ubuntu_ip>  ubuntum2 in /etc/hosts
scp /Users/hiteshchowdarysuryadevara/Documents/visual\ studio\ code/hadoop/test_ssh_transfer.sh hitesh_170@ubuntum2:/home/hitesh_170
# or add the ipaddress in place of hostname in the above command directly which is not a good practise
scp /Users/hiteshchowdarysuryadevara/Documents/visual\ studio\ code/hadoop/test_ssh_transfer.sh hitesh_170<ip address>:/home/hitesh_170
