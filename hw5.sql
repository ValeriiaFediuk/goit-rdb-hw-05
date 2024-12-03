- Task 1 

USE mydb;

SELECT od.*, 
       (SELECT o.customer_id 
        FROM orders o 
        WHERE o.id = od.order_id) AS customer_id

FROM order_details od;

- Task 2

SELECT *
FROM order_details od
WHERE od.order_id IN (
	SELECT o.id 
    FROM orders o 
    WHERE o.shipper_id = 3
);

- Task 3

SELECT temp_table.order_id, 
AVG(temp_table.quantity) AS avg_quantity
FROM
    (SELECT order_id, quantity 
     FROM order_details 
     WHERE quantity > 10) AS temp_table
GROUP BY temp_table.order_id;

- Task 4

WITH temp_table AS
    (SELECT order_id, quantity 
     FROM order_details 
     WHERE quantity > 10) 
SELECT 
    order_id,
    AVG(quantity) AS avg_quantity
FROM temp_table
GROUP BY order_id;

-Task 5

DROP FUNCTION IF EXISTS divide_number;

DELIMITER //

CREATE FUNCTION divide_number(
    first_number FLOAT,
    second_number FLOAT) 
RETURNS FLOAT
DETERMINISTIC
NO SQL
BEGIN
    IF second_number = 0 THEN
        RETURN NULL;
    END IF;
    RETURN first_number / second_number;
END //

DELIMITER ;

SELECT 
    order_id,
    quantity,
    divide_number(quantity, 3.0) AS divided_quantity
FROM 
    order_details;