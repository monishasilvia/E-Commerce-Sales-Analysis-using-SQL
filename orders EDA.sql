select * from orders;

-- 1.Basic Data Exploration
-- Find the total number of orders.
select count(*) from orders;

-- Count distinct customers who placed orders.
Select distinct(customer_id) from orders;

-- Identify the different product categories available.
select distinct category from orders;

-- 2.Sales Performance Analysis
-- Calculate total revenue generated.
select sum(total_amount) from orders;
select round(sum(total_amount),2) from orders;

-- Find the top 5 best-selling products (by quantity).
SELECT product_id, category, SUM(quantity) AS total_quantity_sold
fROM orders
group by product_id, category
order BY total_quantity_sold DESC
LIMIT 5;
#using cte
with top_5_products as (select product_id,
 category,sum(quantity) as total_quantity_sold
from orders
group by category,product_id
order by total_quantity_sold desc
limit 5)
select * from top_5_products;

-- Find the top 3 countries with the highest number of orders.
SELECT country, COUNT(order_id) AS total_orders
FROM orders
GROUP BY country
ORDER BY total_orders DESC
LIMIT 3;

-- 3.Customer Behavior
-- Find the customer who has placed the highest number of orders.
select customer_id , count(order_id) as total_orders from orders 
group by customer_id 
order by total_orders desc
limit 1;

-- Calculate the average order value per customer.
select avg(total_amount) as amount,customer_id from orders
group by customer_id
order by amount desc;

-- using JOINS
SELECT c.customer_id, c.customer_name, AVG(o.total_amount) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY avg_order_value DESC;

-- Find the most preferred payment method.
select payment_method ,count(payment_method) as preferred_mode from orders 
group by payment_method
order by count(payment_method) desc 
limit 1;

-- 4.Order Status & Cancellation Trends
-- Count the number of canceled and returned orders.
SELECT status, COUNT(order_id) AS total_orders
FROM orders
WHERE status IN ('Canceled', 'Returned')
GROUP BY status;

-- Find the percentage of delivered orders.
SELECT 
    (SUM(CASE WHEN status = 'Delivered' 
    THEN 1 
    ELSE 0 
    END) * 100.0 / COUNT(order_id)) AS delivered_percentage
FROM orders;

-- Identify which category has the highest return rate.
select category ,count(status) as total_count from orders where status = "Returned"
group by category
order by total_count desc
limit 1;

-- Time-Based Analysis
-- Find the month with the highest sales revenue.

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       SUM(total_amount) AS total_revenue
FROM orders
GROUP BY month
ORDER BY total_revenue DESC
LIMIT 1;

-- Calculate the number of orders placed each day of the week.
SELECT DAYNAME(order_date) AS day_of_week, 
       COUNT(order_id) AS total_orders
FROM orders
GROUP BY day_of_week
ORDER BY FIELD(day_of_week, 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');

-- Identify trends in order cancellations over time.

SELECT DATE(order_date) AS order_day, 
       COUNT(order_id) AS canceled_orders
FROM orders
WHERE status = 'Canceled'
GROUP BY order_day
ORDER BY order_day;















 

