USE RETAIL_DB;

EXECUTE sp_helpindex Customers;

------------------- Clustered Index ---------------------
--- Removing the existing primary key constraint named PK__Customer__CD65CB85FD7193C2 from the Customers table.

ALTER TABLE Customers
DROP CONSTRAINT PK__Customer__CD65CB85FD7193C2;

--- Creating new clustered index on email column of the Customers table.
CREATE CLUSTERED INDEX IX_tblCustomers_email
ON Customers(email ASC)

------------------- Nonclustered Index ---------------------

--- A non-clustered index on e_Mail column in the Customers table
CREATE NONCLUSTERED INDEX idx_customers_email ON [dbo].[Customers]([email]);


--- A non-clustered index on cust_id and order_date columns in the Orders table
CREATE NONCLUSTERED INDEX idx_orders_cust_id_order_date ON [dbo].[Orders]([customer_id], [order_date]);

--- Filtered Index on Categories Table
CREATE NONCLUSTERED INDEX idx_products_category_filtered ON [dbo].[Categories]([category_name]) WHERE [category_name]= 'Electronics';

--- Covering Index on Orders Table
CREATE NONCLUSTERED INDEX idx_orders_covering ON [dbo].[Orders]([customer_id], [order_date], [order_status]) INCLUDE ([total_price],[payment_method]);



