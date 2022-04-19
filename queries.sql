-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE(dept_name)
);


CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no),
	UNIQUE(emp_no)
);


CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY(dept_no) REFERENCES departments (dept_no),
		PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
		PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp (
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (dept_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM dept_emp;
SELECT * FROM titles;

DROP TABLE titles;
DROP TABLE dept_emp;

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);


CREATE TABLE titles (
    emp_no INT NOT NULL,
    title VARCHAR(50) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no, title, from_date)
);

--Retirement eligibility

SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31'

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31'

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31'

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31'

--Retirement eligible 

SELECT first_name, last_name
-- Tell to save into a table
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Make sure above worked with a select * to get all info from table
SELECT * FROM retirement_info

-- Recreate the retirement_info table with the emp_no column so it can be joined with other tables later
DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
-- done with innter join so that it doesnt include NaNs if a dept doesnt have a manager

--Select statement selects the columns we want to view from each table
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
-- tells 1st (or left) table to be joined
FROM departments as d
--tells 2nd (or right) table to be joined and how to join
INNER JOIN dept_manager as dm
-- on the common column
ON d.dept_no = dm.dept_no;

--Joining retirement info and dept emp tables to add the to_date to retirement info
--makes sure they still work with the company

SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
--put in new table
INTO current_emp
--assign the left table with from
FROM retirement_info as ri
--specify join type and right table
LEFT JOIN dept_emp as de
--on common column
ON ri.emp_no = de.emp_no
--use a where statement to get only current employees (w/ to date 9999-01-01)
	--still need to access independent database bc join hasnt been run yet
WHERE de.to_date = ('9999-01-01');

--join current_emp and dept_emp tables to get
--Employee count by department #
--count # of emp per department
--only need emp and dept # since already selected for retirement eligibily and currently with comp in previous tables creation
SELECT COUNT(ce.emp_no), de.dept_no
INTO count_retire_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
--groupts by department number
GROUP BY de.dept_no
--add order by clause to org in ascending/descending order - returned randomly if not included
-- include the column you want organized
ORDER BY de.dept_no;

SELECT * FROM count_retire_by_dept;

--create table 1 with emp #, first and last name, gender, to date, and salary

--look at salaries table and org the to_date to be descending since its org by emp_no orig
SELECT * FROM salaries
ORDER BY to_date DESC;

--reuse code to filter emp table to show only emp born and hired at right time for retirement
	-- need to add gender in selection from employees table
	--make sure to change new table name
	--join the tables, add the to date and salary to select from other table
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
--get to_date from de bc salaries to date is super off from what it should be
--may not have salaries for everyone but still want info??
	de.to_date
--comment out into and run without first to make sure everythings right before putting into a table
	--keeps you from having to delete the table every time the code needs adjusting in creation
INTO emp_info
FROM employees as e
--inner join bc only want matching records
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
--add 3rd table right under second
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
--filters for birth and hire date to get retirement eligible 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
-- add the 9999-01-01 to date to get people still working at the compant
AND (de.to_date = '9999-01-01')


