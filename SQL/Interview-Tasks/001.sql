/*
A table schema with tables like employee, department, employee_to_projects, projects;

employee has columns:
        emp_id, emp_name, department_id, salary

department has columns:
        department_id, dept_name

1) Select employee from departments where max salary of the department is 40k. */

SELECT e.emp_id, e.emp_name
FROM employee e
JOIN department d ON e.department_id = d.department_id
WHERE e.department_id IN (
    SELECT e2.department_id
    FROM employee e2
    GROUP BY e2.department_id
    HAVING MAX(e2.salary) = 40000
);

--  emp_id |  emp_name  
-- --------+------------
--       1 | John Doe
--       2 | Jane Smith


-- Create department table
CREATE TABLE department (
    department_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Create employee table
CREATE TABLE employee (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);

-- Insert into department
INSERT INTO department (dept_name)
VALUES 
('HR'),
('Finance'),
('Engineering');

-- Insert into employee
INSERT INTO employee (emp_name, department_id, salary)
VALUES 
('John Doe', 1, 35000),  -- HR
('Jane Smith', 1, 40000), -- HR
('Michael Johnson', 2, 45000), -- Finance
('Sara Connor', 2, 40000), -- Finance
('David Brown', 3, 60000), -- Engineering
('Emily Davis', 3, 38000); -- Engineering





/*
2) Select employee assigned to projects.
3) Select employee which have the max salary in a given department. 
4) Select employee with second highest salary.
*/




/*

A table has two data entries every day for # of apples and oranges sold.
Write a query to get the difference between the apples and oranges sold on a given day.

*/


