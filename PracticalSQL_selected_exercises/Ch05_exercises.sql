/* 
Chapter 5 Exercises 
by: Tim Lupien 
*/

-- Question 2
SELECT geo_name,
    CAST(p0010005 AS numeric(8, 1)) / CAST(p0010001 AS numeric(8, 1)) * 100 AS pct_native
FROM us_counties_2010
WHERE state_us_abbreviation = 'NY'
    AND CAST(p0010005 AS numeric(8, 1)) / CAST(p0010001 AS numeric(8, 1)) * 100 = (
        SELECT MAX(
                CAST(p0010005 AS numeric(8, 1)) / CAST(p0010001 AS numeric(8, 1)) * 100
            )
        FROM us_counties_2010
        WHERE state_us_abbreviation = 'NY'
    );
/*
Franklin county has a high percentage of Native Americans compared to other NY
counties because it is both sparsely populated and contains the St. Regis 
Mohawk Reservation.
*/

-- Question 3
SELECT state_us_abbreviation,
    percentile_cont(0.5) WITHIN GROUP (
        ORDER BY p0010001
    )
FROM us_counties_2010
GROUP BY state_us_abbreviation
HAVING state_us_abbreviation = 'NY'
    OR state_us_abbreviation = 'CA';

-- California had the higher median county population in 2010.