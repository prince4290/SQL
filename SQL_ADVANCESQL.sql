/* This assignment covers fundamental SQL concepts like Common Table Expressions (CTEs), Views, Stored Procedures, and Triggers. Below are the solutions for both the theoretical questions and the practical coding exercises based on the dataset provided.*/

---

## Part 1: Theory Questions

### Q1. What is a Common Table Expression (CTE)?

/*
Ans.  A CTE is a temporary result set that you can reference within a `SELECT`, `INSERT`, `UPDATE`, or `DELETE` statement. It exists only during the execution of that query.
* Readability: It improves readability by breaking down complex joins and subqueries into simple, modular "blocks" of code.
*/

### Q2. Updatable vs. Read-Only Views
/*
Ans. * Updatable Views: These allow you to perform `UPDATE` or `INSERT` operations on the underlying table. For a view to be updatable, it must have a 1-to-1 relationship with the table rows (no `GROUP BY`, `DISTINCT`, or complex joins).
* Read-Only Views: These contain aggregations or multiple joined tables.
* Example: A view like `SELECT * FROM Products` is updatable. A view like `SELECT Category, SUM(Price) FROM Products GROUP BY Category` is read-only because the database doesn't know which specific row to update when looking at a sum. 
*/

### Q3. Advantages of Stored Procedures
/*
Ans. 1. Code Reusability: Write once, call many times.
     2. Performance: They are compiled once and stored, reducing parsing time.
     3. Security: You can give users permission to execute a procedure without giving them direct access to the underlying tables.
*/

### Q4. Purpose of Triggers
/*
Ans. A trigger is a set of instructions that runs **automatically** in response to an event (like `INSERT` or `DELETE`).
* Use Case: Auditing.
If a row is deleted from a "Payments" table, a trigger can automatically move that record to an "Audit_Log" table to keep a history of who deleted what and when.
*/

### Q5. Need for Data Modelling and Normalization
/*
* Data Integrity: Ensures data is accurate and consistent.
* Redundancy Reduction: Normalization (splitting tables) prevents storing the same information multiple times, which saves space and prevents "update anomalies" (where you update a value in one place but forget it in another).
*/
---

## Part 2: SQL Coding Solutions

-- 1. Create the Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

-- 2. Insert Data into Products
INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 5500);

-- 3. Create the Sales Table
DROP TABLE IF EXISTS Sales ;
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 4. Insert Data into Sales
INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate) VALUES
(1, 1, 4, '2024-01-05'),
(2, 2, 10, '2024-01-06'),
(3, 3, 2, '2024-01-10'),
(4, 4, 1, '2024-01-11');

/* --- Q6: CTE for Total Revenue per Product --- */
WITH ProductRevenue AS (
    SELECT 
        p.ProductName, 
        (p.Price * s.Quantity) AS Revenue
    FROM Products p
    JOIN Sales s ON p.ProductID = s.ProductID
)
SELECT * FROM ProductRevenue 
WHERE Revenue > 3000;

/* --- Q7: Create a Summary View --- */
CREATE VIEW vw_CategorySummary AS
SELECT 
    Category, 
    COUNT(ProductID) AS TotalProducts, 
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;

/* --- Q8: Updatable View and Update Execution --- */
-- Create the view
CREATE VIEW vw_ProductUpdates AS
SELECT ProductID, ProductName, Price
FROM Products;

-- Perform the update using the view
UPDATE vw_ProductUpdates
SET Price = Price + 100 -- Example update logic
WHERE ProductID = 1;

/* --- Q9: Stored Procedure for Category Filter --- */
 DROP PROCEDURE IF EXISTS GetProductByCategory;
 DELIMITER //
CREATE PROCEDURE GetProductsByCategory(IN catName VARCHAR(50))
BEGIN
    SELECT * FROM Products 
    WHERE Category = catName;
END //
DELIMITER ;

/* --- Q10: AFTER DELETE Trigger for Archiving --- */
-- First, create the archive table structure
CREATE TABLE ProductArchive (
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    DeletedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the trigger
DELIMITER //
CREATE TRIGGER tr_AfterProductDelete
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO ProductArchive (ProductID, ProductName, Category, Price)
    VALUES (OLD.ProductID, OLD.ProductName, OLD.Category, OLD.Price);
END //
DELIMITER ;
