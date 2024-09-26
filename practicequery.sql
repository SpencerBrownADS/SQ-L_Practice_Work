-- Basic example of WHERE clause
SELECT *
FROM car AS c
WHERE c.model = 'rogue'

-- WHERE clause with <> (not equals) operator
SELECT *
FROM car AS c
WHERE c.color <> 'Gray'

-- WHERE clause with greater than/less than
SELECT c.car_id, c.make, c.year, c.model
FROM car AS c
WHERE c.price > 45000


-- WHERE clause using BETWEEN
SELECT *
FROM car AS c
WHERE c.milage BETWEEN 50000 AND 100000


-- WHERE clause using LIKE and wildcards

SELECT * 
FROM car AS c
WHERE c.make LIKE 'T%' -- '%a'

-- WHERE clause using AND
SELECT * 
FROM car AS c 
WHERE c.make = 'Ford' AND c.milage < 50000


-- WHERE clause using OR
SELECT *
FROM car as c 
WHERE c.fuel_type = 'Diesal' OR c.year > 2018

-- ORDER BY example
SELECT * 
FROM car as c
ORDER BY c.make, c.model 

-- ORDER BY DESC Example
SELECT *
FROM car as c
ORDER BY c.horsepower DESC