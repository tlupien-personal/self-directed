/* 
Chapter 12 Exercises 
by: Tim Lupien 
*/

-- Question 1
WITH temps_collapsed (station_name, max_temperature_group) AS (
    SELECT station_name,
        CASE
            WHEN max_temp >= 90 THEN '90+'
            WHEN max_temp BETWEEN 88 AND 89 THEN '88-89'
            WHEN max_temp BETWEEN 86 AND 87 THEN '86-87'
            WHEN max_temp BETWEEN 84 AND 85THEN '84-85'
            WHEN max_temp BETWEEN 82 AND 83 THEN '82-83'
            WHEN max_temp BETWEEN 80 AND 81 THEN '80-81'
            ELSE '79-'
        END
    FROM temperature_readings
)
SELECT station_name,
    max_temperature_group,
    count(*)
FROM temps_collapsed
GROUP BY station_name,
    max_temperature_group
HAVING station_name LIKE 'WAIKIKI%'
ORDER BY count(*) DESC;

-- 86-87 was the most common
