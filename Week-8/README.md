# Week 8 - E-Commerce Analytics System

## Objective

Build an end-to-end e-commerce analytics system using Python, Pandas, and SQL. The project covers dataset generation, data cleaning, database design, SQL analytics, customer segmentation, cohort analysis, and a command-line reporting tool.

## Technologies Used

* Python
* Pandas
* Faker
* MySQL
* SQL
* Tabulate

## Project Structure

```text
Week-8/
│── data/
│   ├── raw/
│   └── cleaned/
│
├── scripts/
│   ├── generate_data.py
│   ├── clean_data.py
│   ├── load_database.py
│   └── report_cli.py
│
├── sql/
│   ├── schema.sql
│   ├── aggregations.sql
│   ├── window_functions.sql
│   └── cohort_analysis.sql
│
├── output/
│── README.md
└── requirements.txt
```

## Workflow

1. Generate realistic e-commerce datasets using Faker.
2. Introduce duplicates, missing values, invalid dates, and broken foreign keys.
3. Clean and validate the datasets using Pandas.
4. Load cleaned data into a MySQL database.
5. Perform business analytics using SQL joins, aggregations, CTEs, and window functions.
6. Analyze customer cohorts, retention, and segmentation.
7. Generate reports using a Python command-line interface.

## Features

* Realistic dataset generation
* Data cleaning and validation
* Referential integrity checks
* SQL joins and aggregations
* Window functions and CTEs
* Cohort and customer segmentation analysis
* CLI-based reporting
* Edge case handling

## Sample Reports

* Revenue by Customer
* Revenue by Category
* Monthly Revenue Trend
* Top Products
* Customer Ranking
* Cohort Analysis
* Customer Segmentation

## How to Run

Install dependencies:

```bash
pip install -r requirements.txt
```

Generate datasets:

```bash
python scripts/generate_data.py
```

Clean datasets:

```bash
python scripts/clean_data.py
```

Load data into MySQL:

```bash
python scripts/load_database.py
```

Generate reports:

```bash
python scripts/report_cli.py --report revenue

python scripts/report_cli.py --report top_products

python scripts/report_cli.py --report customers
```

## Outcome

This project demonstrates a complete analytics pipeline, starting from raw data generation to business reporting using Python and SQL. It showcases data preprocessing, database management, advanced SQL querying, customer analytics, and automated reporting in a structured workflow.
