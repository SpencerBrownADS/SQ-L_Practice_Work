
-- Basic Transaction

BEGIN TRANSACTION;
    INSERT INTO gs_categories VALUES ('Trumpet')
    COMMIT;

    SELECT * 
    FROM gs_categories



-- Inserting a new row into a table w/ corresponding values (first we insert the PK of the categories table)
-- The subquery receives the highest value in the categories table as the category_id; Since creating a new category will always automatically
-- create a new value due to how the database is set up, the MAX function should always grab the new category_id create by the first INSERT statement
-- (the category IDs start at 1 and increase)

BEGIN TRANSACTION;
    INSERT INTO gs_categories VALUES ('Saxophone');
    INSERT INTO gs_products VALUES ((
        SELECT MAX(category_id)
        FROM gs_categories
    ),
    'Better',
    'Alto Saxophone',
    'One of our favourite brands here at SAX, the Conn-Selmer saxophoens feature good design and excellent build quality',
    955,
    8,
    GETDATE());
    COMMIT;

    SELECT *
    FROM gs_products



BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE gs_products SET list_price = 999, discount_percent = 5
        WHERE product_name = 'Alto Saxophone';
        INSERT INTO gs_products VALUES ((
            SELECT category_id 
            FROM gs_categories 
            WHERE category_name = 'Trumpet'
        ),
        'Yamaha',
        'YTR-8310ZII Bobby Shew Trumpet',
        'The YTR-310ZII Bobby Shew Custom Series Bb Trumpet is a revolutionary professional instrument designed in collaboration with renowned jazz trumpeter Bobby Shew. This second generation model delivers a brilliant, robust tone and phenmomenal power with a solid tonal core suited for jazz ensembles.',
        2199,
        6,
        GETDATE());
    END TRY

    BEGIN CATCH
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        ROLLBACK;
    END CATCH;




    BEGIN TRANSACTION;
        BEGIN TRY 

            
            DELETE 
            FROM gs_products  
            WHERE product_id = (

                SELECT product_id
                FROM gs_products AS p 
                JOIN gs_categories AS c ON p.category_id = c.category_id
                WHERE c.category_name = 'Trumpet'
            );

            DELETE 
            FROM gs_products 
            WHERE product_id = (

                SELECT product_id
                FROM gs_products AS p 
                JOIN gs_categories AS c ON p.category_id = c.category_id
                WHERE c.category_name = 'Saxophone'
            );

            DELETE 
            FROM gs_categories  
            WHERE category_name = 'Trumpet';

            DELETE 
            FROM gs_categories  
            WHERE category_name = 'Saxophone';

        END TRY

        BEGIN CATCH
            PRINT 'Error Message: ' + ERROR_MESSAGE();
            ROLLBACK;
        END CATCH;



-- If you know what columns corresponds to the primary key, use this lil formula to see what the next value
-- should be for the PK if you are trying to insert another row.



-- *Subquery for the PK*

-- SELECT MAX(product_id) + 1 
-- FROM gs_products



-- INSERT INTO gs_products VALUES ((

    -- Put the subquery in here 

-- ),

-- )