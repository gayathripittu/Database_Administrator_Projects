USE RETAIL_DB;

select * from Categories;
-- Insert into Categories
INSERT INTO Categories (category_name, category_description)
VALUES
('Clothes', 'Various kinds of clothing'),
('Electronics', 'Electronic gadgets and devices'),
('Books','Various genres of books'),
('Footwear', 'Different types of footwear'),
('Furniture', 'Furniture for home and office');

-- Insert into Products

SET IDENTITY_INSERT dbo.Products Off;

INSERT INTO Products (product_id,product_name, product_description, category_id, brand, sku, price, stock)
VALUES
(100,'T-Shirt', 'Cotton t-shirt', 1, 'Brand A', 'TSHIRT-001', 19.99, 150),
(101,'Jeans', 'Denim jeans', 1, 'Brand B', 'JEANS-002', 49.99, 100),
(200,'iPhone 14', 'Latest Apple iPhone', 2, 'Apple', 'IP14-2023', 999.99, 50),
(201,'Samsung Galaxy S21', 'Samsung flagship phone', 2, 'Samsung', 'SGS21-2023', 799.99, 100),
(300,'The Great Gatsby', 'Classic novel by F. Scott Fitzgerald', 3, 'Penguin Books', 'BOOK-001', 10.99, 200),
(400,'Sneakers', 'Running shoes', 4, 'Brand C', 'SNEAKERS-001', 69.99, 120),
(500,'Office Chair', 'Ergonomic office chair', 5, 'Brand D', 'CHAIR-001', 199.99, 80),
(501,'Dining Table', 'Wooden dining table', 5, 'Brand E', 'TABLE-002', 299.99, 50);

-- Insert into Customers
INSERT INTO Customers (email, first_name, last_name, shipping_address, billing_address, phone_number)
VALUES
('john.doe@example.com', 'John', 'Doe', '123 Main St, columbus, USA', '123 Main St, columbus, USA', '555-1234'),
('jane.smith@example.com', 'Jane', 'Smith', '456 Oak St, Detriot, USA', '456 Oak St, Detriot, USA', '555-5678'),
('alice.jones@example.com', 'Alice', 'Jones', '789 Pine St, Kent, USA', '789 Pine St, Kent, USA', '555-7890'),
('bob.brown@example.com', 'Bob', 'Brown', '101 Maple St, Bowling green, USA', '101 Maple St, Bowling green, USA', '555-1010'),
('carol.white@example.com', 'Carol', 'White', '202 Elm St, florida, USA', '202 Elm St, florida, USA', '555-2020'),
('Emily.carey@example.com','Emily','carey','308 Beach Rd, Miami, USA','308 Beach Rd, Miami, USA','419-3708'),
('rachel.nichols@example.com','nichols','rachel','987 Elm St, Chicago, USA','987 Elm St, Chicago, USA','555-9807');


-- Insert into Orders

SET IDENTITY_INSERT dbo.Orders off;

INSERT INTO Orders (order_id, customer_id, order_date, order_status, total_price, payment_method, shipping_address)
VALUES
(7,1, '2024-06-17', 'pending', 59.97, 'Credit Card', '123 Main St, columbus, USA'),
(5,2, '2024-06-16', 'shipped', 19.99, 'PayPal', '456 Oak St, Detriot, USA'),
(3,3, '2024-06-15', 'processing', 279.99, 'Credit Card', '789 Pine St, Kent, USA'),
(2,4, '2024-06-14', 'delivered', 1599.98, 'Credit Card', '101 Maple St, Bowling green, USA'),
(1,5, '2024-06-13', 'cancelled', 999.99, 'PayPal', '202 Elm St, florida, USA'),
(6,1, '2024-06-15', 'delivered', 54.95, 'Credit Card', '123 Main St, columbus, USA'),
(9,6, '2024-06-18', 'pending', 299.99, 'Cash on Delivery', '308 Beach Rd, Miami, USA'),
(8,7, '2024-06-17', 'shipped', 199.99, 'Debit Card', '987 Elm St, Chicago, USA'),
(4,5, '2024-06-15', 'pending', 99.98, 'Cash on Delivery', '202 Elm St, florida, USA');


-- Insert into Order Items
INSERT INTO OrderItems (order_id, product_id, quantity, price)
VALUES
(7, 100, 3, 59.97),
(5, 100, 1, 19.99),
(1, 200, 1, 999.99),
(2, 201, 2, 1599.98),
(6, 300, 5, 54.95),
(9, 501, 1, 299.99),
(3, 400, 4, 279.96),
(4, 101, 2, 99.98),
(8, 500, 1, 199.99);



-- Insert into Locations
INSERT INTO Locations (location_name, address)
VALUES
('Warehouse 1', '100 Industrial Rd, Warehouse District, Anytown, USA'),
('Store 1', '789 Retail St, Shopping Center, Anytown, USA');


-- Insert into Inventory
INSERT INTO Inventory (product_id, stock, location_id)
VALUES
-- Warehouse 1 (location_id 1) inventory
  (100, 150, 1),  -- T-Shirt (150 in Warehouse 1)
  (101, 100, 1),  -- Jeans (100 in Warehouse 1)
  (200,  50, 1),  -- iPhone 14 (50 in Warehouse 1)
  (201, 100, 1),  -- Samsung Galaxy S21 (100 in Warehouse 1)
  (300, 200, 1),  -- The Great Gatsby (200 in Warehouse 1)
  (400,  0, 1),  -- No initial stock for Sneakers in Warehouse 1
  (500,  0, 1),  -- No initial stock for Office Chair in Warehouse 1
  (501,  0, 1),  -- No initial stock for Dining Table in Warehouse 1)
  
  -- Store 1 (location_id 2) inventory (assuming returned items go to store)
  (100,   0, 2),  -- T-Shirt (returned from order 6) goes to Store 1
  (101,  0, 2),  -- No Jeans in Store 1
  (200,  0, 2),  -- No iPhone 14 in Store 1
  (201,  0, 2),  -- No Samsung Galaxy S21 in Store 1
  (300,  0, 2),  -- No The Great Gatsby in Store 1
  (400, 120, 2),  -- Sneakers (initial stock) in Store 1
  (500,  80, 2),  -- Office Chair (initial stock) in Store 1
  (501,  50, 2);  -- Dining Table (initial stock) in Store 1


