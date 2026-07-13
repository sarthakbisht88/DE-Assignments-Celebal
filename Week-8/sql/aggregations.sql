USE ecommerce_analytics;

SELECT
    c.customer_id,
    c.name,
    ROUND(SUM(oi.quantity * oi.unit_price),2) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN order_items oi ON o.order_id=oi.order_id
GROUP BY c.customer_id,c.name
ORDER BY total_revenue DESC;

SELECT
    p.category,
    ROUND(SUM(oi.quantity*oi.unit_price),2) AS revenue
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY p.category
ORDER BY revenue DESC;

SELECT
    DATE_FORMAT(order_date,'%Y-%m') AS month,
    ROUND(SUM(quantity*unit_price),2) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY month
ORDER BY month;

SELECT
    p.product_name,
    SUM(oi.quantity) quantity_sold,
    ROUND(SUM(oi.quantity*oi.unit_price),2) revenue
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 10;

SELECT
    c.customer_id,
    c.name,
    ROUND(AVG(order_total),2) average_order_value
FROM customers c
JOIN (
    SELECT
        o.order_id,
        o.customer_id,
        SUM(quantity*unit_price) order_total
    FROM orders o
    JOIN order_items oi
    ON o.order_id=oi.order_id
    GROUP BY o.order_id,o.customer_id
)t
ON c.customer_id=t.customer_id
GROUP BY c.customer_id,c.name
ORDER BY average_order_value DESC;