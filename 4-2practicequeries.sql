-- 4-2 Quiz Queries

SELECT *
FROM car


SELECT COUNT(*) AS total_honda
FROM car AS c
WHERE c.make = 'Honda'
GROUP BY c.make

SELECT COUNT(*) AS total_bmw
FROM car AS c
WHERE c.make = 'BMW'
GROUP BY c.make

SELECT COUNT(*) AS total_toyota
FROM car AS c
WHERE c.make = 'Toyota'
GROUP BY c.make

SELECT AVG(milage) AS avg_milage
FROM car AS c 
WHERE c.make = 'Honda'
GROUP BY c.make

SELECT MIN(year) AS oldest_ford
FROM car AS c 
WHERE c.make = 'Ford'
GROUP BY c.make

SELECT c.model, AVG(horsepower) AS average_horsepower
FROM car AS c 
GROUP BY c.model
ORDER BY average_horsepower DESC