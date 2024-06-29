CREATE DATABASE Ecommerce_SalesDB;

USE Ecommerce_SalesDB;


---------------------- Customers table ----------------------

CREATE TABLE Customers (
  cust_id INT PRIMARY KEY,
  user_Name VARCHAR(255),
  first_Name VARCHAR(255),
  last_Name VARCHAR(255),
  gender VARCHAR(255),
  age INT,
  e_Mail VARCHAR(255),
  customer_Since DATE,
  SSN VARCHAR(255),
  phone_No VARCHAR(255),
  place_Name VARCHAR(255),
  county VARCHAR(255),
  city VARCHAR(255),
  state VARCHAR(255),
  zip VARCHAR(255),
  region VARCHAR(255)
);

---------------------- Orders table ----------------------

CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  order_date DATE,
  status VARCHAR(255),
  total DECIMAL(10,2),
  payment_method VARCHAR(255),
  bi_st VARCHAR(255),
  cust_id INT,  -- Foreign key to Customers table
  ref_num VARCHAR(255),
  FOREIGN KEY (cust_id) REFERENCES Customers(cust_id)  -- foreign key relationship
);

alter table Orders
drop column month,year;

---------------------- Order_Details table ----------------------

CREATE TABLE Order_Details (
  order_id INT,  -- Foreign key to Orders table
  item_id INT,
  sku VARCHAR(255),
  qty_ordered INT,
  price DECIMAL(10,2),
  value DECIMAL(10,2),
  discount_amount DECIMAL(10,2),
  Discount_Percent DECIMAL(5,2),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id)  -- foreign key relationship
);


---------------------- Products table ----------------------


CREATE TABLE Products (
  item_id INT PRIMARY KEY,
  sku VARCHAR(255),
  category VARCHAR(255),
  price DECIMAL(10,2)
);


select top 25 * from Customers;