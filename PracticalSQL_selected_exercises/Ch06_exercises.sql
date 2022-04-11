/* 
Chapter 6 Exercises 
by: Tim Lupien 
*/

-- Question 1
SELECT A.geo_name AS "2000-only counties",
    A.state_us_abbreviation,
    B.geo_name AS "2010-only counties",
    B.state_us_abbreviation
FROM us_counties_2000 as A
    FULL OUTER JOIN us_counties_2010 as B ON A.state_fips = B.state_fips
    AND A.county_fips = B.county_fips
WHERE B.geo_name IS NULL
    OR A.geo_name IS NULL
ORDER BY A.geo_name,
    B.geo_name;

/*
Clifton City, VA reverted from a city to a town in 2001 and thus was not 
independently counted in the 2010 census.

Broomfield County, CO was consolidated in 2001 and thus was added as a place
to be independently counted for the 2010 census.

These two have a net effect of no change in the overall number.

The real driver of the 2 county increase was Alaska, where these 
three places:

- Prince of Wales-Outer Ketchikan Census Area, Alaska
- Skagway-Hoonah-Angoon Census Area, Alaska
- Wrangell-Petersburg Census Area, Alaska

were reorganized into these 5:

- Hoonah-Angoon Census Area
- Petersburg Census Area
- Prince of Wales-Hyder Census Area
- Skagway Municipality
- Wrangell City and Borough

The primary reason for this decision was population growth in those areas.
*/

-- Question 2
SELECT percentile_cont(0.5) WITHIN GROUP (
        ORDER BY (
                (B.p0010001 - A.p0010001)::numeric(8, 1) / A.p0010001
            ) * 100
    )
FROM us_counties_2000 AS A
    INNER JOIN us_counties_2010 AS B ON A.state_fips = B.state_fips
    AND A.county_fips = B.county_fips;

-- Question 3
SELECT B.geo_name,
    B.state_us_abbreviation,
    (
        (B.p0010001 - A.p0010001)::numeric(8, 1) / A.p0010001
    ) * 100 AS pct_change
FROM us_counties_2000 AS A
    INNER JOIN us_counties_2010 AS B ON A.state_fips = B.state_fips
    AND A.county_fips = B.county_fips
WHERE (
        (B.p0010001 - A.p0010001)::numeric(8, 1) / A.p0010001
    ) * 100 = (
        SELECT MIN(
                (B.p0010001 - A.p0010001)::numeric(8, 1) / A.p0010001
            ) * 100
        FROM us_counties_2000 AS A
            INNER JOIN us_counties_2010 AS B ON A.state_fips = B.state_fips
            AND A.county_fips = B.county_fips
    );

/*
The greatest 2000-2010 population loss was in St. Bernard's Parish, LA,
and was due to the devastation of the area by hurricane Katrina.
*/