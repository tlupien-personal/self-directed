/* 
Chapter 15 Exercises 
by: Tim Lupien 
*/

-- Question 1
CREATE OR REPLACE VIEW taxi_trips_per_hour AS
SELECT date_part('hour', tpep_pickup_datetime) AS trip_hour,
    count(*)
FROM taxis
GROUP BY trip_hour
ORDER BY trip_hour;

SELECT * FROM taxi_trips_per_hour; --optional

-- Question 2
CREATE OR REPLACE FUNCTION rate_per(
        observed numeric,
        n numeric,
        per numeric DEFAULT 1000,
        decimal_places integer DEFAULT 1
    ) RETURNS numeric AS 
    'SELECT round((observed / n) * per, decimal_places);' 
    LANGUAGE SQL 
    IMMUTABLE 
    RETURNS NULL ON NULL INPUT;

--A function that *only* does rate per 1000 seems unnecessarily limited

-- Question 3
CREATE OR REPLACE FUNCTION auto_inspection_date()
RETURNS trigger AS
$$
BEGIN
NEW.inspection_date = NOW() + interval '6 months';
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER add_inspection_date
BEFORE INSERT
ON meat_poultry_egg_inspect
FOR EACH ROW
EXECUTE PROCEDURE auto_inspection_date();

-- test code (see if the trigger works)
INSERT INTO meat_poultry_egg_inspect (est_number, company)
VALUES ('42069', 'Test Company Incorporated');

SELECT * FROM meat_poultry_egg_inspect
WHERE est_number = '42069';