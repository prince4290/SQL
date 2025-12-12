-- Student Performance Dataset
CREATE TABLE Student_Performance (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    course VARCHAR(50) NOT NULL,
    score INT NOT NULL,
    attendance INT NOT NULL,
    mentor VARCHAR(50) NOT NULL,
    join_date DATE NOT NULL,
    city VARCHAR(50) NOT NULL
);

-- Insert into Student_Performance Dataset
INSERT INTO Student_Performance (student_id, name, course, score, attendance, mentor, join_date, city) VALUES
(101, 'Aarav Mehta', 'Data Science', 90, 92, 'Dr. Sharma', '2023-06-15', 'Mumbai'),
(102, 'Shreya Patel', 'Data Science', 76, 80, 'Dr. Sharma', '2023-06-20', 'Delhi'),
(103, 'Riya Singh', 'Data Science', 95, 98, 'Dr. Sharma', '2023-07-01', 'Mumbai'),
(104, 'Kabir Khan', 'Python', 93, 90, 'Ms. Nair', '2023-07-10', 'Bengaluru'),
(105, 'Nikhil Deshmukh', 'Python', 88, 85, 'Ms. Nair', '2023-08-01', 'Pune'),
(106, 'Tanvi Patil', 'SQL', 80, 89, 'Mr. Iyer', '2023-08-05', 'Hyderabad'),
(107, 'Rahul Dev', 'SQL', 65, 78, 'Mr. Iyer', '2023-08-10', 'Delhi'),
(108, 'Ayesha Khan', 'Python', 75, 81, 'Ms. Nair', '2023-08-15', 'Hyderabad'),
(109, 'Om Sharma', 'Tableau', 98, 97, 'Ms. Kapoor', '2023-09-01', 'Kochi'),
(110, 'Arjun Varma', 'Tableau', 92, 95, 'Ms. Kapoor', '2023-09-05', 'Pune'),
(111, 'Meera Pillai', 'Tableau', 82, 87, 'Ms. Kapoor', '2023-09-10', 'Delhi'),
(112, 'Pranav Kothi', 'Data Science', 79, 82, 'Dr. Sharma', '2023-09-15', 'Kochi'),
(113, 'Nikhil Rana', 'SQL', 94, 91, 'Mr. Iyer', '2023-10-01', 'Mumbai'),
(114, 'Priya Desai', 'SQL', 82, 96, 'Mr. Iyer', '2023-10-05', 'Bengaluru'),
(115, 'Rohit Verma', 'Python', 85, 90, 'Ms. Nair', '2023-10-10', 'Kochi'),
(116, 'Siddharth Jain', 'Python', 89, 90, 'Ms. Nair', '2023-10-15', 'Hyderabad'),
(117, 'Neha Kulkarni', 'Tableau', 74, 86, 'Ms. Kapoor', '2023-11-01', 'Delhi'),
(118, 'Rohan Gupta', 'SQL', 89, 93, 'Mr. Iyer', '2023-11-05', 'Pune'),
(119, 'Ishita Joshi', 'Data Science', 93, 97, 'Dr. Sharma', '2023-11-10', 'Bengaluru'),
(120, 'Yuvraj Rao', 'Python', 71, 84, 'Ms. Nair', '2023-11-15', 'Hyderabad');


-- Question 1: Create a ranking of students based on score (highest first).
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS score_rank FROM Student_Performance ORDER BY score_rank, score DESC;

-- Question 2: Show each student's score and the previous student's score (based on score order).
SELECT name, score, LAG(score) OVER (ORDER BY score DESC) AS previous_score FROM Student_Performance ORDER BY score DESC;

-- Question 3: Convert all student names to uppercase and extract the month name from join_date.
SELECT UPPER(name) AS uppercase_name, score, MONTHNAME(join_date) AS join_month_name FROM Student_Performance;

-- Question 4: Show each student's name and the next student's attendance (ordered by attendance).
SELECT name, attendance, LEAD(attendance) OVER (ORDER BY attendance DESC) AS next_attendance FROM Student_Performance ORDER BY attendance DESC;

-- Question 5: Assign students into 4 performance groups using NTILE().
SELECT name, score, NTILE(4) OVER (ORDER BY score DESC) AS performance_group FROM Student_Performance ORDER BY score DESC;

-- Question 6: For each course, assign a row number based on attendance (highest first).
SELECT name, course, attendance, ROW_NUMBER() OVER (PARTITION BY course ORDER BY attendance DESC) AS attendance_rank_in_course FROM Student_Performance ORDER BY course, attendance_rank_in_course;

-- Question 7: Calculate the number of days each student has been enrolled (from join_date to today). (Assume current date = 2025-01-01)
SELECT name, join_date, DATEDIFF('2025-01-01', join_date) AS days_enrolled FROM Student_Performance;

-- Question 8: Format join_date as "Month Year" (e.g., "June 2023").
SELECT name, join_date, DATE_FORMAT(join_date, '%M %Y') AS formatted_join_date FROM Student_Performance;

-- Question 9: Replace the city 'Mumbai' with 'MUM' for display purposes.
SELECT name, city, REPLACE(city, 'Mumbai', 'MUM') AS display_city FROM Student_Performance;

-- Question 10: For each course, find the highest score using FIRST_VALUE().
SELECT DISTINCT course, FIRST_VALUE(score) OVER (PARTITION BY course ORDER BY score DESC) AS highest_score_in_course FROM Student_Performance;