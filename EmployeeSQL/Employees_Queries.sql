-- List the following details of each employee: 
-- employee number, last name, first name, sex, and salary
SELECT E.emp_no, E.last_name, E.first_name, E.sex, S.salary 
FROM employees AS E
JOIN salaries AS S ON E.emp_no = S.emp_no


-- List first name, last name, and hire date for employees 
-- who were hired in 1986
SELECT E.first_name, E.last_name, E.hire_date
FROM employees AS E
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'


-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, 
-- last name, first name
SELECT D.dept_no, D.dept_name, DM.emp_no, E.last_name, E.first_name 
FROM employees AS E
JOIN dept_manager AS DM ON E.emp_no = DM.emp_no
JOIN departments AS D ON DM.dept_no = D.dept_no


-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
SELECT DE.emp_no, E.last_name, E.first_name, D.dept_name
FROM employees AS E
JOIN dept_emp AS DE ON E.emp_no = DE.emp_no
JOIN departments AS D ON DE.dept_no = D.dept_no


-- List first name, last name, and sex for employees whose first name 
-- is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'


-- List all employees in the Sales department, including 
-- their employee number, last name, first name, and department name.
SELECT E.emp_no, E.last_name, E.first_name, D.dept_name 
FROM employees AS E
JOIN dept_emp AS DE ON E.emp_no = DE.emp_no
JOIN departments AS D ON DE.dept_no = D.dept_no
WHERE dept_name = 'Sales'


-- List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
SELECT E.emp_no, E.last_name, E.first_name, D.dept_name 
FROM employees AS E
JOIN dept_emp AS DE ON E.emp_no = DE.emp_no
JOIN departments AS D ON DE.dept_no = D.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'


-- In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) as CL
FROM employees
GROUP BY last_name
ORDER BY CL DESC


-- EPILOGUE
SELECT last_name, first_name
FROM employees
WHERE emp_no = 499942


