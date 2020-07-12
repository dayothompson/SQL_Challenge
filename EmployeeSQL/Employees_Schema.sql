CREATE TABLE departments (dept_no VARCHAR(30) PRIMARY KEY,
						 dept_name VARCHAR(50))

CREATE TABLE dept_emp (emp_no INT,
					  dept_no VARCHAR(30))
					  
CREATE TABLE dept_manager (dept_no VARCHAR(30),
						  emp_no INT)

CREATE TABLE employees (emp_no INT,
					   emp_title VARCHAR(30),
					   birth_date date NOT NULL,
					   first_name VARCHAR(30),
					   last_name VARCHAR(30),
					   sex VARCHAR(10),
					   hire_date date NOT NULL)

CREATE TABLE salaries (emp_no INT,
					  salary INT)

CREATE TABLE titles (title_id VARCHAR(30),
					title VARCHAR(50))
					
					