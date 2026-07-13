import pandas as pd
import mysql.connector
import os

connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="YOUR_PASSWORD",
    database="ecommerce_analytics"
)
cursor = connection.cursor()
DATA_PATH = "../data/cleaned"
customers = pd.read_csv(os.path.join(DATA_PATH, "customers_clean.csv"))
products = pd.read_csv(os.path.join(DATA_PATH, "products_clean.csv"))
orders = pd.read_csv(os.path.join(DATA_PATH, "orders_clean.csv"))
order_items = pd.read_csv(os.path.join(DATA_PATH, "order_items_clean.csv"))

for _, row in customers.iterrows():
    cursor.execute("""
        INSERT INTO customers
        VALUES(%s,%s,%s,%s,%s,%s)
    """,
    tuple(row))
connection.commit()

for _, row in products.iterrows():
    cursor.execute("""
        INSERT INTO products
        VALUES(%s,%s,%s,%s,%s)
    """,
    tuple(row))
connection.commit()

for _, row in order_items.iterrows():
    cursor.execute("""
        INSERT INTO order_items
        VALUES(%s,%s,%s,%s,%s)
    """,
    tuple(row))
connection.commit()
cursor.close()
connection.close()
print("Data Loaded Successfully.")

