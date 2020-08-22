```python
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
