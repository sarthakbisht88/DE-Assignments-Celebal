USE ecommerce_analytics;

WITH customer_sales AS
(
SELECT
c.customer_id,
c.name,
SUM(quantity*unit_price) total_sales
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY c.customer_id,c.name
)

SELECT *,
RANK() OVER(ORDER BY total_sales DESC) customer_rank,
DENSE_RANK() OVER(ORDER BY total_sales DESC) dense_rank
FROM customer_sales;

SELECT
DATE_FORMAT(order_date,'%Y-%m') month,
SUM(quantity*unit_price) revenue,
SUM(SUM(quantity*unit_price))
OVER(ORDER BY DATE_FORMAT(order_date,'%Y-%m')) running_total
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY month;

SELECT
DATE_FORMAT(order_date,'%Y-%m') month,
SUM(quantity*unit_price) revenue,
AVG(SUM(quantity*unit_price))
OVER(
ORDER BY DATE_FORMAT(order_date,'%Y-%m')
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) moving_average
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY month;