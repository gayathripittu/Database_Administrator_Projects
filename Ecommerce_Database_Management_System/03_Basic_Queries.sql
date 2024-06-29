
-- Retrieve all orders placed by a specific customer:
select * from orders
where customer_id=1;

-- Get the total number of products in each category:
select category_id, count(*) As Number_of_Products
from Products
group by category_id;

-- List all products that are out of stock
select product_id, product_name
from Products
where stock = 0;

-- Find all orders that are pending
select * from Orders
where order_status='pending';

-- Get the total sales for each product
select P.product_id, P.product_name, sum(OI.quantity*OI.price) as total_sales 
from products P
join OrderItems OI on P.product_id = OI.product_id
GROUP BY P.product_id, P.product_name;

-- Retrieve all orders with customer details

select O.order_id,O.order_date,O.order_status,C.first_name, C.last_name,C.email
from Customers C
join Orders O ON C.customer_id=O.customer_id;

-- Retrieve all products along with their categories, including products that do not have a category
SELECT p.product_id, p.product_name, c.category_name
FROM Products p
LEFT JOIN Categories c ON p.category_id = c.category_id;

-- Retrieve all categories along with their products, including categories that do not have any products

SELECT c.category_id, c.category_name, p.product_name
FROM Categories c
RIGHT JOIN Products p ON c.category_id = p.category_id;

-- Retrieve all customers and their orders, including customers who have not placed any orders and orders without a customer

SELECT c.customer_id, c.first_name, c.last_name, o.order_id, o.order_date
FROM Customers c
FULL OUTER JOIN Orders o ON c.customer_id = o.customer_id;

-- Find the total quantity of each product sold

select p.product_id,p.product_name,sum(OI.quantity) as Number_of_Products_sold
From Products p
join OrderItems OI on P.product_id = OI.product_id
GROUP BY p.product_id,p.product_name;

-- Retrieve the inventory details of each product in all locations:




select * from customers;
select * from Orders;
select * from products;
select * from OrderItems;

USE RETAIL_DB;

Execute GetProductsByCategory 1;



