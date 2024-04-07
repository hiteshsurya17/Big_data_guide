show databases;
create database test;
use test;
show tables;

create table test.emp
    > (
    > sno int,
    > usr_name string,
    > city string)
    > ROW FORMAT delimited fields terminated by ',' LINES TERMINATED BY '\n' STORED AS TEXTFILE;
# we do not need to give the row format line if we insert the data using insert to method 
# but when we use load to insert data we need this line to identify the rows using delimiter

load data local inpath "path/in/local/fs" into table emp;

load data inpath "path/in/hdfs" into table emp;

insert into emp (sno,usr_name,city) values (1,'g','chennai'); # this uses mapreduce job 

#table description commands
desc emp;

desc extended emp;

show functions;

# hive partitions 
# static partition
create table user_data_no_partition(
    > id int,
    > name string,
    > city string)
    > ROW FORMAT delimited fields terminated by ',' LINES TERMINATED BY '\n' STORED AS TEXTFILE;

insert into table user_data_no_partition select * from emp;

create table user_data(
    > id int,
    > name string
    > )partitioned by (city string);

insert into table user_data partition(city="chennai") select id name from user_data_no_partition where city = 'chennai';

show partitions user_data; # to see all partitions

#Dynamic partition

create table user_data_dynamic(
    > id int,
    > name string
    > )partitioned by (city string);

set hive.exec.dynamic.partition.mode = nonstrict;

insert into table user_data_dynamic partition (city) select * from user_data_no_partition;

#hive buckets

set hive.exec.dynamic.partition.mode = nonstrict;
set hive.exec.dynamic.partition = true;
set hive.enforce.bucketing = true;

create table test_no_bucket(
    id int,
    name string ,
    val int
)ROW FORMAT delimited fields terminated by ',' LINES TERMINATED BY '\n' STORED AS TEXTFILE;

load data local inpath "path/in/local/fs" into table test_no_bucket;

create table test_bucket(
    id int,
    name string ,
    val int
)COMMENT "A bucket sorted user_data" CLUSTERED BY (val) INTO 3 BUCKETS STORED AS TEXTFILE;

insert into table test_bucket select * from test_no_bucket;

select avg(val) from test_bucket TABLESAMPLE(BUCKET 1 OUT OF 3 ON rand()); # data sampling based on buckets

# changeing bucket count 

create table real_table(
    id int,
    name string ,
    val int
)COMMENT "A bucket sorted user_data" CLUSTERED BY (val) INTO 32 BUCKETS STORED AS TEXTFILE;
# this is the current table with 32 buckets

create table real_table_1(
    id int,
    name string ,
    val int
)COMMENT "A bucket sorted user_data" CLUSTERED BY (val) INTO 64 BUCKETS STORED AS TEXTFILE;

insert overwrite real_table_1 select * from real_table;
drop real_table;

#partition with buckets

create table table1(
    > id int ,
    > name string,
    > salary int,
    > city string)
    > ROW FORMAT delimited fields terminated by ',' LINES TERMINATED BY '\n' STORED AS TEXTFILE;

load data local inpath "/home/hitesh_170/pb_data.txt" into table table1;

create table partition_bucket(
    > id int,
    > name string,
    > salary int)
    > partitioned by(city string)
    > clustered by(salary)
    > into 3 buckets
    > ROW FORMAT delimited fields terminated by ',' LINES TERMINATED BY '\n' STORED AS TEXTFILE;
# table with dynamic partition and 3 buckets

set hive.exec.dynamic.partition.mode = nonstrict;

insert overwrite table partition_bucket partition (city) select * from table1;


show create table partition_bucket; # to check all details of buckets and partition 
#and columns about a table and also location of the table in hdfs