-- using alias for clean code. need to get said columns from the employees and titles tables
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
t.to_date
-- use INTO to create a new table
INTO ret_titles
FROM employees as e
-- Join tables on primary keys and use where to filter for said age bracket
INNER JOIN titles as t ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

SELECT * FROM retiring_titles;

-- Need to filter out employees who have left the company but are still in the system
-- and place into a table
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO Unique_titles
FROM ret_titles as rt
WHERE to_date = ('9999-01-01')
ORDER BY emp_no, to_date DESC;

-- narrow it down to the employees who are in retirement age and get a head count by job title
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles as u
GROUP BY title
ORDER BY count(emp_no) DESC;

-- need displayed columns from the employees, title, and dept_emp tables
-- distinct on is needed to return the first instance of an employee being displayed in the system
SELECT DISTINCT ON(e.emp_no)e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t ON (e.emp_no = t.emp_no)
-- filter on to_date and birthday columns
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
--reorgainze
ORDER BY emp_no;

SELECT * FROM mentorship_eligibility