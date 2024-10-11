Create database sql_project_p1;

Use sql_project_p1;

drop table if exists retail_sales;
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(25),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
    
SELECT 
    *
FROM
    retail_sales
LIMIT 10;
    
-- Count --
SELECT 
    COUNT(*)
FROM
    retail_sales;

-- checking null values -- 

select * from retail_sales where transactions_id Is NULL ;
select * from retail_sales where sale_date Is NULL ;
select * from retail_sales where sale_time Is NULL ;
select * from retail_sales where customer_id Is NULL ;
select * from retail_sales where gender Is NULL ;
select * from retail_sales where age Is NULL ;
select * from retail_sales where category Is NULL ;
select * from retail_sales where quantiy Is NULL ;
select * from retail_sales where price_per_unit Is NULL ;
select * from retail_sales where cogs Is NULL ;
select * from retail_sales where total_sale Is NULL ;


-- Data Exploration --
SELECT 
    COUNT(*)
FROM
    retail_sales;

 -- 1 How many customer we have? -- 
 
SELECT 
    COUNT(DISTINCT customer_id)
FROM
    retail_sales;

SELECT DISTINCT
    category
FROM
    retail_sales;

-- Business Key Problem and Answer -- 
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
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17) --

SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';
    
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022 --

SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing' AND quantiy > 10;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category. --

SELECT 
    category, SUM(total_sale) AS total_sales
FROM
    retail_sales
GROUP BY category
;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category. --

SELECT 
    category, AVG(age) AS Avg_age
FROM
    retail_sales
WHERE
    category = 'Beauty';

-- -- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000. --

SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000;

 -- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category. --
 
SELECT 
    gender, category, COUNT(transactions_id) AS 'No_of_tran'
FROM
    retail_sales
GROUP BY category , gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select * from (
	select 
		year(sale_date) as year,
		month(sale_date)as month,
		avg(total_sale) as avg_sale,
		rank() over(partition by year(sale_date) order by avg(total_sale) desc) as 'Ranking'
		from retail_sales group by 1,2 
		order by 1,3 desc ) as t1
        where Ranking = 1;
        



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales --


SELECT 
    *
FROM
    retail_sales
ORDER BY total_sale DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    category, COUNT(DISTINCT customer_id) AS 'unique count'
FROM
    retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17) --

with hourly_sale
as (
select *,
	case	
		when hour(sale_time) < 12  then 'Morning'
        when hour(sale_time) between 12 and 17 then 'Afternoon'
	else
		'Evening'
    End as 'Shift'
	from retail_sales
    )
    select count(*) as 'total_orders' from hourly_sale group by shift 
    
    














 
