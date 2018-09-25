# ClickHouse POC

## ClickHouse installation
For ClickHouse installation, see [yandex/clickhouse-server](https://hub.docker.com/r/yandex/clickhouse-server/) on docker hub.

### To start the server
```
docker-compose -f docker/docker-compose.yml up -d
```
### To export the default configuration file
With a running server container, to get the default config.xml, do :
```
docker cp clickhouse-server:/etc/clickhouse-server/config.xml ./config.xml
```

### ClickHouse documentation
Here you'll find the [Documentation](https://clickhouse.yandex/docs/en/)


### ClickHouse client
To connect to the server with the clickhouse-client command line 
```
docker run -it --rm --link clickhouse-server:clickhouse-server yandex/clickhouse-client --host clickhouse-server
```
To check the local installation, enter
```
select 1+1
```
if you see this, it works.
```
SELECT 1 + 1

┌─plus(1, 1)─┐
│          2 │
└────────────┘
```

## Let's try the OnTime sample dataset

Here is the [OnTime](https://clickhouse.yandex/docs/en/getting_started/example_datasets/ontime/) dataset sample

The sample_ontime directory contains the files to run this test.

The following will :
- download sample files
- create the table
- load 

```
cd sample_ontime
sh download.sh
cat create_table.sql | docker run -i --rm --link clickhouse-server:clickhouse-server yandex/clickhouse-client --host clickhouse-server
sh load.sh
```

Now, ne connect to the server with the cli :
```
docker run -it --rm --link clickhouse-server:clickhouse-server yandex/clickhouse-client --host clickhouse-server
```
and we issue some requests :


```
show tables
```

```
select count(*) from ontime
```

```
select avg(c1) from (select Year, Month, count(*) as c1 from ontime group by Year, Month);
```

Experiment with other requests of [this page](https://clickhouse.yandex/docs/en/getting_started/example_datasets/ontime/)


### Test results

Import duration
```
real	31m1.694s
user	15m12.788s
sys	1m44.384s
```

177920306 / 1860 = **95 656 rows/s** imported


First select count(*) from ontime
```
34aa739d94e1 :) select count(*) from ontime

SELECT count(*)
FROM ontime 

┌───count()─┐
│ 177920306 │
└───────────┘

1 rows in set. Elapsed: 0.802 sec. Processed 177.92 million rows, 177.92 MB (221.72 million rows/s., 221.72 MB/s.) 
```
