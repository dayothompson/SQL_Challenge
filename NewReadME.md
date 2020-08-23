# Employee Database

![Sql](sql.png)


## Data Modeling 

### Entity–relationship diagram (ERD)

![EmployeesSQL ERD](EmployeeSQL/EmployeesSQL%20ERD.png)

### ERD Documentation

![Screen Shot 2020 08 22 At 8.02.19 PM](EmployeeSQL/Screen%20Shot%202020-08-22%20at%208.02.19%20PM.png)

## Data Engineering


CREATE TABLE "departments" (
    "dept_no" varchar(30)   NOT NULL,
    "dept_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(30)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(30)   NOT NULL,
    "emp_no" int   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title-id" varchar(30)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "sex" varchar(10)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "salary"
     )
);

CREATE TABLE "titles" (
    "title_id" varchar(30)   NOT NULL,
    "title" varchar(50)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title-id" FOREIGN KEY("emp_title-id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


## Data Analysis

##### List the following details of each employee: 
##### employee number, last name, first name, sex, and salary

SELECT E.emp_no, E.last_name, E.first_name, E.sex, S.salary 
FROM employees AS E
JOIN salaries AS S ON E.emp_no = S.emp_no


##### List first name, last name, and hire date for employees 
##### who were hired in 1986

SELECT E.first_name, E.last_name, E.hire_date
FROM employees AS E
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'


##### List the manager of each department with the following information: 
##### department number, department name, the manager's employee number, 
##### last name, first name

SELECT D.dept_no, D.dept_name, DM.emp_no, E.last_name, E.first_name 
FROM employees AS E
JOIN dept_manager AS DM ON E.emp_no = DM.emp_no
JOIN departments AS D ON DM.dept_no = D.dept_no


##### List the department of each employee with the following information: 
##### employee number, last name, first name, and department name.

SELECT DE.emp_no, E.last_name, E.first_name, D.dept_name
FROM employees AS E
JOIN dept_emp AS DE ON E.emp_no = DE.emp_no
JOIN departments AS D ON DE.dept_no = D.dept_no


##### List first name, last name, and sex for employees whose first name 
##### is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'


##### List all employees in the Sales department, including 
##### their employee number, last name, first name, and department name.

SELECT E.emp_no, E.last_name, E.first_name, D.dept_name 
FROM employees AS E
JOIN dept_emp AS DE ON E.emp_no = DE.emp_no
JOIN departments AS D ON DE.dept_no = D.dept_no
WHERE dept_name = 'Sales'


##### List all employees in the Sales and Development departments, 
##### including their employee number, last name, first name, and department name.

SELECT E.emp_no, E.last_name, E.first_name, D.dept_name 
FROM employees AS E
JOIN dept_emp AS DE ON E.emp_no = DE.emp_no
JOIN departments AS D ON DE.dept_no = D.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'


##### In descending order, list the frequency count of employee last names, 
##### i.e., how many employees share each last name.

SELECT last_name, COUNT(last_name) as CL
FROM employees
GROUP BY last_name
ORDER BY CL DESC


##### EPILOGUE
SELECT last_name, first_name
FROM employees
WHERE emp_no = 499942




# Import Modules

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from config import username, password
```


```python
#Connect to Postgresql 

from sqlalchemy import create_engine
engine = create_engine(f'postgresql://{username}:{password}@localhost:5432/Employees')
connection = engine.connect()
```


```python
# Read salaries table using the connection

salaries = pd.read_sql('select * from salaries', connection)
salaries.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>emp_no</th>
      <th>salary</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10001</td>
      <td>60117</td>
    </tr>
    <tr>
      <th>1</th>
      <td>10002</td>
      <td>65828</td>
    </tr>
    <tr>
      <th>2</th>
      <td>10003</td>
      <td>40006</td>
    </tr>
    <tr>
      <th>3</th>
      <td>10004</td>
      <td>40054</td>
    </tr>
    <tr>
      <th>4</th>
      <td>10005</td>
      <td>78228</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Plot a histogram of the most common salary ranges for employees

x_values = salaries['salary']
plt.figure(figsize=(12,8))
plt.grid()
plt.hist(x_values)
plt.xlabel("Salaries")
plt.ylabel("Number of Employees")
plt.title("Most Common Salary Ranges for Employees")
plt.ylim(0, 170000)
plt.show()
```


![png](output_3_0.png)



```python
# Read titles table using the connection

titles = pd.read_sql('select * from titles', connection)
titles
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>title_id</th>
      <th>title</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>s0001</td>
      <td>Staff</td>
    </tr>
    <tr>
      <th>1</th>
      <td>s0002</td>
      <td>Senior Staff</td>
    </tr>
    <tr>
      <th>2</th>
      <td>e0001</td>
      <td>Assistant Engineer</td>
    </tr>
    <tr>
      <th>3</th>
      <td>e0002</td>
      <td>Engineer</td>
    </tr>
    <tr>
      <th>4</th>
      <td>e0003</td>
      <td>Senior Engineer</td>
    </tr>
    <tr>
      <th>5</th>
      <td>e0004</td>
      <td>Technique Leader</td>
    </tr>
    <tr>
      <th>6</th>
      <td>m0001</td>
      <td>Manager</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Read employees table using the connection

employees = pd.read_sql('select * from employees', connection)
employees.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>emp_no</th>
      <th>emp_title-id</th>
      <th>birth_date</th>
      <th>first_name</th>
      <th>last_name</th>
      <th>sex</th>
      <th>hire_date</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>473302</td>
      <td>s0001</td>
      <td>1953-07-25</td>
      <td>Hideyuki</td>
      <td>Zallocco</td>
      <td>M</td>
      <td>1990-04-28</td>
    </tr>
    <tr>
      <th>1</th>
      <td>475053</td>
      <td>e0002</td>
      <td>1954-11-18</td>
      <td>Byong</td>
      <td>Delgrande</td>
      <td>F</td>
      <td>1991-09-07</td>
    </tr>
    <tr>
      <th>2</th>
      <td>57444</td>
      <td>e0002</td>
      <td>1958-01-30</td>
      <td>Berry</td>
      <td>Babb</td>
      <td>F</td>
      <td>1992-03-21</td>
    </tr>
    <tr>
      <th>3</th>
      <td>421786</td>
      <td>s0001</td>
      <td>1957-09-28</td>
      <td>Xiong</td>
      <td>Verhoeff</td>
      <td>M</td>
      <td>1987-11-26</td>
    </tr>
    <tr>
      <th>4</th>
      <td>282238</td>
      <td>e0003</td>
      <td>1952-10-28</td>
      <td>Abdelkader</td>
      <td>Baumann</td>
      <td>F</td>
      <td>1991-01-18</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Merge employess and salaries table

emp_salaries = pd.merge(salaries, employees,  on='emp_no', how='outer')
emp_salaries.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>emp_no</th>
      <th>salary</th>
      <th>emp_title-id</th>
      <th>birth_date</th>
      <th>first_name</th>
      <th>last_name</th>
      <th>sex</th>
      <th>hire_date</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10001</td>
      <td>60117</td>
      <td>e0003</td>
      <td>1953-09-02</td>
      <td>Georgi</td>
      <td>Facello</td>
      <td>M</td>
      <td>1986-06-26</td>
    </tr>
    <tr>
      <th>1</th>
      <td>10002</td>
      <td>65828</td>
      <td>s0001</td>
      <td>1964-06-02</td>
      <td>Bezalel</td>
      <td>Simmel</td>
      <td>F</td>
      <td>1985-11-21</td>
    </tr>
    <tr>
      <th>2</th>
      <td>10003</td>
      <td>40006</td>
      <td>e0003</td>
      <td>1959-12-03</td>
      <td>Parto</td>
      <td>Bamford</td>
      <td>M</td>
      <td>1986-08-28</td>
    </tr>
    <tr>
      <th>3</th>
      <td>10004</td>
      <td>40054</td>
      <td>e0003</td>
      <td>1954-05-01</td>
      <td>Chirstian</td>
      <td>Koblick</td>
      <td>M</td>
      <td>1986-12-01</td>
    </tr>
    <tr>
      <th>4</th>
      <td>10005</td>
      <td>78228</td>
      <td>s0001</td>
      <td>1955-01-21</td>
      <td>Kyoichi</td>
      <td>Maliniak</td>
      <td>M</td>
      <td>1989-09-12</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Rename emp_title-id to title_id to perform a merge on title_id

emp_salaries.rename(columns={'emp_title-id': 'title_id'}, inplace=True)
emp_salaries.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>emp_no</th>
      <th>salary</th>
      <th>title_id</th>
      <th>birth_date</th>
      <th>first_name</th>
      <th>last_name</th>
      <th>sex</th>
      <th>hire_date</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10001</td>
      <td>60117</td>
      <td>e0003</td>
      <td>1953-09-02</td>
      <td>Georgi</td>
      <td>Facello</td>
      <td>M</td>
      <td>1986-06-26</td>
    </tr>
    <tr>
      <th>1</th>
      <td>10002</td>
      <td>65828</td>
      <td>s0001</td>
      <td>1964-06-02</td>
      <td>Bezalel</td>
      <td>Simmel</td>
      <td>F</td>
      <td>1985-11-21</td>
    </tr>
    <tr>
      <th>2</th>
      <td>10003</td>
      <td>40006</td>
      <td>e0003</td>
      <td>1959-12-03</td>
      <td>Parto</td>
      <td>Bamford</td>
      <td>M</td>
      <td>1986-08-28</td>
    </tr>
    <tr>
      <th>3</th>
      <td>10004</td>
      <td>40054</td>
      <td>e0003</td>
      <td>1954-05-01</td>
      <td>Chirstian</td>
      <td>Koblick</td>
      <td>M</td>
      <td>1986-12-01</td>
    </tr>
    <tr>
      <th>4</th>
      <td>10005</td>
      <td>78228</td>
      <td>s0001</td>
      <td>1955-01-21</td>
      <td>Kyoichi</td>
      <td>Maliniak</td>
      <td>M</td>
      <td>1989-09-12</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Merge emp_salaries and titles table

new_merge = pd.merge(emp_salaries, titles, on='title_id', how='outer')
new_merge.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>emp_no</th>
      <th>salary</th>
      <th>title_id</th>
      <th>birth_date</th>
      <th>first_name</th>
      <th>last_name</th>
      <th>sex</th>
      <th>hire_date</th>
      <th>title</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10001</td>
      <td>60117</td>
      <td>e0003</td>
      <td>1953-09-02</td>
      <td>Georgi</td>
      <td>Facello</td>
      <td>M</td>
      <td>1986-06-26</td>
      <td>Senior Engineer</td>
    </tr>
    <tr>
      <th>1</th>
      <td>10003</td>
      <td>40006</td>
      <td>e0003</td>
      <td>1959-12-03</td>
      <td>Parto</td>
      <td>Bamford</td>
      <td>M</td>
      <td>1986-08-28</td>
      <td>Senior Engineer</td>
    </tr>
    <tr>
      <th>2</th>
      <td>10004</td>
      <td>40054</td>
      <td>e0003</td>
      <td>1954-05-01</td>
      <td>Chirstian</td>
      <td>Koblick</td>
      <td>M</td>
      <td>1986-12-01</td>
      <td>Senior Engineer</td>
    </tr>
    <tr>
      <th>3</th>
      <td>10006</td>
      <td>40000</td>
      <td>e0003</td>
      <td>1953-04-20</td>
      <td>Anneke</td>
      <td>Preusig</td>
      <td>F</td>
      <td>1989-06-02</td>
      <td>Senior Engineer</td>
    </tr>
    <tr>
      <th>4</th>
      <td>10009</td>
      <td>60929</td>
      <td>e0003</td>
      <td>1952-04-19</td>
      <td>Sumant</td>
      <td>Peac</td>
      <td>F</td>
      <td>1985-02-18</td>
      <td>Senior Engineer</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Select required columns from the merged table

new_df = new_merge[['salary', 'title']]
new_df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>salary</th>
      <th>title</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>60117</td>
      <td>Senior Engineer</td>
    </tr>
    <tr>
      <th>1</th>
      <td>40006</td>
      <td>Senior Engineer</td>
    </tr>
    <tr>
      <th>2</th>
      <td>40054</td>
      <td>Senior Engineer</td>
    </tr>
    <tr>
      <th>3</th>
      <td>40000</td>
      <td>Senior Engineer</td>
    </tr>
    <tr>
      <th>4</th>
      <td>60929</td>
      <td>Senior Engineer</td>
    </tr>
  </tbody>
</table>
</div>




```python
plot_df = new_df.groupby('title')['salary'].mean().round(2)
plot_df
```




    title
    Assistant Engineer    48564.43
    Engineer              48535.34
    Manager               51531.04
    Senior Engineer       48506.80
    Senior Staff          58550.17
    Staff                 58465.38
    Technique Leader      48582.90
    Name: salary, dtype: float64




```python
# Plot a histogram of the average salary by title

plt.figure(figsize=(12,8))
plt.xlabel("Title")
plt.ylabel("Average Salary")
plt.title("Average Title by Employees")
plt.ylim(0, 65000)
plot_df.plot(kind='bar', rot=60)
plt.grid()
plt.show()
```


![png](output_11_0.png)



```python

```


#### Schema generated from . Remember to specify data types, primary keys, foreign keys, and other constraints.


