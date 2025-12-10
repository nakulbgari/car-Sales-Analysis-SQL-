# Used Car Sales Data Analysis (SQL Project)
Overview

This project analyzes a large used car sales dataset (558k+ records) using PostgreSQL. The goal is to identify sales trends, pricing patterns, popular models, and state-wise insights through SQL queries.

PROJECT FILE
cars_analysis_sql.sql     -> All SQL queries
README.md                 -> Documentation
cleaned_dataset.csv       -> Cleaned data (optional)

Technologies Used

PostgreSQL

SQL Window Functions

CTEs

Aggregate Functions

Ranking Functions

Date Parsing

Data Cleaning

Data Cleaning Performed

Removed invalid rows

Fixed date formatting issues

Extracted sale_year, sale_month, sale_day

Normalized body, make, model fields

Handled missing/incorrect values

Key Insights
1. Sales by State

Identified the number of cars sold in each state.

2. Most Popular Makes and Models

Found the highest-selling make/model combinations.

3. Average Price by State

Calculated the average selling price for each state.

4. Sales Over Time

Analyzed trends by extracting year, month, and day from the saledate field.

5. Top 5 Models per Body Type

Used ranking functions (RANK OVER PARTITION) to identify the most sold models in each body category.

6. Cars Sold Above Model Average

Detected vehicles priced above the model's average using window functions.

SQL Techniques Used
-- Window function example
AVG(sellingprice) OVER (PARTITION BY make, model)

-- Ranking example
RANK() OVER (PARTITION BY body ORDER BY COUNT(*) DESC)

-- Date extraction example
substr(saledate, 12, 4)::int AS sale_year

How to Run

Load dataset into PostgreSQL

Create table using the provided SQL script

Import cleaned CSV

Execute queries from cars_analysis_sql.sql

Review outputs and insights

Dataset Source

Kaggle – Used Car Sales Dataset

Contributions

Contributions and suggestions are welcome. Feel free to open an issue or submit a pull request.

License

This project is open-source and free to use.

Author:- Nakul
Email:- ashubagri039@gmail.com
phone no. 9810865294
linkdin:- https://www.linkedin.com/in/nakul-bagri-a9b239285/
