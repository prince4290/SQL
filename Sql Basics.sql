-- Q1. Create a New Database And Table for Employees: 
CREATE DATABASE company_db;

-- Use the newly created database
USE company_db;

-- Create the employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE
);

-- Q2. Insert Data into Employees Table
INSERT INTO employees (employee_id, first_name, last_name, department, salary, hire_date)
VALUES
(101, 'Amit', 'Sharma', 'HR', 50000, '2020-01-15'),
(102, 'Riya', 'Kapoor', 'Sales', 75000, '2019-03-22'),
(103, 'Raj', 'Mehta', 'IT', 90000, '2018-07-11'),
(104, 'Neha', 'Verma', 'IT', 85000, '2021-09-01'),
(105, 'Arjun', 'Singh', 'Finance', 60000, '2022-02-10');

-- Q3. Display All Employee Records Sorted by Salary (Lowest to Highest)
SELECT *
FROM employees
ORDER BY salary ASC;

-- Q4. Show Employees Sorted by Department (A-Z) and Salary (High -> Low)
SELECT *
FROM employees
ORDER BY department ASC, salary DESC;

-- Q5. List All Employees in the IT Department, Ordered by Hire Date (Newest First)
SELECT *
FROM employees
WHERE department = 'IT'
ORDER BY hire_date DESC;

-- Q6. Create and Populate a Sales Table
-- Create the sales table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    amount INT,
    sale_date DATE
);

-- Insert data into the sales table
INSERT INTO sales (sale_id, customer_name, amount, sale_date)
VALUES
(1, 'Aditi', 1500, '2024-08-01'),
(2, 'Rohan', 2200, '2024-08-03'),
(3, 'Aditi', 3500, '2024-09-05'),
(4, 'Meena', 2700, '2024-09-15'),
(5, 'Rohan', 4500, '2024-09-25');

-- Q7. Display All Sales Records Sorted by Amount (Highest -> Lowest)
SELECT *
FROM sales
ORDER BY amount DESC;

-- Q8. Show All Sales Made by Customer "Aditi"
SELECT *
FROM sales
WHERE customer_name = 'Aditi';

---  Q9. What is the Difference Between a Primary Key and a Foreign Key?
--  Ans.  
-- Primary Key:
-- • A primary key uniquely identifies each record in a table[cite: 61].
-- • It cannot be NULL[cite: 62].
-- • A table can have only one primary key[cite: 63].
--
-- Foreign Key:
-- • A foreign key links two tables together[cite: 65].
-- • It refers to the primary key of another table[cite: 66].
-- • It can have duplicate values[cite: 67].
-- • It can be NULL depending on constraints[cite: 68].

-- Q10. What Are Constraints in SQL and Why Are They Used?
-- Ans. 
-- What Are Constraints:
-- • Constraints are rules applied to columns or tables in SQL to control the type of data that can be stored[cite: 71].
-- • They ensure that the data in the database is accurate, valid, and reliable[cite: 72].
--
-- Constraints are used to:
-- • Prevent invalid data from being inserted[cite: 74].
-- • Maintain data integrity[cite: 75].
-- • Enforce business rules[cite: 76].
-- • Ensure relationships between tables remain correct[cite: 77].
