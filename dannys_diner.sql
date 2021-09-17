CREATE SCHEMA dannys_diner;
SET search_path = dannys_diner;

CREATE TABLE sales 
	(customer_id VARCHAR(1), order_date DATE, product_id INTEGER);

INSERT INTO sales (customer_id, order_date, product_id)
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu 
	(product_id INTEGER, product_name VARCHAR(5), price INTEGER);

INSERT INTO menu
  (product_id, product_name, price)
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members 
	(customer_id VARCHAR(1), join_date DATE);

INSERT INTO members
  (customer_id, join_date)
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  
  select * from sales;
  
  
-- 1. What is the total amount each customer spent at the restaurant?
select s.customer_id, sum(m.price) from sales s
join menu m
on s.product_id = m.product_id
group by customer_id;



-- 2. How many days has each customer visited the restaurant?
select customer_id, count(order_date) times_visited from sales
group by customer_id;

-- 3. What was the first item from the menu purchased by each customer?


-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
select m.product_name, count(s.product_id) total_ordered from menu m
join sales s on s.product_id = m.product_id
group by s.product_id
order by total_ordered desc
limit 1;

-- 5. Which item was the most popular for each customer?
select mp.customer_id, max(mp.prod_count) as most_popular_item, mp.product_name
from (
	select s.customer_id, count(m.product_id) as prod_count, m.product_name 
	from sales s
	join menu m 
	on s.product_id = m.product_id
	group by m.product_name, s.customer_id) mp
group by mp.customer_id;

-- 6. Which item was purchased first by the customer after they became a member?
SELECT s.customer_id, m.product_name, s.order_date, me.join_date
FROM sales s
JOIN menu m
ON s.product_id = m.product_id
JOIN members me
ON s.customer_id =  me.customer_id
WHERE s.order_date >= me.join_date
group by s.customer_id
ORDER BY s.order_date asc;

-- 7. Which item was purchased just before the customer became a member?
-- 8. What is the total items and amount spent for each member before they became a member?
-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
