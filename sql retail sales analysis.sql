                           #SQL RETAIL SALES ANALYSIS
		#INTRODUCTION: The retails sales analysis was done using SQL {STRUCTURED QUERY LANGUAGE} to optain meaningful insights.The motive of this project was to get a clean and structured data using sql to enhance more of my skills to understand in depth knowledge about the sql tool.Retail businesses generate large volumes of data daily, including information about products, customers, sales dates and quantity. Analyzing this data helps organizations understand customer purchasing behavior, seasonal trends, product performance, and overall business growth.
		#OBJECTIVE:
        -- 1.To import and structure retail sales data into a relational database.
		-- 2.To perform data cleaning and handle missing or null values.
         -- 3.To analyze monthly and yearly sales performance.
         -- 4.To identify best-selling products and top-performing months.
         -- 5.To generate actionable insights that can help improve sales strategy and business performance.

        #RETAIL SALES ANALYSIS PROJECT
CREATE DATABASE Retail_analysis
-- SELECT * FROM retail_analysis.sales_analyis-
-- order by transactions_id asc limit 100;
-- select count(*)
#from retail_analysis.sales_analyis;
#select * from retail_analysis.sales_analyis
#where transactions_id is NULL;
-- data cleaning

select * 
from retail_analysis.sales_analyis
where 
transactions_id is NULL
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or 
category is null
or
quantiy is null
or
 price_per_unit is null 
 or 
 cogs is null
or 
total_sale is null;

-- Data Exploration
-- how many sales?
select count(*) as total_sales from retail_analysis.sales_analyis;
-- how many  unique customers?
select count(distinct(customer_id)) as total_sales from retail_analysis.sales_analyis;
select distinct category from retail_analysis.sales_analyis;
-- DATA ANALYSIS
#1.write a query to retrive all columns for sales made on 09-10-2023
select * from retail_analysis.sales_analyis
where sale_date = '09-10-2023' ;

#2. write a query to retrive all transactions where the category is 'electronics' and the quantity sold is more than 4 in month of oct 2023
select * from retail_analysis.sales_analyis
where category = 'Electronics'
     and quantiy > 1
      and sale_date = '01-10-2023';
      
	#3. write a query to calcuate the total sales for each category?
    select 
    category,
    sum(total_sale) as net_sale
from retail_analysis.sales_analyis
    group by (category);
    
    #4.write a query to find the average age of the customers who purchased items from the 'clothing' category?
     select 
	   avg(age)
	from  retail_analysis.sales_analyis
	where category = 'Clothing';
    
        #5.write a query where to find all transactions where total sales is greater than 500?
        select * from retail_analysis.sales_analyis
        where total_sale > 500;
        
        #6.write a query to find the total number transactions made by each gender in each category?
        select 
               category,
               gender,
               count(*) as total_transactions
     from retail_analysis.sales_analyis
    group 
          by 
           category,
           gender;
           
          #7.write a query to calculate the average sale for each month and find out the best selling month in each year?
          SELECT year, month, total_sales
 FROM (
        SELECT 
        YEAR(STR_TO_DATE(sale_date, '%d-%m-%Y')) AS year,
         MONTH(STR_TO_DATE(sale_date, '%d-%m-%Y')) AS month,
         SUM(total_sale) AS total_sales,
         RANK() OVER (
             PARTITION BY YEAR(STR_TO_DATE(sale_date, '%d-%m-%Y'))
             ORDER BY SUM(sale_date) DESC
         ) AS rnk
   FROM retail_analysis.sales_analyis
     GROUP BY year, month
 ) ranked
 WHERE rnk = 1;
 
#8. write a query to find out the top 5 customers based on the highest total sales?
 select
	 customer_id,
      sum(total_sale) as total_sales
      from retail_analysis.sales_analyis
      group by 1
      order by 2 desc
      limit 5;
      
     #9.write a query to find the number of unique customers who purchased items from each category?
     SELECT 
            category,
            count(distinct(customer_id))
	FROM retail_analysis.sales_analyis
     group by (category);
     
     
    #10.write a query to create each shift number of orders (example morning<=12 and afternoon between 12 and 17, evening>17?
      with hourly 
      as
      (
      select * ,
             extract(hour from sale_time) <12 as 'morning',
             extract(hour from sale_time) between 12 and 17 as 'afternoon',
             extract(hour from sale_time) >17 as 'evening'
			FROM retail_analysis.sales_analyis
	)
			select
            
                   morning,
                   afternoon,
                   evening,
                   count(*) as total_order
                   from hourly
                   group 
                         by
                         morning,
                         afternoon,
                         evening;
                
                
              -- END OF PROJECT----  
                
                
    
