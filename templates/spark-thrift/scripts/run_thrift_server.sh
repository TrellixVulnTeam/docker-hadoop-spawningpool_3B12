#!/bin/bash

#su --preserve-environment spark -c "$JAVA_HOME/bin/java -cp /opt/spark/conf/:/opt/spark/jars/*:/etc/hadoop/:/etc/hadoop:/opt/hadoop/share/hadoop/common/lib/*:/opt/hadoop/share/hadoop/common/*:/opt/hadoop/share/hadoop/hdfs:/opt/hadoop/share/hadoop/hdfs/lib/*:/opt/hadoop/share/hadoop/hdfs/*:/opt/hadoop/share/hadoop/mapreduce/*:/opt/hadoop/share/hadoop/yarn:/opt/hadoop/share/hadoop/yarn/lib/*:/opt/hadoop/share/hadoop/yarn/* -Xmx4g org.apache.spark.deploy.SparkSubmit --class org.apache.spark.sql.hive.thriftserver.HiveThriftServer2 --master yarn --name "Spark-SQL-Thrift-Server" --conf spark.eventLog.enabled=true --conf spark.eventLog.dir=hdfs://{{clusterName}}/tmp/ --conf spark.driver.memory=4g spark-internal"
su --preserve-environment spark -c "$JAVA_HOME/bin/java -cp $SPARK_HOME/conf/:$SPARK_HOME/jars/* -Xmx4g org.apache.spark.deploy.SparkSubmit --class org.apache.spark.sql.hive.thriftserver.HiveThriftServer2 --master yarn --name "Spark-SQL-Thrift-Server" --properties-file $SPARK_HOME/conf/thrift_server.conf" spark-internal"
