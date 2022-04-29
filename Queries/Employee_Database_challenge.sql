

-- Create a retirement titles table
SELECT e.emp_no,
e.first_name,
e.last_name,
ti.title,
ti.from_date,
ti.to_date
--create new table
INTO retirement_titles
FROM employees as e
--join titles and employees table on pk
INNER JOIN titles as ti ON e.emp_no = ti.emp_no
--filter by birth date
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--order by the employee number
ORDER BY e.emp_no;

--confirm table created successfully
SELECT * FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows

--select distinct on emp # to get the first occurance of emp #(bc employees may have had different titles throughout employment)
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
--create new table
INTO unique_titles
FROM retirement_titles
--filter for current employees
WHERE to_date = ('9999-01-01')
--order by employee number with date descending
ORDER BY emp_no, to_date DESC;

--confirm table created successfully
SELECT * FROM unique_titles

-- Retrieve the # of titles from the Unique Titles table
SELECT COUNT(emp_no), title
--create new table
INTO retiring_titles
FROM unique_titles as u
--group by employees titles
GROUP BY title
--order by employee number to get counts of each titles retiring employees
ORDER BY count(emp_no) DESC;

--confirm table created successfully
SELECT * FROM retiring_titles

-- Query to create a mentorship eligibility table that holds those eligible
--select distinct on emp # to get the first occurance of emp #
SELECT DISTINCT ON(e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
--create new table
INTO mentorship_eligibility
FROM employees as e
--join dept_emp table pk
INNER JOIN dept_emp as de ON e.emp_no = de.emp_no
--join titles table on pk
INNER JOIN titles as ti ON e.emp_no = ti.emp_no
--filter for desired birth date and current employees
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND  (de.to_date = ('9999-01-01'))
--order by employee number
ORDER BY e.emp_no

--confirm table created successfully	
SELECT * FROM mentorship_eligibility

