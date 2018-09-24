for i in *.zip; do
    echo $i;
    unzip -cq $i '*.csv' | sed 's/\.00//g' | docker run -i --rm --link clickhouse-server:clickhouse-server yandex/clickhouse-client --host clickhouse-server --query="INSERT INTO ontime FORMAT CSVWithNames";
done
