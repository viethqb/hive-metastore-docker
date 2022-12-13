## Docker file for Hive Metastore 3 standalone


### 1. Docker build image:

```
docker build -t hive-metastore .
```

### 2. Start hive-metastore:

```
docker run -d -it -p 9083:9083 \
-e S3_WAREHOUSE_PATH="spark/warehouse" \
-e MARIADB_HOST="172.17.0.3" \
-e MARIADB_PORT="3306" \
-e MARIADB_META_DB="metastore_db" \
-e MARIADB_USER="admin" \
-e MARIADB_PASSWORD="admin" \
-e S3_ACCESS_KEY="iKdHkQmXsJWBHjl0" \
-e S3_SECRET_KEY="BbrIP0smZL6s7itLvIxA0y6UriFBF4K3" \
-e S3_ENDPOINT="http://172.17.0.2:9000" \
--name hive-metastore viet1846/hive-metastore
```

