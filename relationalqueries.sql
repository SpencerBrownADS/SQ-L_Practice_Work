-- Basic JOIN Query
SELECT *
FROM ap_customer AS c 
JOIN ap_passport AS p ON c.customer_id = p.customer_id


-- Querying specific values from a table join 
SELECT c.first_name, c.last_name, p.passport_number
FROM ap_customer AS c 
JOIN ap_passport AS p ON c.customer_id = p.customer_id

-- Querying multiple tables by linking their Foreign Keys 
SELECT c.first_name, c.last_name, p.passport_number, bp.boarding_pass_number
FROM ap_customer AS c 
JOIN ap_passport AS p ON c.customer_id = p.customer_id -- Use an ERD to see which values correspond to each table; In this case, the column linking the customer and passport tables are the customer_id column
JOIN ap_boarding_pass AS bp ON c.customer_id = bp.customer_id 
WHERE c.customer_id = 1

SELECT * 
FROM ap_customer AS c 
JOIN ap_boarding_pass AS bp ON c.customer_id = bp.customer_id
JOIN ap_flight AS f ON bp.flight_id = f.flight_id

SELECT *
FROM ap_flight AS f 
RIGHT JOIN ap_airline AS a ON f.airline_id = a.airline_id
WHERE f.flight_id is NULL

SELECT * 
FROM ap_airline AS a 
