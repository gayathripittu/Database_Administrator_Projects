USE RETAIL_DB;
-- Stored Procedures--

-- 1) GetProductsByCategory(category_id)--

CREATE PROCEDURE GetProductsByCategory(
@category_id int
)
As
BEGIN
SELECT p.product_id, p.product_name, p.product_description, 
	   p.brand, p.sku, p.price, c.category_name
FROM Products p 
Inner join Categories c 
ON p.category_id = c.category_id
WHERE c.category_id = @category_id;
END
GO

Execute GetProductsByCategory 5;

Execute GetProductsByCategory @category_id=5;

Drop PROCEDURE GetProductsByCategory;

---------------------------- 2) UpdateCustomerDetails -------------------
CREATE PROCEDURE UpdateCustomerDetails (
@customer_id INT, 
@new_email VARCHAR(50), 
@new_phone_number VARCHAR(10)
)
AS
BEGIN
UPDATE Customers 
SET email=@new_email, phone_number=@new_phone_number
WHERE customer_id=@customer_id;
END
GO

EXEC UpdateCustomerDetails 2,'jane.smith123@example.com','567-5979';

-------------------------------3) GenerateSalesReport --------------------------
DROP PROCEDURE GenerateSalesReport;

CREATE PROCEDURE GenerateSalesReport (
@start_date date,
@end_date date
)
AS
BEGIN
-- Declare table variables
DECLARE @TopSellingProducts TABLE (
  product_name nvarchar(50),
  total_revenue DECIMAL(10,2)
);

DECLARE @CategoryRevenue TABLE (
  category_name nvarchar(50),
  category_revenue DECIMAL(10,2)
);

-- Total Sales
DECLARE @total_sales DECIMAL(10,2);
SELECT @total_sales = SUM(oi.price * oi.quantity)
FROM Orders o
INNER JOIN OrderItems oi ON o.order_id = oi.order_id
WHERE o.order_date BETWEEN @start_date AND @end_date;

-- Top Selling Products
INSERT INTO @TopSellingProducts
SELECT TOP 5 p.product_name, SUM(oi.price * oi.quantity) AS total_revenue
FROM Orders o
INNER JOIN OrderItems oi ON o.order_id = oi.order_id
INNER JOIN Products p ON oi.product_id = p.product_id
WHERE o.order_date BETWEEN @start_date AND @end_date
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Revenue by Category
INSERT INTO @CategoryRevenue
SELECT c.category_name, SUM(oi.price * oi.quantity) AS category_revenue
FROM Orders o
INNER JOIN OrderItems oi ON o.order_id = oi.order_id
INNER JOIN Products p ON oi.product_id = p.product_id
INNER JOIN Categories c ON p.category_id = c.category_id 
WHERE o.order_date BETWEEN @start_date AND @end_date
GROUP BY c.category_name
ORDER BY category_revenue DESC;

-- Print the results (modify as needed for your reporting)
SELECT 'Total Sales:', @total_sales;
--PRINT N'';
SELECT 'Top 5 Selling Products:';
SELECT * FROM @TopSellingProducts;
--PRINT N'';
SELECT 'Revenue by Category:';
SELECT * FROM @CategoryRevenue;
END
GO

EXEC GenerateSalesReport '2024-06-13','2024-06-18';


--------------------------------- VIEWS ---------------------------------

--------------------- 1)AvailableProducts ---------------------

CREATE VIEW AvailableProducts AS

SELECT 
	p.product_id, p.product_name, 
	p.product_description, c.category_name, i.stock
FROM Products p
INNER JOIN Categories c ON p.category_id = c.category_id
INNER JOIN Inventory i ON p.product_id = i.product_id
WHERE i.stock > 0;

SELECT * FROM AvailableProducts;  -- View all available products

--------------------- 2) CustomerOrdersByStatus ---------------------

CREATE VIEW CustomerOrdersByStatus AS
SELECT 
	C.customer_id, O.order_id,C.first_name,
	C.email, O.order_date, O.order_status,
	OI.price, OI.product_id, P.product_name,
	P.product_description
from Customers C
INNER JOIN Orders O ON C.customer_id= O.customer_id
INNER JOIN OrderItems OI ON OI.order_id = O.order_id
INNER JOIN Products P ON P.product_id= OI.product_id;

SELECT * FROM CustomerOrdersByStatus ---> filter data in a view to get orders with a specific status
WHERE order_status='PENDING';

--------------------- 3) OrderDetails ---------------------
--- This view can show detailed information about each order, including ordered products, quantities, and prices ---
CREATE VIEW OrderDetails AS
SELECT o.order_id, c.email, p.product_name, 
	   oi.quantity, oi.price
FROM Orders o                                                            
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN OrderItems oi ON o.order_id = oi.order_id
INNER JOIN Products p ON oi.product_id = p.product_id;

SELECT * FROM OrderDetails;


