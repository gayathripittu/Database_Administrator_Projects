USE AdventureWorks2017;

------------- Prioritize Selecting Specific Fields -------------
-- Unoptimized:
SELECT * 
FROM [Production].[Product];

-- optimized:
SELECT ProductID, Name, Color, ListPrice 
FROM [Production].[Product];


------------ Avoid WHERE Clause Functions ------------- 
-- Unoptimized:
SELECT * 
FROM [Person].[Person]
WHERE LOWER([FirstName]) = 'john'; 

-- optimized:
SELECT * 
FROM [Person].[Person]
WHERE [FirstName] = 'JOHN';  -- Case-sensitive comparison

------------ Explore Alternatives to SELECT DISTINCT -------------
-- Unoptimized:
SELECT DISTINCT [City]
FROM [Person].[Address];

-- optimized:
CREATE TABLE DistinctCities (City VARCHAR(50) PRIMARY KEY);

INSERT INTO DistinctCities (City)
SELECT DISTINCT City
FROM [Person].[Address];

SELECT * FROM DistinctCities;

DROP TABLE DistinctCities;

------------ Position Wildcards Strategically -------------
-- Unoptimized:
SELECT * 
FROM [Production].[Product]
WHERE [Name] LIKE '%Nut%';

-- optimized:
SELECT * 
FROM Production.Product 
WHERE [Name] LIKE '%Nut';

------------  Implement Pagination for Large Result Sets -------------
-- Unoptimized:
SELECT * 
FROM [Sales].[SalesOrderHeader];

-- optimized:
SELECT * 
FROM [Sales].[SalesOrderHeader]
ORDER BY [OrderDate] DESC
OFFSET 10 ROWS FETCH NEXT 20 ROWS ONLY;  

------------ Leverage Joins over Subqueries -------------
-- Unoptimized:
SELECT c.[CustomerID]
FROM [Sales].[Customer] c
WHERE CustomerID IN (
  SELECT [CustomerID]
  FROM [Sales].[SalesOrderHeader] 
  WHERE OrderDate > '2014-01-01'
);

-- optimized:
SELECT c.[CustomerID]
FROM [Sales].[Customer] c
INNER JOIN [Sales].[SalesOrderHeader] oh 
ON c.[CustomerID] = oh.[CustomerID]
WHERE oh.OrderDate > '2014-01-01';


------------ Utilize Indexes for Efficient Filtering and Joins -------------
-- Unoptimized:
SELECT * 
FROM Production.Product 
WHERE Color = 'red';

-- optimized:
CREATE INDEX IX_Product_Color ON Production.Product(Color);

SELECT * 
FROM Production.Product 
WHERE Color = 'red';

------------ Employ Stored Procedures for Reusability and Maintainability -------------
-- Unoptimized:

SELECT * 
FROM Sales.SalesOrderDetail sod
INNER JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE sod.SpecialOfferID IS NOT NULL;


-- optimized:

CREATE PROCEDURE GetDiscountedProducts
AS
BEGIN
  SELECT * 
  FROM Sales.SalesOrderDetail sod
  INNER JOIN Production.Product p ON sod.ProductID = p.ProductID
  WHERE sod.SpecialOfferID IS NOT NULL;
END;

Exec GetDiscountedProducts;

------------ Avoid Multiple OR Conditions in the WHERE Clause -------------
-- Unoptimized:

SELECT *
FROM [Person].[Person]
WHERE LastName = 'Richard' OR LastName = 'Diaz';

-- optimized:
SELECT *
FROM [Person].[Person]
WHERE LastName = 'Richard'
UNION ALL
SELECT *
FROM [Person].[Person]
WHERE LastName = 'Diaz';


