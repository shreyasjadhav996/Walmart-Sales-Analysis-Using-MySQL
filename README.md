# Walmart-Sales-Analysis-Using-MySQL
## About
This project aims to explore the Walmart Sales data to understand top performing branches and products, sales trend of of different products, customer behaviour. The aims is to study how sales strategies can be improved and optimized. The dataset was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting)

"In this recruiting competition, job-seekers are provided with historical sales data for 45 Walmart stores located in different regions. Each store contains many departments, and participants must project the sales for each department in each store. To add to the challenge, selected holiday markdown events are included in the dataset. These markdowns are known to affect sales, but it is challenging to predict which departments are affected and the extent of the impact." 

Purposes Of The Project
The major aim of thie project is to gain insight into the sales data of Walmart to understand the different factors that affect sales of the different branches.

## About Data
The dataset was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting)
. This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:
| **Column**               | **Description**                              | **Data Type**          |
|--------------------------|----------------------------------------------|------------------------|
| `invoice_id`              | Invoice of the sales made                    | `VARCHAR(30)`          |
| `branch`                  | Branch at which sales were made              | `VARCHAR(5)`           |
| `city`                    | The location of the branch                   | `VARCHAR(30)`          |
| `customer_type`           | The type of the customer                     | `VARCHAR(30)`          |
| `gender`                  | Gender of the customer making purchase       | `VARCHAR(10)`          |
| `product_line`            | Product line of the product sold             | `VARCHAR(100)`         |
| `unit_price`              | The price of each product                    | `DECIMAL(10, 2)`       |
| `quantity`                | The amount of the product sold               | `INT`                  |
| `VAT`                     | The amount of tax on the purchase            | `FLOAT(6, 4)`          |
| `total`                   | The total cost of the purchase               | `DECIMAL(10, 2)`       |
| `date`                    | The date on which the purchase was made      | `DATE`                 |
| `time`                    | The time at which the purchase was made      | `TIMESTAMP`            |
| `payment_method`          | The total amount paid                        | `DECIMAL(10, 2)`       |
| `cogs`                    | Cost Of Goods Sold                           | `DECIMAL(10, 2)`       |
| `gross_margin_percentage`  | Gross margin percentage                      | `FLOAT(11, 9)`         |
| `gross_income`            | Gross Income                                 | `DECIMAL(10, 2)`       |
| `rating`                  | Customer rating of the service/product       | `FLOAT(2, 1)`          |

### Analysis List
1. Product Analysis:
   Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

2. Sales Analysis:
   This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modificatoins are needed to gain more sales.

3. Customer Analysis:
   This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment.

## Approach Used
### 1. Data Wrangling

#### Inspection of Data

The first step involves inspecting the dataset to ensure that NULL and missing values are detected. Data replacement methods are applied to handle these values. 

#### Build a Database

1. **Create Table and Insert Data**: A database is built to store the sales data. The relevant tables are created, and data is inserted accordingly.

2. **Check for NULL Values**: 
   - We select columns with NULL values. 
   - In our database, there are no NULL values as all fields are defined with `NOT NULL` constraints during table creation, ensuring that NULL values are filtered out.

### 2. Feature Engineering

Feature engineering is conducted to generate new columns from existing data, providing deeper insights:

1. **Add a New Column: `time_of_day`**  
   This column categorizes sales into **Morning**, **Afternoon**, and **Evening**. This feature helps answer the question: *At what time of day are most sales made?*

2. **Add a New Column: `day_name`**  
   This column extracts the day of the week (e.g., Mon, Tue, Wed, Thu, Fri) on which the transaction occurred. This feature will assist in determining which day of the week each branch is the busiest.

3. **Add a New Column: `month_name`**  
   This column extracts the month of the year (e.g., Jan, Feb, Mar) when the transaction took place. This feature helps determine which month has the highest sales and profits.

### 3. Exploratory Data Analysis (EDA)

Exploratory Data Analysis (EDA) is performed to answer the key questions and aims outlined in this project. This involves visualizing data, identifying trends, and deriving insights from the engineered features.

## Business Questions to answer: 

### Generic Questions
1. How many unique cities does the data have?
2. In which city is each branch?

### Product 
1. How many unique product lines does the data have?
2. What is the most common payment method?
3. What is the most selling product line?
4. What is the total revenue by month?
5. What month had the largest COGS?
6. What product line had the largest revenue?
7. What is the city with the largest revenue?
8. What product line had the largest VAT?
9. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
10. Which branch sold more products than average product sold?
11. What is the most common product line by gender?
12. What is the average rating of each product line?

### Sales

1. Number of sales made in each time of the day per weekday
2. Which of the customer types brings the most revenue?
3. Which city has the largest tax percent/ VAT (Value Added Tax)?
4. Which customer type pays the most in VAT?
   
### Customer
1. How many unique customer types does the data have?
2. How many unique payment methods does the data have?
3. What is the most common customer type?
4. Which customer type buys the most?
5. What is the gender of most of the customers?
6. What is the gender distribution per branch?
7. Which time of the day do customers give most ratings?
8. Which time of the day do customers give most ratings per branch?
9. Which day fo the week has the best avg ratings?
10. Which day of the week has the best average ratings per branch?
