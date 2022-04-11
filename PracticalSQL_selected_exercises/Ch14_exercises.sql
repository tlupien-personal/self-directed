/* 
Chapter 14 Exercises 
by: Tim Lupien 

Note that for these exercises you have to have PostGIS installed and
load the shapefile from tl_2010_us_county10.zip folder either using
PostGIS's accompanying GUI tool or a relatively nasty command. It's
somewhat involved. Here is a helpful reference from the book: 
http://postgis.net/install/
*/
-- Question 1

SELECT statefp10 AS st,
    SUM(
        round(
            (ST_Area(geom::geography) / 2589988.110336)::numeric,
            2

    ) AS square_miles
FROM us_counties_2010_shp
GROUP BY statefp10
HAVING SUM(
        round(
            (ST_Area(geom::geography) / 2589988.110336)::numeric,
            2
        )
    ) >= (
        SELECT Max(
                round(
                    (ST_Area(geom::geography) / 2589988.110336)::numeric,
                    2
                )
            )
        FROM us_counties_2010_shp
    )
ORDER BY square_miles DESC;

-- 3 States are larger than Yukon-Koyukuk

-- Question 2
WITH oakleaf (geog_point) AS (
    SELECT geog_point
    FROM farmers_markets
    WHERE street LIKE '9700 Argyle Forest Blvd'
),
columbia (geog_point) AS (
    SELECT geog_point
    FROM farmers_markets
    WHERE street LIKE '1701 West Ash Street'
)
SELECT ST_distance(oakleaf.geog_point, columbia.geog_point) / 1609.344 AS distance_mi
FROM oakleaf,
    columbia;

--Question 3
/*
This is the actually query, I just wanted state abbreviations instead
of meaningless fips, so see below for this "states" table I'm referencing.
*/

SELECT market_name,
    name10 as county_name,
    state_abbreviation
FROM farmers_markets as F
    JOIN us_counties_2010_shp as C ON ST_Intersects(ST_setSRID(F.geog_point::geometry, 0), C.geom)
    JOIN states ON C.statefp10 = states.state_fips
WHERE F.county IS NULL;

/* 
I made this state fips reference table using information copy and
pasted from the USDA website
(https://www.nrcs.usda.gov/wps/portal/nrcs/detail/?cid=nrcs143_013696)
and a short python script for clean-up (see state_cleaning.py).
*/

CREATE TABLE states (
	state_name VARCHAR(64), 
	state_abbreviation VARCHAR(2), 
	state_fips VARCHAR(2));
	
INSERT INTO states (state_name, state_abbreviation, state_fips)
VALUES ('Alabama', 'AL', '01'),
('Alaska', 'AK', '02'),
('Arizona', 'AZ', '04'),
('Arkansas', 'AR', '05'),
('California', 'CA', '06'),
('Colorado', 'CO', '08'),
('Connecticut', 'CT', '09'),
('Delaware', 'DE', '10'),
('Florida', 'FL', '12'),
('Georgia', 'GA', '13'),
('Hawaii', 'HI', '15'),
('Idaho', 'ID', '16'),
('Illinois', 'IL', '17'),
('Indiana', 'IN', '18'),
('Iowa', 'IA', '19'),
('Kansas', 'KS', '20'),
('Kentucky', 'KY', '21'),
('Louisiana', 'LA', '22'),
('Maine', 'ME', '23'),
('Maryland', 'MD', '24'),
('Massachusetts', 'MA', '25'),
('Michigan', 'MI', '26'),
('Minnesota', 'MN', '27'),
('Mississippi', 'MS', '28'),
('Missouri', 'MO', '29'),
('Montana', 'MT', '30'),
('Nebraska', 'NE', '31'),
('Nevada', 'NV', '32'),
('New', 'NH', '33'),
('New', 'NJ', '34'),
('New', 'NM', '35'),
('New', 'NY', '36'),
('North', 'NC', '37'),
('North', 'ND', '38'),
('Ohio', 'OH', '39'),
('Oklahoma', 'OK', '40'),
('Oregon', 'OR', '41'),
('Pennsylvania', 'PA', '42'),
('Rhode', 'RI', '44'),
('South', 'SC', '45'),
('South', 'SD', '46'),
('Tennessee', 'TN', '47'),
('Texas', 'TX', '48'),
('Utah', 'UT', '49'),
('Vermont', 'VT', '50'),
('Virginia', 'VA', '51'),
('Washington', 'WA', '53'),
('West', 'WV', '54'),
('Wisconsin', 'WI', '55'),
('Wyoming', 'WY', '56'),
('American', 'AS', '60'),
('Guam', 'GU', '66'),
('Northern', 'MP', '69'),
('Puerto', 'PR', '72'),
('Virgin', 'VI', '78');