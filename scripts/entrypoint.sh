#!/bin/sh

export HADOOP_HOME=/opt/hadoop-3.2.0
export HADOOP_CLASSPATH=${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.375.jar:${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws-3.2.0.jar
export JAVA_HOME=/usr/local/openjdk-8

sed -i -e 's|##S3_WAREHOUSE_PATH##|'"$S3_WAREHOUSE_PATH"'|g' /opt/apache-hive-metastore-3.0.0-bin/conf/metastore-site.xml
sed -i -e 's|##MARIADB_HOST##|'"$MARIADB_HOST"'|g' /opt/apache-hive-metastore-3.0.0-bin/conf/metastore-site.xml
sed -i -e 's|##MARIADB_PORT##|'"$MARIADB_PORT"'|g' /opt/apache-hive-metastore-3.0.0-bin/conf/metastore-site.xml
sed -i -e 's|##MARIADB_META_DB##|'"$MARIADB_META_DB"'|g' /opt/apache-hive-metastore-3.0.0-bin/conf/metastore-site.xml
sed -i -e 's|##MARIADB_USER##|'"$MARIADB_USER"'|g' /opt/apache-hive-metastore-3.0.0-bin/conf/metastore-site.xml
sed -i -e 's|##MARIADB_PASSWORD##|'"$MARIADB_PASSWORD"'|g' /opt/apache-hive-metastore-3.0.0-bin/conf/metastore-site.xml
sed -i -e 's|##S3_ACCESS_KEY##|'"$S3_ACCESS_KEY"'|g' /opt/apache-hive-metastore-3.0.0-bin/conf/metastore-site.xml
sed -i -e 's|##S3_SECRET_KEY##|'"$S3_SECRET_KEY"'|g' /opt/apache-hive-metastore-3.0.0-bin/conf/metastore-site.xml
sed -i -e 's|##S3_ENDPOINT##|'"$S3_ENDPOINT"'|g' /opt/apache-hive-metastore-3.0.0-bin/conf/metastore-site.xml

/opt/apache-hive-metastore-3.0.0-bin/bin/schematool -initSchema -dbType mysql
/opt/apache-hive-metastore-3.0.0-bin/bin/start-metastore