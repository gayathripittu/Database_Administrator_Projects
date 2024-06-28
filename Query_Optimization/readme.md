### Query Optimization

This project focuses on optimizing SQL queries using the AdventureWorks sample database provided by Microsoft Learn. The project aims to identify slow-running queries and refine them for improved efficiency. This involves analyzing execution plans, applying optimization techniques, and comparing query execution times before and after optimization.

## Table of Contents

[This is the link text](#heading-title)
  
- [Prioritize Selecting Specific Fields](#prioritize-selecting-specific-fields)
- [Avoid WHERE Clause Functions](#avoid-where-clause-functions)
- [Explore Alternatives to SELECT DISTINCT](#explore-alternatives-to-select-distinct)
- [Position Wildcards Strategically](#position-wildcards-strategically)
- [Implement Pagination for Large Result Sets](#implement-pagination-for-large-result-sets)
- [Leverage Joins over Subqueries](#leverage-joins-over-subqueries)
- [Utilize Indexes for Efficient Filtering and Joins](#utilize-indexes-for-efficient-filtering-and-joins)
- [Employ Stored Procedures for Reusability and Maintainability](#employ-stored-procedures-for-reusability-and-maintainability)
- [Avoid Multiple OR Conditions in the WHERE Clause](#avoid-multiple-or-conditions-in-the-where-clause)


### Prioritize Selecting Specific Fields

#### Unoptimized <br>
```sql
SELECT * FROM Production.Product;
```
The unoptimized query retrieves all columns **`(*)`**, which can be inefficient especially if many columns are wide or unnecessary for the query's purpose. This approach may lead to increased memory and network usage. <br>

#### optimized:<br>
```sql
SELECT ProductID, Name, Color, ListPrice 
FROM [Production].[Product];
```
The optimized query selects only the necessary columns (**ProductID**, **Name**, **Color**, **ListPrice**), reducing the amount of data fetched and improving query performance by minimizing I/O operations.
<a name="prioritize-selecting-specific-fields"></a>

# Heading Title

### 2. Avoid WHERE Clause Functions

#### Unoptimized <br>
```sql
SELECT * 
FROM [Person].[Person]
WHERE LOWER([FirstName]) = 'john'; 
```

Using functions like `LOWER()` in the **`WHERE`** clause can prevent the use of indexes, leading to full table scans and reduced performance, especially on large datasets.<br>
#### optimized:<br>

```sql
SELECT * 
FROM [Person].[Person]
WHERE [FirstName] = 'JOHN';  -- Case-sensitive comparison
```
The optimized query avoids the function in the **`WHERE`** clause, ensuring that any existing index on **`[FirstName]`** can be used efficiently for filtering, improving query performance.

<a name="avoid-where-clause-functions"></a>

### 3. Explore Alternatives to SELECT DISTINCT
#### Unoptimized <br>
```sql
SELECT DISTINCT [City]
FROM [Person].[Address];
```

**`SELECT DISTINCT`** can be resource-intensive, especially on large datasets, as it requires sorting and deduplication. <br>
#### optimized:<br>

```sql
CREATE TABLE DistinctCities (City VARCHAR(50) PRIMARY KEY);

INSERT INTO DistinctCities (City)
SELECT DISTINCT City
FROM [Person].[Address];

SELECT * FROM DistinctCities;

DROP TABLE DistinctCities;

```
The optimized approach creates a temporary table (**DistinctCities**) to store unique cities, reducing the overhead of repeated **`DISTINCT`** operations and potentially improving query performance for subsequent queries.
<a name="explore-alternatives-to-select-distinct"></a>

### 4. Position Wildcards Strategically
#### Unoptimized <br>
```sql
SELECT * 
FROM [Production].[Product]
WHERE [Name] LIKE '%Nut%';
```

Placing a wildcard **`(%)`** at the beginning of a **`LIKE`** pattern can prevent index usage, leading to slower query performance.<br>
#### optimized:<br>

```sql
SELECT * 
FROM Production.Product 
WHERE [Name] LIKE '%Nut';
```
By placing the wildcard at the end of the **`LIKE`** pattern, SQL Server can potentially use indexes more effectively, improving query performance.

<a name="position-wildcards-strategically"></a>

### 5. Implement Pagination for Large Result Sets
#### Unoptimized <br>
```sql
SELECT * 
FROM [Sales].[SalesOrderHeader];
```
Fetching large result sets without pagination can lead to excessive memory usage and longer query execution times. <br>

#### optimized:<br>

```sql
SELECT * 
FROM [Sales].[SalesOrderHeader]
ORDER BY [OrderDate] DESC
OFFSET 10 ROWS FETCH NEXT 20 ROWS ONLY;
```
Implementing pagination with **`OFFSET`** and **`FETCH NEXT`** clauses ensures that only a subset of rows is retrieved at a time, reducing resource consumption and improving query performance, especially for user interfaces.

<a name="implement-pagination-for-large-result-sets"></a>

### 6. Leverage Joins over Subqueries
#### Unoptimized <br>
```sql
SELECT c.[CustomerID]
FROM [Sales].[Customer] c
WHERE CustomerID IN (
  SELECT [CustomerID]
  FROM [Sales].[SalesOrderHeader] 
  WHERE OrderDate > '2014-01-01'
);

```
Subqueries can sometimes be less efficient than joins, especially when correlated or used with large datasets. <br>
#### optimized:<br>

```sql
SELECT c.[CustomerID]
FROM [Sales].[Customer] c
INNER JOIN [Sales].[SalesOrderHeader] oh 
ON c.[CustomerID] = oh.[CustomerID]
WHERE oh.OrderDate > '2014-01-01';
```
Using **`INNER JOIN`** allows SQL Server to process the join operation more efficiently compared to a subquery, potentially improving query performance.
<a name="leverage-joins-over-subqueries"></a>

### 7.Utilize Indexes for Efficient Filtering and Joins
Strategies for using indexes to improve performance in filtering and join operations#### Unoptimized <br>
```sql
SELECT * 
FROM Production.Product 
WHERE Color = 'red';
```

Without an index on the **`Color1`** column, SQL Server may perform a table scan to find matching rows, which can be slow for large tables. <br>
#### optimized:<br>

```sql
CREATE INDEX IX_Product_Color ON Production.Product(Color);

SELECT * 
FROM Production.Product 
WHERE Color = 'red';
```
Creating an index on the **`Color1`** column allows SQL Server to quickly locate and retrieve rows that match the **`Color= 'red'`** condition, improving query performance significantly.
<a name="utilize-indexes-for-efficient-filtering-and-joins"></a>

### 8.Employ Stored Procedures for Reusability and Maintainability
#### Unoptimized <br>
```sql
SELECT * 
FROM Sales.SalesOrderDetail sod
INNER JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE sod.SpecialOfferID IS NOT NULL;
```

Executing ad-hoc queries repeatedly can lead to duplicated code and maintenance challenges. <br>
#### optimized:<br>

```sql
CREATE PROCEDURE GetDiscountedProducts
AS
BEGIN
  SELECT * 
  FROM Sales.SalesOrderDetail sod
  INNER JOIN Production.Product p ON sod.ProductID = p.ProductID
  WHERE sod.SpecialOfferID IS NOT NULL;
END;

Exec GetDiscountedProducts;
```
Using a stored procedure (**GetDiscountedProducts**) centralizes and optimizes query execution, promoting reusability and easier maintenance.
<a name="employ-stored-procedures-for-reusability-and-maintainability"></a>

### 9.Avoid Multiple OR Conditions in the WHERE Clause
#### Unoptimized <br>
```sql
SELECT *
FROM [Person].[Person]
WHERE LastName = 'Richard' OR LastName = 'Diaz';
```

 Multiple **`OR`** conditions can lead to inefficient query plans, especially when indexing is not effectively utilized. <br>
#### optimized:<br>

```sql
SELECT *
FROM [Person].[Person]
WHERE LastName = 'Richard'
UNION ALL
SELECT *
FROM [Person].[Person]
WHERE LastName = 'Diaz';
```
 Using **`UNION ALL`** separates the conditions into two separate queries, potentially allowing SQL Server to use indexes more effectively, improving query performance.
<a name="avoid-multiple-or-conditions-in-the-where-clause"></a>
   
