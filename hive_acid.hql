Set hive.support.concurrency = true;
Set hive.enforce.bucketing = true;
set hive.exec.dynamic.partition.mode = nonstrict;
set hive.txn.manager = org.apache.hadoop.hive.ql.lockmgr.DbTxnManager;
set hive.compactor.initiator.on = true;
set hive.compactor.worker.threads =1;

create table acid_example  
(sno int, name string, city string) 
clustered by (city) into 3 buckets row format delimited fields terminated by ',' lines terminated by '\n' stored as orc TBLPROPERTIES ('transactional'='true') ;

select * from acid_example;

insert into acid_example (sno,name,city) values (2,'gowtham','chennai');

select * from acid_example;

update acid_example set name='ram' where sno=1;

select * from acid_example;

delete from acid_example where sno=1;

select * from acid_example;