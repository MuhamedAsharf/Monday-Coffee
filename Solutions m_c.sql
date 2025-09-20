------------------------- Monday Coffee Analyzing Problems -------------------------  

select * from city;
select * from products;
select * from sales;
select * from customers;



--Q.1 Coffee Consumers Count
-- How many people in each city are estimated to consume coffee, given that 25% of the population does?

select 
	city_name ,
	round((population * 0.25),2)/100000 Consumers_in_millions,
	rank()over(order by population desc) rank_city
from city


-- Q.2
-- Total Revenue from Coffee Sales
select 
	SUM(total) Total_Revenue -->Over Revenue
from sales 


--Total Revenue from Coffee Sales IN 2023
select 
	SUM(total) Total_Revenue_2023 -->IN 2023
from sales 
where year(sale_date) = 2023 
         
	      ------------------
--Total Revenue from Coffee Sales In 2023 Qtr 4

select 
	SUM(total) Total_Revenue  --In 2023 Qtr 4
from sales
where  year(sale_date) = 2023 and  datepart(quarter, sale_date) = 4;



 --What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?
select 
	c.city_id,ci.city_name,sum(s.total) total_revenue
from sales s
	inner join customers c on s.customer_id =c.city_id

	inner join city ci ON c.city_id = ci.city_id
where  
	year(sale_date) = 2023 and  datepart(quarter, sale_date) = 4
group by ci.city_name,c.city_id
order by total_revenue desc;



-- Q.3 Sales Count for Each Product
-- How many units of each coffee product have been sold?
select 
    (p.product_name),
	sum(total) Total_sales,
	count(s.sale_id) total_units
from products p
left join sales s
on s.product_id = p.product_id
group by p.product_name 
order by total_units desc;



---- Q.4 Average Sales Amount per City
-- What is the average sales amount per customer in each city?

select
    ci.city_name,
	count( distinct c.customer_id) total_customers,
	avg(s.total) avg_sales_per_customers,
	sum(s.total) total_reveue
from sales s
join customers c on s.customer_id = c.customer_id
join city ci on c.city_id = ci.city_id
group by ci.city_name;




-- Q.5 City Population and Coffee Consumers (25%)
-- Provide a list of cities along with their populations and estimated coffee consumers.
-- return city_name, total current cx, estimated coffee consumers (25%)
select
   ci.city_name,
   ci.population * 0.25  coffee_consumers,
   count(DISTINCT c.customer_id) AS unique_customers
from customers c
join city ci on c.city_id = ci.city_id
join sales s on c.customer_id = s.customer_id
group by ci.city_name, ci.population;


-- Q6.Top Selling Products by City
-- What are the top 3 selling products in each city based on sales volume?
select
    city_name,
    product_name,
    total_orders
from
(
    select
        ci.city_name,
        p.product_name,
        count(s.sale_id) as total_orders,
        dense_rank() over(partition by ci.city_name order by count(s.sale_id) desc) as ranking
    from sales as s
    join products as p on s.product_id = p.product_id
    join customers as c on c.customer_id = s.customer_id
    join city as ci on ci.city_id = c.city_id
    group by
        ci.city_name,
        p.product_name
) as t
where ranking <= 3
order by city_name,ranking;




-- Q.7 Customer Segmentation by City
-- How many unique customers are there in each city who have purchased coffee products?

select 
	ci.city_name,
	count(distinct c.customer_id)  unique_cus
from city ci
LEFT JOIN
customers c on c.city_id = ci.city_id
JOIN sales as s on s.customer_id = c.customer_id
GROUP BY ci.city_name
order by unique_cus desc;




--Q8.Find each city and their average sale per customer and avg rent per customer
select
    ci.city_name,
	count( distinct c.customer_id) total_customers,
	avg(s.total) avg_sales_per_customers,
	avg(ci.estimated_rent) avg_rent_per_customer
from sales s
join customers c on s.customer_id = c.customer_id
join city ci on c.city_id = ci.city_id
group by ci.city_name;




-- Q9.Monthly Sales Growth
-- Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly)
-- by each city
with monthlysales as (
    select
        ci.city_name,
        year(s.sale_date) as sales_year,
        month(s.sale_date) as sales_month,
        sum(s.total) as monthly_total_sales
    from sales s
    join customers c on s.customer_id = c.customer_id
    join city ci on c.city_id = ci.city_id
    group by
        ci.city_name,
        year(s.sale_date),
        month(s.sale_date)
)
select
    ms.city_name,
    ms.sales_year,
    ms.sales_month,
    ms.monthly_total_sales,
    lag(ms.monthly_total_sales, 1, 0) over (partition by ms.city_name order by ms.sales_year, ms.sales_month) as previous_month_sales,
    case
        when lag(ms.monthly_total_sales, 1, 0) over (partition by ms.city_name order by ms.sales_year, ms.sales_month) = 0 then null
        else (ms.monthly_total_sales - lag(ms.monthly_total_sales, 1, 0) over (partition by ms.city_name order by ms.sales_year, ms.sales_month)) * 100.0 / lag(ms.monthly_total_sales, 1, 0) over (partition by ms.city_name order by ms.sales_year, ms.sales_month)
    end as percentage_growth_decline
from monthlysales ms
order by
    ms.city_name,
    ms.sales_year,
    ms.sales_month;




--Q.10 Market Potential Analysis
-- Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated coffee consumer
select top 3 -- للحصول على أعلى 3 مدن
    ci.city_name,
    sum(s.total) as total_sales,
    max(ci.estimated_rent) as total_rent, 
    count(distinct c.customer_id) as total_customers,
    count(distinct c.customer_id) as estimated_coffee_consumers
from sales s
join customers c on s.customer_id = c.customer_id
join city ci on c.city_id = ci.city_id
group by
    ci.city_name, ci.estimated_rent
order by
    total_sales desc;