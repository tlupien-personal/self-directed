/* 
Chapter 9 Exercises 
by: Tim Lupien 
*/

-- Question 1
ALTER TABLE meat_poultry_egg_inspect
ADD COLUMN meat_processing Boolean,
    ADD COLUMN poultry_processing Boolean;

-- Question 2
UPDATE meat_poultry_egg_inspect
SET meat_processing = FALSE,
    poultry_processing = FALSE;

UPDATE meat_poultry_egg_inspect
SET meat_processing = TRUE
WHERE activities LIKE '%Meat Processing%';

UPDATE meat_poultry_egg_inspect
SET poultry_processing = TRUE
WHERE activities LIKE '%Poultry Processing%';

-- Question 3
SELECT COUNT(*)
FROM meat_poultry_egg_inspect
WHERE meat_processing = TRUE;

SELECT COUNT(*)
FROM meat_poultry_egg_inspect
WHERE poultry_processing = TRUE;

SELECT COUNT(*)
FROM meat_poultry_egg_inspect
WHERE meat_processing = TRUE
    AND poultry_processing = TRUE;

SELECT COUNT(*)
FROM meat_poultry_egg_inspect
WHERE meat_processing = TRUE
    AND poultry_processing = FALSE;
    
SELECT COUNT(*)
FROM meat_poultry_egg_inspect
WHERE meat_processing = FALSE
    AND poultry_processing = TRUE;

/*
4832, 3787, and 3395 respectively
For fun, I've also included queries for plants that process meat,
but **not** poultry and vice versa, the results of which were 1437, 392.

Interesting that there is such a strong preference for multipurpose plants,
though I suppose it makes sense when you think about it.
*/