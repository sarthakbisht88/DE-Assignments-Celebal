# Week-1 Data Engineering Assignment | Sarthak Bisht
# Open in Colab:[![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)]
(https://colab.research.google.com/drive/1AKegraB-Yk6_gOaZ7u8m5BP23gVm7lZ2)

## Note

The dataset is loaded using a GitHub raw file link instead of a local file path. This ensures that the notebook runs successfully in any environment (such as Google Colab) without requiring manual file uploads during evaluation.


## Objective

To perform basic data exploration and cleaning using Pandas on a shopping dataset.

## Dataset Selection

The Kaggle dataset provided multiple CSV files representing different product categories (e.g., backpacks, belts, bedsheets).

For this assignment, the **Combined_dataset.csv** file was selected because it consolidates all product categories into a single dataset.

### Reason for Choosing Combined Dataset

* It contains data from multiple categories in one place, making it suitable for comprehensive analysis.
* It allows performing all required operations (filtering, grouping, cleaning, transformation) without needing to merge multiple files.
* It is within the scope of Assignment-1 requirements.

## Steps Performed

* Loaded the dataset using Pandas
* Explored the dataset using head(), tail(), shape, columns, info(), and describe()
* Identified and handled missing values (df.isnull.sum() and df.isnull.sum().sum())
* Removed duplicate records (fill/drop--according to question's objective) (df.fillna and df.dropna)
* Filtered rows and selected columns (columns selected on basis of 'title', 'product_id', 'best_offer'etc) (filter for discount>50 and for rating_count>1000)
* Created a derived column (total_amount). According to question we need total_amount = price * quantity but in dataset provided there is no column name as 'price' and 'quantity', I look up for other files and didn't find exact column name as 'Quantity' and 'Price' so for demonstration I derive a column with another name.
* Saved the cleaned dataset as a new CSV file

## Tools Used

* Python
* Pandas
* Jupyter Notebook

## Output

* Cleaned dataset saved as cleaned_shopping_data.csv
* Jupyter Notebook containing all steps and analysis
