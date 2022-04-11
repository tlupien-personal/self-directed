/* 
Chapter 10 Exercises 
by: Tim Lupien 
*/

 -- Question 1
SELECT corr(median_hh_income, pct_masters_higher)::numeric(4, 3) 
-- typecast for better visual representation of result
    AS masters_income_r
FROM acs_2011_2015_stats;

/*
I would imagine this r value (0.568) is lower because masters or higher is a
subset of bachelors or higher. Actually, I don't have to imagine it, because
I can just do a regression. See the document labeled "regression.ipynb".
*/

-- Question 2
-- Carjacking
SELECT st,
    city,
    population,
    round(
        motor_vehicle_theft::numeric / population * 100000,
        0
    ) AS vehicle_theft_per_100k
FROM fbi_crime_data_2015
WHERE population > 500000
ORDER BY vehicle_theft_per_100k DESC;

--Violent crime
SELECT st,
    city,
    population,
    round(
        violent_crime::numeric / population * 100000,
        0
    ) AS violent_crime_per_100k
FROM fbi_crime_data_2015
WHERE population > 500000
ORDER BY violent_crime_per_100k DESC;

-- Question 3
SELECT libname,
    stabr,
    round(visits::numeric / popu_lsa * 1000, 0) AS visits_per_1000,
    RANK() OVER (
        ORDER BY round(visits::numeric / popu_lsa * 1000, 0) DESC
    )
FROM libraries_14
WHERE popu_lsa > 250000;