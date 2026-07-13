USE ecommerce_analytics;

WITH first_purchase AS
(
SELECT
customer_id,
MIN(order_date) first_purchase
FROM orders
GROUP BY customer_id
)

SELECT
DATE_FORMAT(first_purchase,'%Y-%m') cohort_month,
COUNT(customer_id) customers
FROM first_purchase
GROUP BY cohort_month
ORDER BY cohort_month;

SELECT
customer_id,
COUNT(order_id) total_orders,
CASE
WHEN COUNT(order_id)=1 THEN 'One-Time'
WHEN COUNT(order_id)<=5 THEN 'Occasional'
ELSE 'Loyal'
END customer_segment
FROM orders
GROUP BY customer_id;

SELECT
c.customer_id,
SUM(quantity*unit_price) monetary,
COUNT(DISTINCT o.order_id) frequency,
MAX(order_date) last_purchase
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY c.customer_id;