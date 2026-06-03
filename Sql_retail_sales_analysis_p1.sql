-- create database 

create database sql_project_2;

-- create table
use sql_project_2;

create table retail_sales
(transactions_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(15),
age int,
category varchar(15),
quantiy int,
price_per_unit float,
cogs float,
total_sale float
);

select * from retail_sales
limit 10;

select count(*)
from
retail_sales;

-- data cleaning


select * from retail_sales
where 
transactions_id is null
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

-- duplicate value check 
select transactions_id, count(*)
from retail_sales
group by transactions_id
having count(*) >1;


-- data exploration

-- How many sales we have?
select count(*) as total_sale
from retail_sales;

-- How many uniq customer?
select count(distinct customer_id) as uniq_customer
from retail_sales;

select distinct category from retail_sales;

-- Q.1 write the sql query to retrieve all columns for sales made on '2022-22-05'

select 
* from retail_sales
where sale_date = '2022-11-05' order by sale_time;

-- Q.2 Write a sql query to retrieve all the tansactions where the category os 'clothing' and the quantity sale is more
-- 10 the month of nov-2022

select * 
from retail_sales
where category ='Clothing'
and quantiy = 4 
and sale_date >= '2022-11-01'
and sale_date <= '2022-11-30';

-- Q.3 write the sql query to calculate the total sale(total_sale ) for each category.

select 
category,
sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by 1;

-- Q.4 write the sql query to find the average age of customer whose
-- purchase item beauty category


select 
round(avg(age),2) as avg_age
from retail_sales;

-- Q.5 write a query to find all transaction where the total_sales is greater than.

select * from retail_sales
where total_sale = 1000;



-- Q.6 write the query to find the total number of transactions(transactions_id) made by each gender
-- in each category

select 
category,
gender,
count(*) as total_sales
from retail_sales
group by 
category,
gender
order by 1;

-- Q.7 write a query to calculate the average sales for each month. Find the best selling month in each year.
select
year,
month,
avg_sale

from
(
select
extract(year  from sale_date) as year,
extract(month from sale_date)as month,
round(avg(total_sale),2) as avg_sale,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank_
from retail_sales
group by 1,2
) as t1
where rank_ = 1;
-- order by 1,2;

-- Q.8 Write the sql query to find the top 5 customers based on highest total_sale

select
 customer_id,
 sum(total_sale) as total_sale
 from retail_sales
 group by 1
 order by 2 desc
 limit 5;
 
 -- Q.9 Write the sql query to find the number of uniq customer who is purchased 
 -- item from each category
 select 
category,
count(distinct customer_id) as cnt_uniq_cs
from retail_sales
group by category;

-- Q.10 Write a sql query to create each shift and nummber of order
-- (moring =< 12 , afternoon between 12 & 17, evening > 17 )
with hourly_sale
as
(
select *,
case
when extract(hour from sale_time) < 12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon' 
else 'Evening'
end as shift
from retail_sales
)
select
shift,
count(*) as total_order
from hourly_sale
group by shift;




 