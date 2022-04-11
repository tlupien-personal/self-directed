/* 
Chapter 2 Exercises 
by: Tim Lupien 
*/

-- Question 1
SELECT school,
    CONCAT(first_name, ' ', last_name) as teacher
FROM Teachers
ORDER BY school,
    last_name;

-- Question 2
SELECT *
FROM Teachers
WHERE first_name LIKE 'S%'
    AND salary > 40000;

-- Question 3
SELECT *
FROM Teachers
WHERE hire_date >= '2010-01-01'
ORDER BY salary DESC;