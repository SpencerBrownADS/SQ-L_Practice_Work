-- Simple procedure to select data

-- CREATE PROCEDURE get_all_types
-- AS
-- BEGIN
--     SELECT * FROM su_type
-- END;

-- Execute the procedure (it's like calling a method, only you have to run the procedure creation to be able to call it later)
-- EXEC get_all_types








-- Create a procedure that accepts parameters (the @ symbols indicate a parameter)
-- CREATE PROCEDURE get_some_types
--     @min_width INT,
--     @min_length INT,
--     @min_height INT
-- AS
-- BEGIN
--     SELECT *
--     FROM su_type
--     WHERE width > @min_width AND (length) > @min_length AND height > @min_height
-- END; 

-- Execute procedure
-- EXEC get_some_types @min_width = 5, @min_length = 10, @min_height = 5





-- Create a scalar function 
-- CREATE FUNCTION format_phone_number (@phone_number VARCHAR(15))
-- RETURNS VARCHAR(15)
-- AS
-- BEGIN
--     RETURN '(' + SUBSTRING(@phone_number, 1, 3) + ')' + SUBSTRING(@phone_number,4,3) + '-' + SUBSTRING(@phone_number,7,4)
-- END;


-- SELECT c.*, dbo.format_phone_number(c.phone_number) -- need to put dbo. prefix in front of function call, that way ADS does not give an error about the function not being built in to the already included library of functions
-- FROM su_customer AS c







-- CREATE a Table Value Function

-- CREATE FUNCTION active_rentals (@first_name VARCHAR(15), @last_name VARCHAR(30))
-- RETURNS TABLE
-- AS 
-- RETURN
-- (

--     SELECT c.first_name,
--     c.last_name,
--     dbo.format_phone_number(c.phone_number) AS phone,
--     r.start_date,
--     r.end_date,
--     u.unit_number
--     FROM su_customer c 
--     JOIN su_rental r ON c.customer_id = r.customer_id 
--     JOIN su_unit u ON r.unit_id = u.unit_id
--     WHERE c.first_name = @first_name AND c.last_name = @last_name AND u.status = 'occupied'
-- );


-- Execute function

-- SELECT * FROM dbo.active_rentals('John', 'Doe');









-- CREATE VIEW su_vw_rental_payments AS
-- SELECT c.first_name,
-- c.last_name,
-- c.email_address,
-- u.unit_number,
-- i.invoice_date,
-- p.payment_date,
-- i.amount AS invoice_amount,
-- p.amount AS payment_amount,
-- (i.amount - p.amount) AS difference 
-- FROM su_customer c 
-- JOIN su_rental r ON c.customer_id = r.customer_id
-- JOIN su_unit u ON r.unit_id = u.unit_id
-- JOIN su_invoice i ON r.rental_id = i.rental_id
-- JOIN su_payment p ON i.invoice_id = p.invoice_id


-- Test view

-- SELECT *
-- FROM su_vw_rental_payments
-- WHERE difference <> 0




CREATE TABLE su_customer_log

(

change_id INT IDENTITY(1,1) PRIMARY KEY,
customer_id INT,
change_type VARCHAR(15),
change_date DATETIME DEFAULT GETDATE(),
old_last_name VARCHAR(30),
new_last_name VARCHAR(30)
);

-- Create Trigger
-- Not only can you create a trigger to do something automatically once the condition is met, but you can also view the log of changes by selecting values from the created table we did above

-- CREATE TRIGGER log_customer_status
-- ON su_customer
-- AFTER UPDATE
-- AS 
-- BEGIN
--     INSERT INTO su_customer_log(customer_id, change_type, old_last_name, new_last_name) VALUES
--     (

--         (
--             SELECT i.customer_id
--             FROM inserted AS i
--         ),

--         'UPDATE',
        
--         (
--             SELECT d.last_name
--             FROM deleted AS d
--         ),

--         (
--             SELECT i.last_name
--             FROM inserted AS i
--         )

--     )
-- END;

-- Fire the trigger

-- UPDATE su_customer SET last_name = 'Watson'
-- WHERE customer_id = 40

-- Verify trigger

SELECT * FROM su_customer_log