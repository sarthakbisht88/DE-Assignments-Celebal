-- Objective: Analyze sales data using SQL with filtering, aggregation, and business queries. Steps: 
-- 1.Load dataset into a SQL database. 
-- 2.Explore table (schema, sample data). 
-- 3.Apply WHERE filters (region, category, date, sales). 
-- 4.Use GROUP BY for aggregations (sales, quantity, averages). 
-- 5.Sort and limit results (top products, top categories). 
-- 6.Solve use cases (monthly trends, top customers, duplicates). 
-- 7.Validate results (row counts, data quality). Output: SQL script / Notebook + query results + brief insights.


-- Step-1 Loading the kaggle dataset in our database...

create database if not exists superstore_db;
use superstore_db;




-- Step-2 Exploring the table...

describe superstore_table;
select * from superstore_table;
select * from superstore_table limit 25;

select distinct category from superstore_table;
select distinct city from superstore_table;
select distinct state from superstore_table;

select 
count(*) as total_rows, 
count(distinct `Order ID`) as unique_orders,
count(distinct `Customer Name`) as unique_users
from superstore_table;

select 
sum(case when Sales is null then 1 else 0 end) as no_sales,
sum(case when Profit is null then 1 else 0 end) as no_profit,
sum(case when Quantity is null then 1 else 0 end) as no_quantity
from superstore_table;

select
min(`Order Date`) as first_order,
max(`Order Date`) as last_order
from superstore_table;



-- Step-3 Applying WHERE filters (region, category, date, sales-according to Objective)...

select * from superstore_table where region='Central';
select * from superstore_table where region='West';

select * from superstore_table where Category='Furniture';
select * from superstore_table where Category='Office Supplies';

select * from superstore_table
where `Order Date` between '01-01-2017' AND '31-12-2017';
select * from superstore_table
where `Order Date` between '01-01-2016' AND '31-12-2016';

select * from superstore_table where Sales>500;
select * from superstore_table where Sales<500;
select * from superstore_table where profit>100;




-- Step-4 Using GROUP BY for aggregations (sales, quantity, averages-according to Objective)...

SELECT Category,sum(Sales) as total_sales, sum(Quantity) as total_quantity, avg(Profit) as avg_profit
from superstore_table
group by Category;




-- Step-5 Sorting and limiting results (top products, top categories-according to the Objective)...

select `Product Name`, Sum(Sales) as top_sales
from superstore_table
group by `Product Name`
order by top_sales DESC limit 15;

select `Product Name`, Sum(Sales) as bottom_sales
from superstore_table
group by `Product Name`
order by bottom_sales limit 15;

select `Product Name`, Sum(Profit) as most_profitable
from superstore_table
group by `Product Name`
order by most_profitable DESC limit 15;

select `Product Name`, Sum(Profit) as least_profitable
from superstore_table
group by `Product Name`
order by least_profitable limit 15;

select State, sum(Sales) as top_state
from superstore_table
group by `State`
order by top_state DESC limit 15;

select Category, sum(Sales) as top_category
from superstore_table
group by `Category`
order by top_category DESC;




-- Solving use cases (monthly trends, top customers, duplicates-according to Objective)...

select
    year(STR_TO_DATE(`Order Date`, '%d/%m/%Y')) as year,
    month(STR_TO_DATE(`Order Date`, '%d/%m/%Y')) as month,
    sum(Sales) as total_sales
from superstore_table
group by year, month
order by year, month;

select `Customer Name`, sum(Sales) as total_sales
from superstore_table
group by `Customer Name`
order by total_sales DESC
limit 10;

select `Customer Name`, sum(Profit) as total_profit
from superstore_table
group by `Customer Name`
order by total_profit DESC
limit 10;

select `Order ID`, count(*) as duplicate
from superstore_table
group by `Order ID`
having count(*) > 1
order by duplicate DESC;




-- Step-7 Validating results (row counts, data quality) and getting Output notebook/script...

select count(*) as total_rows from superstore_table;

select count(*) as invalid_date
from superstore_table where
STR_TO_DATE(`Ship Date`, '%d/%m/%Y') < STR_TO_DATE(`Order Date`, '%d/%m/%Y');

select min(Profit) as min_profit, max(Profit) as max_profit 
from superstore_table;

select min(Discount) as min_discount, max(Discount) as max_discount 
from superstore_table;



-- Step-7 Validation checks were performed to ensure data quality and consistency. 
-- Row counts and distinct order counts were verified, and no missing values were found in key columns such as Profit, Discount etc. 
-- Date validation confirmed that no shipment was recorded before its corresponding order date. 
-- Profit and discount ranges were also reviewed to identify any unusual values and ensure the dataset was suitable for analysis.
