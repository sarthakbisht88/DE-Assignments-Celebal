DROP DATABASE IF EXISTS ecommerce_analytics;
CREATE DATABASE ecommerce_analytics;

USE ecommerce_analytics;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(100),
    state VARCHAR(100),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10,2),
    stock INT CHECK(stock>=0)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(30),
    FOREIGN KEY(customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT CHECK(quantity>0),
    unit_price DECIMAL(10,2),
    FOREIGN KEY(order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY(product_id)
        REFERENCES products(product_id)
);