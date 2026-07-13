from faker import Faker
import pandas as pd
import random
import os
from datetime import timedelta

fake = Faker()
random.seed(42)
Faker.seed(42)

RAW_PATH = "../data/raw"

os.makedirs(RAW_PATH, exist_ok=True)

NUM_CUSTOMERS = 1000
NUM_PRODUCTS = 500
NUM_ORDERS = 5000
NUM_ORDER_ITEMS = 15000

customers = []
for i in range(1, NUM_CUSTOMERS + 1):
    customers.append({
        "customer_id": i,
        "name": fake.name(),
        "email": fake.unique.email(),
        "city": fake.city(),
        "state": fake.state(),
        "signup_date": fake.date_between(
            start_date="-3y",
            end_date="today"
        )
    })
customers = pd.DataFrame(customers)
customers.head()

products = []
categories = [
    "Electronics",
    "Clothing",
    "Home",
    "Books",
    "Sports",
    "Beauty",
    "Toys",
    "Groceries"
]
for i in range(1, NUM_PRODUCTS + 1):
    products.append({
        "product_id": i,
        "product_name": fake.word().capitalize() + " " + fake.word().capitalize(),
        "category": random.choice(categories),
        "price": round(random.uniform(10, 5000), 2),
        "stock": random.randint(0, 500)
    })
products = pd.DataFrame(products)
products.head()


orders = []
for i in range(1, NUM_ORDERS + 1):
    order_date = fake.date_between(
        start_date="-2y",
        end_date="today"
    )
    orders.append({
        "order_id": i,
        "customer_id": random.randint(1, NUM_CUSTOMERS),
        "order_date": order_date,
        "status": random.choice([
            "Pending",
            "Shipped",
            "Delivered",
            "Cancelled"
        ])
    })
orders = pd.DataFrame(orders)
orders.head()


order_items = []
for i in range(1, NUM_ORDER_ITEMS + 1):
    product_id = random.randint(1, NUM_PRODUCTS)
    quantity = random.randint(1, 5)
    price = float(
        products.loc[
            products["product_id"] == product_id,
            "price"
        ].iloc[0]
    )
    order_items.append({
        "order_item_id": i,
        "order_id": random.randint(1, NUM_ORDERS),
        "product_id": product_id,
        "quantity": quantity,
        "unit_price": price
    })
order_items = pd.DataFrame(order_items)
order_items.head()

print(customers.shape)
print(products.shape)
print(orders.shape)
print(order_items.shape)

customers = pd.concat(
    [customers, customers.sample(20, random_state=42)],
    ignore_index=True
)
print("Duplicate customer rows:", customers.duplicated().sum())

products = pd.concat(
    [products, products.sample(10, random_state=42)],
    ignore_index=True
)
print("Duplicate product rows:", products.duplicated().sum())

customers.loc[
    customers.sample(25, random_state=42).index,
    "email"
] = None

products.loc[
    products.sample(20, random_state=42).index,
    "price"
] = None

orders.loc[
    orders.sample(30, random_state=42).index,
    "status"
] = None


print(customers.isnull().sum())
print(products.isnull().sum())
print(orders.isnull().sum())
print(order_items.isnull().sum())

print(customers.duplicated().sum())
print(products.duplicated().sum())

customers.to_csv(
    os.path.join(RAW_PATH, "customers.csv"),
    index=False
)
products.to_csv(
    os.path.join(RAW_PATH, "products.csv"),
    index=False
)
orders.to_csv(
    os.path.join(RAW_PATH, "orders.csv"),
    index=False
)
order_items.to_csv(
    os.path.join(RAW_PATH, "order_items.csv"),
    index=False
)