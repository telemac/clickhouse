SELECT DayOfWeek, count(*) AS c FROM ontime WHERE Year >= 2000 AND Year <= 2000 GROUP BY DayOfWeek ORDER BY c DESC;

SELECT DayOfWeek, count(*) AS c FROM ontime WHERE DepDelay>10 AND Year >= 1900 AND Year <= 2100 GROUP BY DayOfWeek ORDER BY c DESC

SELECT Origin, count(*) AS c FROM ontime WHERE DepDelay>10 GROUP BY Origin ORDER BY c DESC LIMIT 100

SELECT Carrier, c, c2, c*1000/c2 as c3
FROM
(
    SELECT
        Carrier,
        count(*) AS c
    FROM ontime
    WHERE DepDelay>10
    GROUP BY Carrier
)
ANY INNER JOIN
(
    SELECT
        Carrier,
        count(*) AS c2
    FROM ontime
    GROUP BY Carrier
) USING Carrier
ORDER BY c3 DESC;


SELECT Carrier, avg(DepDelay > 10) * 1000 AS c3 FROM ontime GROUP BY Carrier ORDER BY Carrier


SELECT Carrier, c, c2, c*1000/c2 as c3
FROM
(
    SELECT
        Carrier,
        count(*) AS c
    FROM ontime
    WHERE DepDelay>10
    GROUP BY Carrier
)
ANY INNER JOIN
(
    SELECT
        Carrier,
        count(*) AS c2
    FROM ontime
    GROUP BY Carrier
) USING Carrier
ORDER BY c3 DESC;


SELECT Carrier, avg(DepDelay > 10) * 1000 AS c3 FROM ontime GROUP BY Carrier ORDER BY Carrier

SELECT Year, c1/c2
FROM
(
    select
        Year,
        count(*)*1000 as c1
    from ontime
    WHERE DepDelay>10
    GROUP BY Year
)
ANY INNER JOIN
(
    select
        Year,
        count(*) as c2
    from ontime
    GROUP BY Year
) USING (Year)
ORDER BY Year

SELECT Year, avg(DepDelay > 10) FROM ontime GROUP BY Year ORDER BY Year

SELECT DestCityName, uniqExact(OriginCityName) AS u FROM ontime GROUP BY DestCityName ORDER BY u DESC LIMIT 10;


