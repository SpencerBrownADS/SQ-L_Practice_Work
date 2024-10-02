
-- CREATE table named dog

-- CREATE TABLE dog (

--     dog_id INT,
--     dog_name VARCHAR(20),
--     breed VARCHAR(30),
--     birthday DATETIME,
--     good_boy_girl BIT
-- );

SELECT *
FROM dog


-- ALTER a table, changing the breed column to have fewer characters allowed

ALTER TABLE dog 
ALTER COLUMN breed VARCHAR(20);


-- ALTER a table, ADDing a new column and corresponding value to the table

ALTER TABLE dog
ADD fixed BIT;



-- ALTER a table (with transaction + error handling) to ALTER and table and DROP a column from the dog table

BEGIN TRANSACTION;
    BEGIN TRY
    
        ALTER TABLE dog 
        DROP COLUMN good_boy_girl
        COMMIT;

    END TRY

    BEGIN CATCH

        PRINT 'Error Message: ' + ERROR_MESSAGE()
        ROLLBACK;

    END CATCH;



-- Completely remove a table with the DROP keyword

DROP TABLE dog




