-- Create the Employee Table
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    dept_id VARCHAR(3) NOT NULL,
    salary INT NOT NULL
);
-- Insert Data into the Employee Table
INSERT INTO employee (emp_id, name, dept_id, salary) VALUES
(101, 'Abhishek', 'D01', 62000),
(102, 'Shubham', 'D01', 58000),
(103, 'Priya', 'D02', 67000),
(104, 'Rahul', 'D02', 64000),
(105, 'Reha', 'D03', 92000),
(106, 'Arman', 'D03', 55000),
(107, 'Ravi', 'D04', 60000),
(108, 'Sneha', 'D04', 75000),
(109, 'Kiran', 'D05', 70000),
(110, 'Tanuja', 'D05', 65000);

-- Create the Department Table
CREATE TABLE department (
    dept_id VARCHAR(3) PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL
);

-- Insert Data into the Department Table
INSERT INTO department (dept_id, department_name, location) VALUES
('D01', 'Sales', 'Mumbai'),
('D02', 'Marketing', 'Delhi'),
('D03', 'Finance', 'Pune'),
('D04', 'HR', 'Bengaluru'),
('D05', 'IT', 'Hyderabad');

-- Create the Sales Table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    emp_id INT NOT NULL,
    sale_amount INT NOT NULL,
    sale_date DATE NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);

-- Insert Data into the Sales Table
INSERT INTO sales (sale_id, emp_id, sale_amount, sale_date) VALUES
(201, 101, 9500, '2025-01-05'),
(202, 102, 7800, '2025-01-10'),
(203, 103, 6700, '2025-01-14'),
(204, 104, 12000, '2025-01-20'),
(205, 105, 9900, '2025-02-02'),
(206, 106, 16000, '2025-02-09'),
(207, 107, 7200, '2025-02-09'),
(208, 108, 5100, '2025-02-15'),
(209, 109, 3900, '2025-02-20'),
(210, 110, 7200, '2025-03-01');
-- --- Basic Level ---

-- 1. Retrieve the names of employees who earn more than the average salary of all employees.
SELECT name
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee);

-- 2. Find employees who belong to the department with the highest average salary.
SELECT name
FROM employee
WHERE dept_id = (
    SELECT dept_id
    FROM employee
    GROUP BY dept_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);

-- 3. List all employees who have made at least one sale.
SELECT DISTINCT T1.name
FROM employee AS T1
INNER JOIN sales AS T2 ON T1.emp_id = T2.emp_id;

-- 4. Find the employee with the highest sales amount.
SELECT T1.name
FROM employee AS T1
INNER JOIN sales AS T2 ON T1.emp_id = T2.emp_id
ORDER BY T2.sale_amount DESC
LIMIT 1;

-- 5. Retrieve the names of employees whose salaries are higher than Shubham's salary.
SELECT name
FROM employee
WHERE salary > (
    SELECT salary
    FROM employee
    WHERE name = 'Shubham'
);

-- --- Intermediate Level ---

-- 1. Find employees who work in the same department as Abhishek.
SELECT name
FROM employee
WHERE dept_id = (
    SELECT dept_id
    FROM employee
    WHERE name = 'Abhishek'
)
AND name <> 'Abhishek'; -- Exclude Abhishek himself

-- 2. List departments that have at least one employee earning more than ₹60,000.
SELECT DISTINCT T2.department_name
FROM employee AS T1
INNER JOIN department AS T2 ON T1.dept_id = T2.dept_id
WHERE T1.salary > 60000;

-- 3. Find the department name of the employee who made the highest sale.
SELECT T3.department_name
FROM employee AS T1
INNER JOIN sales AS T2 ON T1.emp_id = T2.emp_id
INNER JOIN department AS T3 ON T1.dept_id = T3.dept_id
ORDER BY T2.sale_amount DESC
LIMIT 1;
/* Alternative using subquery:
SELECT T2.department_name
FROM employee AS T1
INNER JOIN department AS T2 ON T1.dept_id = T2.dept_id
WHERE T1.emp_id = (
    SELECT emp_id
    FROM sales
    ORDER BY sale_amount DESC
    LIMIT 1
);
*/

-- 4. Retrieve employees who have made sales greater than the average sale amount.
SELECT DISTINCT T1.name
FROM employee AS T1
INNER JOIN sales AS T2 ON T1.emp_id = T2.emp_id
WHERE T2.sale_amount > (
    SELECT AVG(sale_amount)
    FROM sales
);

-- 5. Find the total sales made by employees who earn more than the average salary.
SELECT SUM(T2.sale_amount) AS total_sales
FROM employee AS T1
INNER JOIN sales AS T2 ON T1.emp_id = T2.emp_id
WHERE T1.salary > (
    SELECT AVG(salary)
    FROM employee
);

-- --- Advanced Level ---

-- 1. Retrieve employees who have not made any sales.
SELECT name
FROM employee
WHERE emp_id NOT IN (
    SELECT DISTINCT emp_id
    FROM sales
);
/* Alternative using LEFT JOIN:
SELECT T1.name
FROM employee AS T1
LEFT JOIN sales AS T2 ON T1.emp_id = T2.emp_id
WHERE T2.sale_id IS NULL;
*/

-- 2. List departments where the average salary is above ₹55,000.
SELECT T2.department_name
FROM employee AS T1
INNER JOIN department AS T2 ON T1.dept_id = T2.dept_id
GROUP BY T2.department_name
HAVING AVG(T1.salary) > 55000;

-- 3. Retrieve department names located in 'Mumbai' or total sales are greater than ₹10,000.
SELECT department_name
FROM department
WHERE location = 'Mumbai'

UNION

SELECT T3.department_name
FROM sales AS T1
INNER JOIN employee AS T2 ON T1.emp_id = T2.emp_id
INNER JOIN department AS T3 ON T2.dept_id = T3.dept_id
GROUP BY T3.department_name
HAVING SUM(T1.sale_amount) > 10000;

-- 4. Find the employee who has made the second-highest sale.
SELECT T1.name
FROM employee AS T1
INNER JOIN sales AS T2 ON T1.emp_id = T2.emp_id
ORDER BY T2.sale_amount DESC
LIMIT 1 OFFSET 1;

-- 5. Retrieve the names of employees whose salary is greater than the highest sale amount recorded.
SELECT name
FROM employee
WHERE salary > (
    SELECT MAX(sale_amount)
    FROM sales
);