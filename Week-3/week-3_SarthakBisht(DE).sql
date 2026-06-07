create database superstore_db;
use superstore_db;

show tables;

RENAME TABLE `superstore-raw`
TO superstore_raw;

SELECT *
FROM superstore_raw
LIMIT 5;

DESCRIBE superstore_raw;
-- Step-1
-- DROP TABLE customers;
-- DROP TABLE products;
-- DROP TABLE orders;

CREATE TABLE customers AS
SELECT DISTINCT
`Customer ID` AS customer_id,
`Customer Name` AS customer_name,
Segment AS segment
FROM superstore_raw;

select * from customers limit 5;

CREATE TABLE products AS
SELECT DISTINCT
`Product ID` AS product_id, Category, `Sub-Category` AS sub_category,
`Product Name` AS product_name
FROM superstore_raw;

select * from products limit 5;

CREATE TABLE orders AS
SELECT DISTINCT
`Order ID` AS order_id,
`Customer ID` AS customer_id,
`Order Date` AS order_date, Sales, Quantity, Discount, Profit
FROM superstore_raw;

select * from orders limit 5;


-- Step-2

-- 1
SELECT *
FROM orders
WHERE sales >
(
SELECT AVG(sales)
FROM orders
);

-- 2
SELECT
customer_id, order_id, sales
FROM orders o
WHERE sales =
(
    SELECT MAX(sales)
    FROM orders o2
    WHERE o.customer_id = o2.customer_id
);

-- 3
WITH customer_sales AS
(
SELECT customer_id, SUM(sales) AS total_sales
FROM orders
GROUP BY customer_id
)
SELECT *
FROM customer_sales
ORDER BY total_sales DESC;

-- 4
WITH customer_sales AS
(
SELECT customer_id, SUM(sales) AS total_sales
FROM orders
GROUP BY customer_id
)
SELECT *
FROM customer_sales
WHERE total_sales >
(
SELECT AVG(total_sales)
FROM customer_sales
);

-- 5
WITH customer_sales AS
(
SELECT customer_id, SUM(sales) AS total_sales
FROM orders
GROUP BY customer_id
)
SELECT
customer_id, total_sales,
RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM customer_sales;

-- 6
SELECT
customer_id, order_id, sales,
ROW_NUMBER() OVER
(
PARTITION BY customer_id
ORDER BY sales DESC
) AS row_num
FROM orders;

-- 7
WITH customer_sales AS
(
SELECT customer_id, SUM(sales) AS total_sales
FROM orders
GROUP BY customer_id
)
SELECT *
FROM
(
SELECT customer_id, total_sales,
RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM customer_sales
) ranked_customers
WHERE sales_rank <= 3;


-- Step-3 Final Combined Query

WITH customer_sales AS
(
SELECT
customer_id,
SUM(sales) AS total_sales
FROM orders
GROUP BY customer_id
)

SELECT
c.customer_name,
cs.total_sales,
RANK() OVER
(
ORDER BY cs.total_sales DESC
) AS customer_rank
FROM customers c
JOIN customer_sales cs
ON c.customer_id = cs.customer_id
ORDER BY customer_rank;


-- MINI PROJECT 
-- 1 Top - 5 Customers
WITH customer_sales AS
(
SELECT customer_id, SUM(sales) AS total_sales
FROM orders
GROUP BY customer_id
)
SELECT c.customer_name, cs.total_sales
FROM customer_sales cs
JOIN customers c
ON cs.customer_id = c.customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- 2 Bottom - 5 Customers
WITH customer_sales AS
(
SELECT customer_id, SUM(sales) AS total_sales
FROM orders
GROUP BY customer_id
)
SELECT c.customer_name, cs.total_sales
FROM customer_sales cs
JOIN customers c
ON cs.customer_id = c.customer_id
ORDER BY total_sales ASC
LIMIT 5;

-- 3 Customers who made only 1 order
SELECT
customer_id, COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id) = 1;

-- 4 Abover average salary
WITH customer_sales AS
(
SELECT
customer_id,
SUM(sales) AS total_sales
FROM orders
GROUP BY customer_id
)
SELECT *
FROM customer_sales
WHERE total_sales >
(
SELECT AVG(total_sales)
FROM customer_sales
);

-- 5 Highest order value per Customer
SELECT
customer_id, MAX(sales) AS highest_order_value
FROM orders
GROUP BY customer_id
ORDER BY highest_order_value DESC;