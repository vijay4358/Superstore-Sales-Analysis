use superstore;
describe store;
show columns from store;

select * from store 
where Category = 'Furniture'
limit 5;

select round(sum(Sales),2) as total_sales from store;
select round(sum(Profit),2) as total_profit from store;
select count(distinct `Customer ID`) as total_customers from store;
select count(distinct `Order ID`) as total_orders from store;	
select count(distinct `Product ID`) as total_products from store;
select round(sum(`Sales`)/count(distinct `Order ID`),2) as avg_order_value from store;


select Category, round(sum(Sales),2) as 'Total_Sales'

from store;


with cte as (
select Category, round(sum(Sales),2) as Total_Sales, round(sum(Sales)*100/sum(sum(Sales)) over() ,2) as contro_pct
from store
group by Category
order by Total_Sales desc)
select * from cte;


select Category, sum(Profit) as Total_profit
from store
group by Category
order by Total_Profit desc;

with cte1 as 
(select `Sub-Category`, sum(Profit) as total_profit
from store
where Category = 'Furniture'
group by `Sub-Category`
order by total_profit desc
), 
cte2 as
(select `Sub-Category`, sum(Sales) as total_sales
from store
group by `Sub-Category`
order by total_sales desc
)
select * from cte1,cte2;


select  Discount, sum(Profit) as Total_Profit
from store
where Category = 'Furniture'
group by Discount
order by Discount;

select `Sub-Category`, Discount*100 as discount_pct, Profit 
from store
where `Sub-Category` = 'Tables' or `Sub-Category` = 'Bookcases';


select `Sub-Category`, sum(Profit) as Total_profit, avg(Discount)*100 as avg_discount
from store 
where Category = 'Furniture'
group by `Sub-Category`
order by Total_profit desc;

select Region, sum(Sales) as Total_Sales
from store
group by Region
order by Total_Sales ;

select Region, sum(Profit) as Total_Profit
from store
group by Region
order by Total_Profit ;

select Region, round(sum(Sales), 2) as Total_Sales, 
	   round(sum(Sales)*100 / sum(sum(Sales)) over(), 2) as Contribution_pct
from store
group by region
order by Contribution_pct ;

Select segment, sum(Sales) as total_sales
from  store 
group by segment
order by total_Sales desc;

Select segment, sum(Profit) as total_profit
from  store 
group by segment
order by total_profit desc;

select segment, 
	   round(Sum(Sales), 2) as total_sales,
       round(sum(Sales)*100 / sum(sum(Sales)) over() , 2) as contro_pct
from store 
group by segment
order by contro_pct desc;


SELECT
    year(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) as years,
    round(sum(Sales),2) as total_sales
FROM store
group by years
order by total_sales desc;




