import argparse
import mysql.connector
from tabulate import tabulate

connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="YOUR_PASSWORD",
    database="ecommerce_analytics"
)

cursor = connection.cursor()

reports = {
    "revenue": """
        SELECT customer_id,
        ROUND(SUM(quantity*unit_price),2)
        FROM orders
        JOIN order_items
        USING(order_id)
        GROUP BY customer_id
        ORDER BY 2 DESC
        LIMIT 10;
    """,

    "top_products": """
        SELECT product_id,
        SUM(quantity) quantity
        FROM order_items
        GROUP BY product_id
        ORDER BY quantity DESC
        LIMIT 10;
    """,

    "customers": """
        SELECT customer_id,
        COUNT(order_id)
        FROM orders
        GROUP BY customer_id
        ORDER BY 2 DESC
        LIMIT 10;
    """
}

parser = argparse.ArgumentParser()

parser.add_argument("--report", required=True)

args = parser.parse_args()

if args.report not in reports:
    print("Invalid report.")
    exit()

cursor.execute(reports[args.report])

rows = cursor.fetchall()

if rows:
    print(tabulate(rows, headers=[i[0] for i in cursor.description], tablefmt="grid"))
else:
    print("No records found.")

cursor.close()
connection.close()