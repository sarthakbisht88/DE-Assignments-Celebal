import pandas as pd
import os
RAW_PATH = "../data/raw"
CLEAN_PATH = "../data/cleaned"

os.makedirs(CLEAN_PATH, exist_ok=True)


customers = pd.read_csv(os.path.join(RAW_PATH, "customers.csv"))
products = pd.read_csv(os.path.join(RAW_PATH, "products.csv"))
orders = pd.read_csv(os.path.join(RAW_PATH, "orders.csv"))
order_items = pd.read_csv(os.path.join(RAW_PATH, "order_items.csv"))

print("Customers:", customers.shape)
print("Products:", products.shape)
print("Orders:", orders.shape)
print("Order Items:", order_items.shape)

print(customers.isnull().sum())
print(products.isnull().sum())
print(orders.isnull().sum())
print(order_items.isnull().sum())

print("Customers:", customers.duplicated().sum())
print("Products:", products.duplicated().sum())
print("Orders:", orders.duplicated().sum())
print("Order Items:", order_items.duplicated().sum())

customers = customers.drop_duplicates()
products = products.drop_duplicates()
orders = orders.drop_duplicates()
order_items = order_items.drop_duplicates()

customers["email"] = customers["email"].fillna("unknown@example.com")
products["price"] = products["price"].fillna(products["price"].median())
orders["status"] = orders["status"].fillna("Pending")

customers["signup_date"] = pd.to_datetime(customers["signup_date"])
orders["order_date"] = pd.to_datetime(orders["order_date"], errors="coerce")
today = pd.Timestamp.today()
orders.loc[orders["order_date"] > today, "order_date"] = today

valid_customers = set(customers["customer_id"])
orders = orders[orders["customer_id"].isin(valid_customers)]

valid_orders = set(orders["order_id"])
order_items = order_items[order_items["order_id"].isin(valid_orders)]

valid_products = set(products["product_id"])
order_items = order_items[order_items["product_id"].isin(valid_products)]

customers["customer_id"] = customers["customer_id"].astype(int)
products["product_id"] = products["product_id"].astype(int)
orders["order_id"] = orders["order_id"].astype(int)
orders["customer_id"] = orders["customer_id"].astype(int)
order_items["order_item_id"] = order_items["order_item_id"].astype(int)
order_items["order_id"] = order_items["order_id"].astype(int)
order_items["product_id"] = order_items["product_id"].astype(int)

customers.to_csv(
    os.path.join(CLEAN_PATH, "customers_clean.csv"),
    index=False
)
products.to_csv(
    os.path.join(CLEAN_PATH, "products_clean.csv"),
    index=False
)
orders.to_csv(
    os.path.join(CLEAN_PATH, "orders_clean.csv"),
    index=False
)
order_items.to_csv(
    os.path.join(CLEAN_PATH, "order_items_clean.csv"),
    index=False
)


print("Customers:", customers.shape)
print("Products:", products.shape)
print("Orders:", orders.shape)
print("Order Items:", order_items.shape)

print("cleaned datasets saved successfully.")