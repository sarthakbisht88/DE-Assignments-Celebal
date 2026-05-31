# DE-Assignments-Celebal | Sarthak Bisht

This repository contains weekly Data Engineering assignments completed as part of the learning and project-based practice workflow. Each week focuses on different tools, concepts, and datasets used in data analysis, data engineering, and related domains.

## Repository Structure

```text
Data-Engineering-Assignments/
│
├── Week-1-Pandas-Data-Exploration/
├── Week-2-SQL-Sales-Analysis/
├── Week-3/
├── Week-4/
└── ...
```


## Note

Some assignments load datasets using GitHub raw file links instead of local file paths. This ensures that notebooks can run successfully in environments such as Google Colab without requiring manual file uploads during evaluation. If the Jupyter file is not rendered by Github, try downloading it locally.

---

# Week 1 – Pandas Data Exploration and Data Cleaning

## Objective

Perform basic data exploration and cleaning using Pandas on a shopping dataset.

## Dataset Selection

The Kaggle dataset provided multiple CSV files representing different product categories.

The **Combined_dataset.csv** file was selected because it consolidates all product categories into a single dataset, making it suitable for comprehensive analysis.

## Steps Performed

* Loaded the dataset using Pandas
* Explored the dataset using head(), tail(), shape, columns, info(), and describe()
* Identified missing values
* Handled missing data using fillna() and dropna()
* Removed duplicate records
* Filtered rows and selected relevant columns
* Created a derived column for demonstration purposes
* Saved the cleaned dataset as a new CSV file

## Tools Used

* Python
* Pandas
* Jupyter Notebook

## Output

* Cleaned dataset saved as cleaned_shopping_data.csv
* Jupyter Notebook containing all analysis steps

---

# Week 2 – SQL Sales Data Analysis

## Objective

Analyze sales data using SQL with filtering, aggregation, sorting, business queries, and data validation techniques.

## Dataset

Superstore Sales Dataset

## Tasks Performed

### Data Exploration

* Examined table schema and sample records
* Identified unique categories, cities, and states
* Calculated row counts and unique orders

### Filtering and Analysis

* Applied filters using WHERE clauses
* Analyzed data by region, category, sales, profit, and date ranges

### Aggregations

* Used GROUP BY with SUM(), AVG(), and COUNT()
* Calculated category-wise sales, quantity, and profit metrics

### Ranking and Sorting

* Identified top and bottom products by sales
* Identified top and bottom products by profit
* Ranked states and categories by total sales

### Business Use Cases

* Monthly sales trend analysis
* Top customers by sales
* Top customers by profit
* Duplicate order analysis

### Data Validation

* Verified row counts
* Checked missing values
* Validated shipping dates against order dates
* Reviewed profit and discount ranges

## Tools Used

* MySQL
* MySQL Workbench
* SQL

## Output

* SQL analysis script
* Query results
* Business insights and validation checks

