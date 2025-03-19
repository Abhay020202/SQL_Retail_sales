USE sql_project;
-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );
            
            SELECT * FROM retail_sales;
            SELECT COUNT(*) FROM retail_sales;
            
	-- Data Cleaning
        SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
    
    -- Data Exploration
    -- How many sales we have?
    SELECT COUNT(*) as total_sale From retail_sales;
    
    -- How many uniuque customers we have ?
    SELECT COUNT(DISTINCT Customer_id) as total_sale From retail_sales;
     
	-- How many Unique Category we have?
    SELECT DISTINCT category From retail_sales;
    
    
    
    -- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
 
 SELECT * FROM retail_sales
 WHERE sale_date= '2022-11-05';
 
 -- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
 
 SELECT * FROM retail_sales
 WHERE category='Clothing' AND  quantity >=4 AND FORMAT(sale_date,'YYYY-MM') = '2022-11' ;
 
 -- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
 
 SELECT category, SUM(total_sale) as Total_sales FROM retail_sales 
 group by category;
 
 -- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

 SELECT ROUND(AVG(age)) as avg_age
 FROM retail_sales
 WHERE category='Beauty';
 
 -- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
 
 SELECT * FROM retail_sales
 WHERE total_sale> 1000;
 
 -- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
 
 SELECT COUNT(transaction_id) , category, gender
 FROM retail_sales
 Group by gender, category;
 
 -- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
 
SELECT YEAR, MONTH, AVG_Sale
FROM(
 SELECT YEAR(sale_date) as YEAR , MONTH (sale_date) as MONTH , AVG(total_sale) as AVG_Sale,
 RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) as ranks 
 FROM retail_sales
 GROUP BY YEAR , MONTH ) as T1
 WHERE ranks =  1 ;
 
 -- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
 
 SELECT customer_id , SUM(total_sale) as total_sales
 FROM retail_sales
 GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT COUNT(DISTINCT customer_id)as no_of_customers, category
FROM retail_sales
GROUP BY category;
    
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)


SELECT shift,COUNT(*) as total_orders FROM 
(
SELECT *,
CASE 
WHEN HOUR (Sale_time) <12 THEN 'Morning'
WHEN HOUR (Sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
 ELSE 'Evening'
 END AS shift 
 FROM retail_sales)as Hourly_sale
 GROUP BY shift;
 
 


 
-- End of project





