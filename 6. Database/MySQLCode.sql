# list current databases
SHOW DATABASES;

/*
	list of built-in databases:
		- information_schema
        - mysql
        - performance_schema
        - sys
        - world
*/

# listing custom databases
select schema_name 
from information_schema.schemata
where schema_name not in ('information_schema','mysql','performance_schema','sys');

# listing contents of a DB
use sakila;				# to select one database to work with.
SHOW TABLES;			# lists all the tables within the selected DB.
SELECT * FROM actor;	# list rows and columns of a table.

/*
	DDL
		- create
        - alter
        - drop
        - truncate
	DML
		- select
        - insert
        - update
        - delete
*/

# create a database - it will check, then gives warning it DB exists
create database if not exists joindemo;

# create a database
create database employee;
SHOW DATABASES;

# select the DB for the usage
use employee;

/*
datatypes in SQL:
	- Numeric data types:
		int 		- whole number
        decimal 	- fixed number
        float		- floating number
	- char/string data type
		char		- fxed length
        varchar		- variable length
        text		- large variable length
	- date and time datatypes
		date		- stores calendar date (yyyy-mm-dd)
        time		- stores time of the day (hh:mm:ss)
        datetime	- date and time (yyyy-mm-dd hh:mm:ss)
	- logical datatype
		boolean		- TRUE/FALSE
	- others
		BLOB		- Binary Large OBject
*/

# create a table
CREATE TABLE emp(
	employee_id INT primary key,
    firstname varchar(50) NOT NULL,
    lastname varchar(50) NOT NULL,
    email varchar(50) NOT NULL unique,
    salary decimal (10,2)
);

# show the tables
SHOW tables;

# show columns within the database
DESC emp;

# inserting row in the table
INSERT INTO emp (employee_id, firstname, lastname, email, salary) 
VALUE (1,'Jitendra','Tomar','jeetu@gmail.com',1000000.00);

# display the content
SELECT * FROM emp;


# to insert multiple rows in the table
INSERT INTO emp (employee_id, firstname, lastname, email, salary) 
VALUE 
(2,'Brijendra','Tomar','brijendra@gmail.com',1200000.00),
(3,'Radha','Tomar','radha@gmail.com',500000.00),
(4,'deeksha','Jagdeshwaran','deeksha@gmail.com',1500000.00),
(5,'Raghu','Ram','raghuram@gmail.com',1300000.00),
(6,'Ramya','S','ramyas@gmail.com',2000000.00),
(7,'Blossom','A','blossom@gmail.com',1000000.00)
;

# to check if the data is update or not.
SELECT * FROM emp;

# adding another column in tha table
ALTER TABLE emp ADD Company varchar(20);
SELECT * FROM emp;

# adding value "Wipro" to the column 'company' wherever value is NULL.
UPDATE emp SET Company = 'Wipro' WHERE Company IS NULL;
SELECT * FROM emp;

/*
	- Arithmetic Operator
		+, -, *, /, %  
	- Comparison Operator
		=, != >, <, <=, >=, BETWEEN, LIKE, IN, IS NULL
	- Logical Operator
		AND, OR, NOT
	- Bitwise Operator
		&, ^, ~, >>, <<
*/

SELECT * FROM emp;
SELECT firstname FROM emp;

# list all the names where salary = 500000.00
SELECT firstname FROM emp WHERE salary = 500000.00;

# list all the names where salary > 500000.00
SELECT firstname FROM emp WHERE salary > 500000.00;

# list all the names where salary is between 500000.00 and 1000000.00
SELECT firstname FROM emp WHERE salary BETWEEN 500000.00 AND 1500000.00;

# delete the rows within the table.
TRUNCATE TABLE emp;			# quickly cleans the whole table
SELECT * FROM emp;

# adding another column in the table
ALTER TABLE emp ADD department varchar(20);
SELECT * FROM emp;

INSERT INTO emp (employee_id, firstname, lastname, email, salary, company, department) 
VALUE 
(1,'Jitendra','Tomar','jeetu@gmail.com',1000000.00, 'wipro','IT'),
(2,'Brijendra','Tomar','brijendra@gmail.com',1200000.00, 'wipro','Sports'),
(3,'Radha','Tomar','radha@gmail.com',500000.00, 'wipro','Developer'),
(4,'Deeksha','Jagdeshwaran','deeksha@gmail.com',1500000.00, 'wipro','Developer'),
(5,'Raghu','Ram','raghuram@gmail.com',1300000.00, 'wipro','Manager'),
(6,'Ramya','S','ramyas@gmail.com',2000000.00, 'wipro','Sales'),
(7,'Blossom','A','blossom@gmail.com',1000000.00, 'wipro','Operations')
;
SELECT * FROM emp;

# list all the name with their salaries from Developer department - restricting rows
SELECT firstname, salary FROM emp WHERE department = "Developer";

# combining 
SELECT * FROM emp WHERE department = 'IT' AND firstname = 'jitendra';

# IN
SELECT * FROM emp WHERE department IN ('IT','Manager','Developer');

# pattern
SELECT * FROM emp WHERE department LIKE "Dev%";

# alias
SELECT firstname AS 'First Name', lastname AS 'Last Name' from emp;			# only temporary changes.
SELECT * FROM emp;

# Alias with functions
SELECT COUNT(*) FROM emp;
SELECT COUNT(*) AS TotalEmployees FROM emp;

# to display name, salary & bonus
SELECT firstname, salary, salary * 0.010 AS bonus FROM emp;

# list average salary using group functions
SELECT COUNT(*) AS TotalEmployees, AVG(salary) AS AverageSalary FROM emp;

# showing average salaries department-wise
SELECT department, COUNT(*) AS NumEmployees, SUM(salary) AS TotalSalary 
FROM emp
GROUP BY department;

SHOW TABLES;

/* 
cloning a table
	- cloning can be done in 3 ways:
		1. Simple cloning
			- it clones only structure.
            - no data and no constraints or indexes
            - it copies column names and data types.
            - it does not include primary keys, foreign keys, indexes or data.
            - ex:
				# CREATE TABLE new_table LIKE original_table;
                
		2. Shallow cloning
			- it clones structure and data.
            - but without copying dependent objects like constraints or relationships
            - it does not copy foreign keys, triggers or indexes
            - ex:
				# CREATE TABLE new_table AS SELECT * FROM original_table;
                
		3. Deep cloning
			- it clones everything
				- structure, data, constraints, indexes, and so on...
			- it make a true duplicate of a table.
            - ex:
				# CREATE TABLE new_table LIKE original_table;
                # INSERT INTO new_table SELECT * FROM original_table;

*/

# shallow cloning
CREATE TABLE sc_emp SELECT * FROM emp;
SHOW TABLES;
SELECT * FROM sc_emp;

# deep cloning
CREATE TABLE dc_emp LIKE emp;
INSERT INTO dc_emp SELECT * FROM emp;
SELECT * FROM dc_emp;

SHOW TABLES;

# deleting a table
DROP TABLE emp;
DROP TABLE sc_emp;
DROP TABLE dc_emp;

# delete a database
DROP DATABASE employee;