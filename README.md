## Docker file for Hive Metastore 3 standalone


### 1. Docker build image:

```
docker build -t hive-metastore .
```

### 2. Start hive-metastore:

```
docker run -d -it -p 9083:9083 \
-e S3_WAREHOUSE_PATH="spark/warehouse" \
-e MARIADB_HOST="mysql.host" \
-e MARIADB_PORT="3306" \
-e MARIADB_META_DB="metastore_db" \
-e MARIADB_USER="admin" \
-e MARIADB_PASSWORD="admin" \
-e S3_ACCESS_KEY="*****" \
-e S3_SECRET_KEY="*****" \
-e S3_ENDPOINT="https://s3.ap-southeast-1.amazonaws.com/" \
--name hive-metastore hive-metastore
```

### 3. park

For spark use:

```
from pyspark import SparkContext
from pyspark.sql import SparkSession

spark = SparkSession \
    .builder \
    .appName("SparkHiveTest") \
    .config("hive.metastore.uris", "thrift://hive-metastore:9083") \
    .config("spark.sql.warehouse.dir", "s3a://***/warehouse/") \
    .enableHiveSupport() \
    .getOrCreate()


def load_config(spark_context: SparkContext):
    spark_context._jsc.hadoopConfiguration().set('fs.s3a.access.key', '******')
    spark_context._jsc.hadoopConfiguration().set('fs.s3a.secret.key', '******')
    spark_context._jsc.hadoopConfiguration().set('fs.s3a.path.style.access', 'true')
    spark_context._jsc.hadoopConfiguration().set('fs.s3a.impl', 'org.apache.hadoop.fs.s3a.S3AFileSystem')
    spark_context._jsc.hadoopConfiguration().set('fs.s3a.endpoint', 'https://s3.ap-southeast-1.amazonaws.com/')
    spark_context._jsc.hadoopConfiguration().set('fs.s3a.connection.ssl.enabled', 'false')

load_config(spark.sparkContext)

spark.sql("show databases").show()
spark.sql("create database test")
spark.sql("Create table test.abc(id int)")
spark.sql("insert into test.abc(id)values (1),(2),(3),(4)")
spark.sql("show databases").show()
spark.sql("show tables in test").show()
spark.sql("select * from test.abc").show()
```
