CREATE DATABASE salesDataWalmart;

USE salesDataWalmart;

CREATE TABLE sales
(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT (6,4) NOT NULL,
    total DECIMAL(12,4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    cogs DECIMAL (10,2) NOT NULL,
    gross_margin_pct FLOAT (11,9) NOT NULL,
    gross_income FLOAT (2,1) NOT NULL,
    rating FLOAT(2,1) 
);



-- -----------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------ FEATURE ENGINEERING --------------------------------------------------------------

-- TIME OF DAY 

SELECT time,
(CASE 
	WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
    WHEN time BETWEEN '12:01:00' AND '18:00:00' THEN 'Afternoon'
    ELSE 'Evening'
END) AS time_of_day
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

SET SQL_SAFE_UPDATES = 0;

UPDATE sales
SET time_of_day = (
	CASE 
		WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
		WHEN time BETWEEN '12:01:00' AND '18:00:00' THEN 'Afternoon'
		ELSE 'Evening'
	END
);

SET SQL_SAFE_UPDATES = 1;


-- DAY NAME

SELECT
	date,
    DAYNAME(date) 
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);


UPDATE sales
SET day_name = DAYNAME(date);


-- MONTH NAME

SELECT
	date,
    MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(50);

UPDATE sales
SET month_name = MONTHNAME(date);


-- -------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------GENERIC QUESTIONS ---------------------------------------------------------------

-- How many unique cities does the data have?

SELECT DISTINCT city FROM sales;

-- In which city is each branch?

SELECT DISTINCT city,branch FROM sales;


-- -------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------PRODUCT-------------------------------------------------------------------------

-- How many unique product lines does the data have?

SELECT COUNT(DISTINCT product_line) FROM sales;

-- What is the most common payment method?

SELECT payment_method,
 COUNT(payment_method) AS cnt
FROM sales
GROUP BY payment_method
ORDER BY cnt DESC;

-- What is the most selling product line?

SELECT product_line,
 COUNT(product_line) AS cnt
FROM sales
GROUP BY product_line
ORDER BY cnt DESC;

-- What is the total revenue by month?

SELECT 
	month_name AS month,
    SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- What month had the largest COGS?

SELECT 
	month_name AS month,
    SUM(cogs) AS cogs
FROM sales 
GROUP BY month_name
ORDER BY cogs DESC;

-- What product line had the largest revenue?

SELECT 
	product_line,
    SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?

SELECT 
	branch,
    city,
    SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch
ORDER BY total_revenue DESC;

-- What product line had the largest VAT?

SELECT 
	product_line,
    AVG(VAT) AS avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Which branch sold more products than average product sold?

SELECT 
	branch,
    SUM(quantity) AS qty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG (quantity) FROM sales);

-- What is the most common product line by gender?

SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line 
ORDER BY total_cnt DESC;

-- What is the average rating of each product line?

SELECT 
	AVG(rating) AS avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- -------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------SALES-------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday

SELECT 
    time_of_day,
    COUNT(*) AS total_sales
FROM sales
WHERE Day_Name = 'Monday'
GROUP BY time_of_day
ORDER BY total_sales DESC;


-- Which of the customer types brings the most revenue?

SELECT 
	customer_type,
    SUM(total) as total_rev
FROM sales
GROUP BY customer_type
ORDER BY total_rev DESC;
    
-- Which city has the largest tax percent/ VAT (Value Added Tax)?

SELECT 
	city,
    AVG(VAT) AS VAT
FROM sales
GROUP BY city
ORDER BY VAT DESC;
    
-- Which customer type pays the most in VAT?

SELECT 
	customer_type,
    AVG(VAT) AS VAT
FROM sales
GROUP BY customer_type
ORDER BY VAT DESC;
    
    
-- -------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------ CUSTOMER ---------------------------------------------------------------------

-- How many unique customer types does the data have?

SELECT COUNT(DISTINCT customer_type)
FROM sales;    
    

-- How many unique payment methods does the data have?

SELECT DISTINCT payment_method
FROM sales;
    
-- What is the most common customer type?

SELECT 
	customer_type,
    COUNT(*) AS total_customer
FROM sales
GROUP BY customer_type
ORDER BY total_customer DESC;
    
-- Which customer type buys the most?
SELECT 
    customer_type,
    COUNT(*) AS cust_cnt
FROM sales
GROUP BY customer_type
ORDER BY cust_cnt DESC;

-- What is the gender of most of the customers?

SELECT 
	gender,
    COUNT(*) AS gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per branch?

SELECT 
	gender,
    COUNT(*) AS gender_cnt
FROM sales
WHERE branch = "A"
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Which time of the day do customers give most ratings?

SELECT 
	time_of_day,
    AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;
    
-- Which time of the day do customers give most ratings per branch?

SELECT
		time_of_day,
        AVG(rating) as avg_rating
FROM sales
WHERE branch = "B"
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which day of the week has the best avg ratings?

SELECT 
	day_name,
    AVG(rating) as avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;
 
    
-- Which day of the week has the best average ratings per branch?    

SELECT 
	day_name,
    AVG(rating) as avg_rating
FROM sales
WHERE branch = "A"
GROUP BY day_name
ORDER BY avg_rating DESC;
    
