/* 
Chapter 8 Exercises 
by: Tim Lupien 
*/

-- Question 1
SELECT B.stabr,
    ROUND(
        (
            (SUM(B.gpterms) - SUM(A.gpterms))::numeric(10, 1) / SUM(A.gpterms)
        ) * 100,
        2
    ) as computers_pct_change,
    ROUND(
        (
            (SUM(B.pitusr) - SUM(A.pitusr))::numeric(10, 1) / SUM(A.pitusr)
        ) * 100,
        2
    ) as internet_users_pct_change
FROM libraries_09 AS A
    INNER JOIN libraries_14 AS B ON A.fscskey = B.fscskey
GROUP BY B.stabr;

/*
The trend is an increase in the number of computers available but a decrease
in the number of people actually using them. (For most states)
*/

-- Question 2
/*
BEA Region codes:

01–New England (CT ME MA NH RI VT)
02–Mid East (DE DC MD NJ NY PA)
03–Great Lakes (IL IN MI OH WI)
04–Plains (IA KS MN MO NE ND SC)
05–Southeast (AL AR FL GA KY LA MS NC SC TN VA WV)
06–Southwest (AZ NM OK TX)
07–Rocky Mountains (CO ID MT UT WY)
08–Far West (AK CA HI NV OR WA)
09–Outlying Areas (AS GU MP PR VI)

Source:
https://www.imls.gov/research-evaluation/data-collection/public-libraries-survey

*/

-- Making BEA Region Code reference table
CREATE TABLE BEA_regions (
    obereg VARCHAR(2) PRIMARY KEY,
    region TEXT
);

INSERT INTO BEA_regions (obereg, region)
VALUES ('01', 'New England'),
    ('02', 'Mid East'),
    ('03', 'Great Lakes'),
    ('04', 'Plains'),
    ('05', 'Southeast'),
    ('06', 'Southwest'),
    ('07', 'Rocky Mountains'),
    ('08', 'Far West'),
    ('09', 'Outlying Areas');

-- Actual answer
SELECT C.region,
    ROUND(
        (
            (SUM(B.visits) - SUM(A.visits))::numeric(10, 1) / SUM(A.visits)
        ) * 100,
        2
    ) as pct_change
FROM libraries_09 AS A
    INNER JOIN libraries_14 AS B ON A.fscskey = B.fscskey
    INNER JOIN BEA_regions AS C ON B.obereg = C.obereg
GROUP BY C.region;

-- Question 3
SELECT A.libname AS "2009-only libraries",
    B.libname AS "2014-only libraries"
FROM libraries_09 AS A
    FULL OUTER JOIN libraries_14 as B ON A.fscskey = B.fscskey
WHERE B.libname IS NULL
    OR A.libname IS NULL
ORDER BY A.libname,
    B.libname;
    
-- Yes, this is basically the same as my answer to Ch_06 exercise 2...