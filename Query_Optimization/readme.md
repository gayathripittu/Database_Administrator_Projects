### Query Optimization

This project focuses on optimizing SQL queries using the AdventureWorks sample database provided by Microsoft Learn. The project aims to identify slow-running queries and refine them for improved efficiency. This involves analyzing execution plans, applying optimization techniques, and comparing query execution times before and after optimization.

## Table of Contents
- [Prioritize Selecting Specific Fields](#prioritize-selecting-specific-fields)
- [Avoid WHERE Clause Functions](#avoid-where-clause-functions)
- [Explore Alternatives to SELECT DISTINCT](#explore-alternatives-to-select-distinct)
- [Position Wildcards Strategically](#position-wildcards-strategically)
- [Implement Pagination for Large Result Sets](#implement-pagination-for-large-result-sets)
- [Leverage Joins over Subqueries](#leverage-joins-over-subqueries)
- [Utilize Indexes for Efficient Filtering and Joins](#utilize-indexes-for-efficient-filtering-and-joins)
- [Employ Stored Procedures for Reusability and Maintainability](#employ-stored-procedures-for-reusability-and-maintainability)
- [Avoid Multiple OR Conditions in the WHERE Clause](#avoid-multiple-or-conditions-in-the-where-clause)


### 1. Prioritize Selecting Specific Fields

#### Unoptimized <br>
```sql
SELECT * FROM Production.Product;
```
The unoptimized query retrieves all columns `(*)`, which can be inefficient especially if many columns are wide or unnecessary for the query's purpose. This approach may lead to increased memory and network usage. <br>

#### optimized:<br>
```sql
SELECT ProductID, Name, Color, ListPrice 
FROM [Production].[Product];
```
The optimized query selects only the necessary columns (**`ProductID'**, **Name**, **Color**, **ListPrice**), reducing the amount of data fetched and improving query performance by minimizing I/O operations.
<a name="prioritize-selecting-specific-fields"></a>

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
The optimized query avoids the function in the `WHERE` clause, ensuring that any existing index on `[FirstName]` can be used efficiently for filtering, improving query performance.

<a name="avoid-where-clause-functions"></a>

### 3. Explore Alternatives to SELECT DISTINCT
#### Unoptimized <br>
```sql
SELECT * FROM Production.Product;
```

`SELECT *` retrieves all columns, even unused ones. Specifying needed columns reduces data transfer and processing time. <br>
#### optimized:<br>

```sql

SELECT ProductID, Name, Color, ListPrice 
FROM [Production].[Product];
```

<a name="explore-alternatives-to-select-distinct"></a>

### 4. Position Wildcards Strategically
#### Unoptimized <br>
```sql
SELECT * FROM Production.Product;
```

`SELECT *` retrieves all columns, even unused ones. Specifying needed columns reduces data transfer and processing time. <br>
#### optimized:<br>

```sql

SELECT ProductID, Name, Color, ListPrice 
FROM [Production].[Product];
```
<a name="position-wildcards-strategically"></a>

### 5. Implement Pagination for Large Result Sets
#### Unoptimized <br>
```sql
SELECT * FROM Production.Product;
```

`SELECT *` retrieves all columns, even unused ones. Specifying needed columns reduces data transfer and processing time. <br>
#### optimized:<br>

```sql

SELECT ProductID, Name, Color, ListPrice 
FROM [Production].[Product];
```
<a name="implement-pagination-for-large-result-sets"></a>

### 6. Leverage Joins over Subqueries
#### Unoptimized <br>
```sql
SELECT * FROM Production.Product;
```

`SELECT *` retrieves all columns, even unused ones. Specifying needed columns reduces data transfer and processing time. <br>
#### optimized:<br>

```sql

SELECT ProductID, Name, Color, ListPrice 
FROM [Production].[Product];
```
<a name="leverage-joins-over-subqueries"></a>

### 7.Utilize Indexes for Efficient Filtering and Joins
Strategies for using indexes to improve performance in filtering and join operations#### Unoptimized <br>
```sql
SELECT * FROM Production.Product;
```

`SELECT *` retrieves all columns, even unused ones. Specifying needed columns reduces data transfer and processing time. <br>
#### optimized:<br>

```sql

SELECT ProductID, Name, Color, ListPrice 
FROM [Production].[Product];
```

<a name="utilize-indexes-for-efficient-filtering-and-joins"></a>

### 8.Employ Stored Procedures for Reusability and Maintainability
#### Unoptimized <br>
```sql
SELECT * FROM Production.Product;
```

`SELECT *` retrieves all columns, even unused ones. Specifying needed columns reduces data transfer and processing time. <br>
#### optimized:<br>

```sql

SELECT ProductID, Name, Color, ListPrice 
FROM [Production].[Product];
```

<a name="employ-stored-procedures-for-reusability-and-maintainability"></a>

### Avoid Multiple OR Conditions in the WHERE Clause
#### Unoptimized <br>
```sql

```

`SELECT *` retrieves all columns, even unused ones. Specifying needed columns reduces data transfer and processing time. <br>
#### optimized:<br>

```sql
SELECT ProductID, Name, Color, ListPrice 
FROM [Production].[Product];
```
<a name="avoid-multiple-or-conditions-in-the-where-clause"></a>
   
