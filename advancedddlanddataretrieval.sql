-- Create tables for example

CREATE TABLE re_ingredients (

    ingredient_id INT IDENTITY (1, 1) PRIMARY KEY,
    ingredient_desc VARCHAR(50) NOT NULL,
    calories DECIMAL(6, 2) DEFAULT 0
)

CREATE TABLE re_menu_item (

    menu_item_id INT IDENTITY (1,1) PRIMARY KEY,
    menu_item_desc VARCHAR(60) NOT NULL,
    price DECIMAL(4, 2) NOT NULL CHECK(price > 0),
    

)


CREATE TABLE re_recipe (

    recipe_id INT IDENTITY(1, 1) PRIMARY KEY,
    ingredient_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT fk_rec_ing_id_ref_ing_ing_id FOREIGN KEY (ingredient_id) REFERENCES re_ingredients (ingredient_id),
    CONSTRAINT fk_rec_men_id_ref_men_men_id FOREIGN KEY (menu_item_id) REFERENCES re_menu_item (menu_item_id)
)













-- Assign index for menu item description
CREATE NONCLUSTERED INDEX IDX_menu_item_menu_item_desc ON re_menu_item(menu_item_desc)

-- Add data to ingredients (ID is generated automatically because of the identity marker)
INSERT INTO re_ingredients VALUES 
('Bun', 140.00),
('Beef Patty', 200.00),
('Cheese', 50.00),
('Chicken Patty', 150.00),
('Buffalo Sauce', 20.00);


-- Add data to menu
INSERT INTO re_menu_item VALUES 
('Cheeseburger', 2.99),
('Hamburger', 1.75),
('Chicken Sandwich', 2.99),
('Buffalo Chicken Sandwich', 3.19);

-- Add data to recipe
INSERT INTO re_recipe VALUES
(1, 1, 1),
(2, 1, 1),
(3, 1, 1),
(1, 2, 1),
(2, 2, 1),
(1, 3, 1),
(4, 3, 1),
(1, 4, 1),
(4, 4, 1),
(5, 4, 1);


-- Set Operators


-- Basic Query 
SELECT m.menu_item_desc, m.price
FROM re_menu_item AS m 
JOIN re_recipe AS r ON m.menu_item_id = r.menu_item_id
JOIN re_ingredients i ON r.ingredient_id = i.ingredient_id
WHERE i.ingredient_desc = 'Chicken Patty'


SELECT m.menu_item_desc, m.price
FROM re_menu_item AS m 
JOIN re_recipe AS r ON m.menu_item_id = r.menu_item_id
JOIN re_ingredients i ON r.ingredient_id = i.ingredient_id
WHERE i.ingredient_desc = 'Cheese'





-- Queries with Set Operators

SELECT m.menu_item_desc, m.price
FROM re_menu_item AS m 
JOIN re_recipe AS r ON m.menu_item_id = r.menu_item_id
JOIN re_ingredients i ON r.ingredient_id = i.ingredient_id
WHERE i.ingredient_desc = 'Chicken Patty'

UNION --EXCEPT INTERSECT 

SELECT m.menu_item_desc, m.price
FROM re_menu_item AS m 
JOIN re_recipe AS r ON m.menu_item_id = r.menu_item_id
JOIN re_ingredients i ON r.ingredient_id = i.ingredient_id
WHERE i.ingredient_desc = 'Cheese'




-- Window Functions

-- Will return the total calories, next to the individual calories of each individual ingredient for a menu item

SELECT m.menu_item_desc, i.ingredient_desc, i.calories,
SUM(i.calories) OVER (PARTITION BY m.menu_item_desc) AS total_calories
FROM re_menu_item AS m 
JOIN re_recipe AS r ON m.menu_item_id = r.menu_item_id
JOIN re_ingredients i ON r.ingredient_id = i.ingredient_id


-- Subquery Example

SELECT sub.menu_item_desc, sub.ingredient_desc, sub.calories, sub.total_calories, sub.calories/sub.total_calories
FROM (

    SELECT m.menu_item_desc, i.ingredient_desc, i.calories,
    SUM(i.calories) OVER (PARTITION BY m.menu_item_desc) AS total_calories
    FROM re_menu_item AS m 
    JOIN re_recipe AS r ON m.menu_item_id = r.menu_item_id
    JOIN re_ingredients i ON r.ingredient_id = i.ingredient_id
) AS sub



DROP TABLE re_ingredients

