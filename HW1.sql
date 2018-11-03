-- Part I – Working with an existing database
-- 1.0	Setting up Oracle Chinook
-- In this section you will begin the process of working with the Oracle Chinook database
-- Task – Open the Chinook_Oracle.sql file and execute the scripts within.
Done.
-- 2.0 SQL Queries
-- In this section you will be performing various queries against the Oracle Chinook database.
-- 2.1 SELECT
-- Task – Select all records from the Employee table.
set schema 'chinook';
SELECT * 
FROM employee;
-- Task – Select all records from the Employee table where last name is King.
set schema 'chinook';
SELECT * 
FROM employee
WHERE LastName = 'King';
-- Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
set schema 'chinook';
SELECT *
FROM employee
WHERE FirstName = 'Andrew' and ReportsTo IS NULL;
-- 2.2 ORDER BY
-- Task – Select all albums in Album table and sort result set in descending order by title.
set schema 'chinook';
SELECT Title
FROM album
ORDER BY title DESC;
-- Task – Select first name from Customer and sort result set in ascending order by city
set schema 'chinook';
SELECT FirstName
FROM customer
ORDER BY City ASC;
-- 2.3 INSERT INTO
-- Task – Insert two new records into Genre table - DONE
set schema 'chinook';
INSERT INTO genre (genreid, name) 
VALUES (26,'low-fi'); 
VALUES (27, 'EDM');
-- Task – Insert two new records into Employee table - 
set schema 'chinook';
INSERT INTO employee (employeeid, lastname, firstname, title, reportsto, birthdate, hiredate, address, city, state, country, postalcode, phone, fax, email)
VALUES (9, 'Smith', 'Will', 'IT Staff', 1, '1955-06-25 00:00:00', '1994-05-26 00:00:00', '123 Somewhere Ave.', 'Calgary', 'AB', 'Canada', 'T5K 2N1', '+1 (403) 555-5555', '+1 (403) 444-4444', 'freshp@chinookcorp.com');
VALUES (10, 'Ross', 'Bob', 'IT Staff', 1, '1950-01-22 00:00:00', '2002-07-06 00:00:00', '124 Somewhere Ave.', 'Calgary', 'AB', 'Canada', 'T5K 2N2', '+1 (403) 555-5557', '+1 (403) 555-4444', 'joyofpaint@chinookcorp.com');
-- Task – Insert two new records into Customer table - DONE
set schema 'chinook';
INSERT INTO customer (customerid, firstname, lastname, company, address, city, state, country, postalcode, phone, fax, email, supportrepid)
VALUES (60, 'Rick', 'James', NULL, '123 Spooner Street', 'Jackson', 'Mississippi', 'United States', 39056, '+01 601 555 5555', NULL, 'RJB@Google.com', 3);
VALUES (61, 'James', 'Brown', NULL, '124 Spooner Street', 'Jackson', 'Mississippi', 'United States', 39056, '+01 601 555 5556', NULL, 'ShowBiz@yahoo.com', 3);
-- 2.4 UPDATE
-- Task – Update Aaron Mitchell in Customer table to Robert Walter
set schema 'chinook';
UPDATE customer
SET firstname = 'Robert', lastname='Walter'
WHERE customerid=32;
-- Task – Update name of artist in the Artist table “Creedence Clearwater Revival” to “CCR”
set schema 'chinook';
UPDATE artist
SET name ='CCR'
WHERE artistid = 76;
-- 2.5 LIKE
-- Task – Select all invoices with a billing address like “T%”
set schema 'chinook';
SELECT *
FROM invoice
WHERE billingaddress LIKE 'T%';
-- 2.6 BETWEEN
-- Task – Select all invoices that have a total between 15 and 50
set schema 'chinook';
SELECT *
FROM invoice
WHERE total BETWEEN 15 AND 50;
-- Task – Select all employees hired between 1st of June 2003 and 1st of March 2004
set schema 'chinook';
SELECT *
FROM employee
WHERE hiredate BETWEEN '01-06-2003' AND '01-03-2004';
-- 2.7 DELETE
-- Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).
set schema 'chinook';
ALTER TABLE invoice
DROP CONSTRAINT fk_invoicecustomerid;
DELETE FROM customer
WHERE customerid=32;
-- 3.0	SQL Functions
-- In this section you will be using the Oracle system functions, as well as your own functions, to perform various actions against the database
-- 3.1 System Defined Functions
-- Task – Create a function that returns the current time.
set schema 'chinook';
CREATE OR REPLACE FUNCTION my_time()
RETURNS VARCHAR AS $$
	BEGIN
		RETURN (SELECT now());
	END;
$$ LANGUAGE plpgsql;
-- Task – create a function that returns the length of a mediatype from the mediatype table
set schema 'chinook';
select name, LENGTH(name)
from mediatype;
-- 3.2 System Defined Aggregate Functions
-- Task – Create a function that returns the average total of all invoices
set schema 'chinook';
CREATE OR REPLACE FUNCTION invoice_average()
	RETURNS MONEY AS $$
		BEGIN
			RETURN(SELECT AVG(total) FROM invoice);
	END;
$$ LANGUAGE plpgsql;
-- Task – Create a function that returns the most expensive track
set schema 'chinook';
CREATE OR REPLACE FUNCTION max_track()
	RETURNS DECIMAL AS $$
		BEGIN
			RETURN(SELECT MAX(unitprice) FROM track);
	END;
$$ LANGUAGE plpgsql;
-- 3.3 User Defined Scalar Functions
-- Task – Create a function that returns the average price of invoiceline items in the invoiceline table
set schema 'chinook';
CREATE OR REPLACE FUNCTION invoice_average()
	RETURNS MONEY AS $$
		BEGIN
			RETURN(SELECT AVG(total) FROM invoice);
	END;
$$ LANGUAGE plpgsql;
-- 3.4 User Defined Table Valued Functions
-- Task – Create a function that returns all employees who are born after 1968.
set schema 'chinook';
CREATE OR REPLACE FUNCTION employeeage()
	RETURNS TABLE(
		firstname VARCHAR,
		lastname  VARCHAR)
			AS $$
			BEGIN
		RETURN QUERY(
			SELECT employee.firstname, employee.lastname
			FROM employee
			WHERE birthdate > '1968-12-31 00:00:00');
		END;
	$$ LANGUAGE plpgsql;
-- 4.0 Stored Procedures
--  In this section you will be creating and executing stored procedures. You will be creating various types of stored procedures that take input and output parameters.
-- 4.1 Basic Stored Procedure
-- Task – Create a stored procedure that selects the first and last names of all the employees.
set schema 'chinook';
CREATE OR REPLACE FUNCTION employeeName()
	RETURNS TABLE(
		firstname VARCHAR,
		lastname  VARCHAR)
			AS $$
			BEGIN
		RETURN QUERY(
			SELECT employee.firstname, employee.lastname
			FROM employee);
		END;
	$$ LANGUAGE plpgsql;
-- 4.2 Stored Procedure Input Parameters
-- Task – Create a stored procedure that updates the personal information of an employee.
set schema 'chinook';
CREATE OR REPLACE FUNCTION employeeUpdate()
	RETURNS VOID AS $$
		BEGIN
			UPDATE employee
			SET lastname = 'Munster'
			WHERE employeeid = 1;
		END;
	$$ LANGUAGE plpgsql;
-- Task – Create a stored procedure that returns the managers of an employee.
NOT DONE
-- 4.3 Stored Procedure Output Parameters
-- Task – Create a stored procedure that returns the name and company of a customer.
set schema 'chinook';
CREATE OR REPLACE FUNCTION customerInfo()
	RETURNS Table(
		firstname VARCHAR,
		company  VARCHAR)
			AS $$
			BEGIN
		RETURN QUERY(
			SELECT customer.firstname, customer.company
			FROM customer);
		END;
	$$ LANGUAGE plpgsql;
	
SELECT customerInfo();
-- 5.0 Transactions
-- In this section you will be working with transactions. Transactions are usually nested within a stored procedure. You will also be working with handling errors in your SQL.
-- Task – Create a transaction that given a invoiceId will delete that invoice (There may be constraints that rely on this, find out how to resolve them).
-- Task – Create a transaction nested within a stored procedure that inserts a new record in the Customer table
-- 6.0 Triggers
-- In this section you will create various kinds of triggers that work when certain DML statements are executed on a table.
-- 6.1 AFTER/FOR
-- Task - Create an after insert trigger on the employee table fired after a new record is inserted into the table.
set schema 'chinook';
CREATE OR REPLACE FUNCTION recordInsert()
RETURNS TRIGGER AS $$
BEGIN
	IF(TG_OP = 'INSERT') THEN
		SELECT * FROM employee;
		END IF;
	RETURN NEW;
	
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_trig
BEFORE INSERT ON employee
EXECUTE PROCEDURE ON recordinsert();
-- Task – Create an after update trigger on the album table that fires after a row is inserted in the table
set schema 'chinook';
CREATE OR REPLACE FUNCTION rowInsert()
RETURNS TRIGGER AS $$
BEGIN
	IF(TG_OP = 'INSERT') THEN
		SELECT * FROM album;
		END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_Row
BEFORE INSERT ON album
EXECUTE PROCEDURE rowInsert();
-- Task – Create an after delete trigger on the customer table that fires after a row is deleted from the table.
set schema 'chinook';
CREATE OR REPLACE FUNCTION rowDelete()
RETURNS TRIGGER AS $$
BEGIN
	IF(TG_OP = 'DELETE') THEN
		SELECT * FROM customer;
		END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_row
BEFORE DELETE ON customer
EXECUTE PROCEDURE rowDelete()
-- 6.2 Before
-- Task – Create a before trigger that restricts the deletion of any invoice that is priced over 50 dollars.
-- 7.0 JOINS
-- In this section you will be working with combing various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.
-- 7.1 INNER
-- Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
set schema 'chinook';
SELECT customer.firstname, customer.lastname, invoice.invoiceID
FROM invoice
INNER JOIN customer on invoice.customerID = customer.customerid;
-- 7.2 OUTER
-- Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, lastname, invoiceId, and total.
set schema 'chinook';
SELECT  customer.customerID, customer.firstname, customer.lastname, invoice.invoiceID
FROM invoice
FULL OUTER JOIN customer on invoice.customerid = customer.customerid;
-- 7.3 RIGHT
-- Task – Create a right join that joins album and artist specifying artist name and title.
set schema 'chinook';
SELECT artist.name, album.title
FROM artist
RIGHT JOIN album on artist.artistid = album.artistid;
-- 7.4 CROSS
-- Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.
set schema 'chinook';
SELECT * 
FROM artist
CROSS JOIN album
ORDER BY artist asc;
-- 7.5 SELF
-- Task – Perform a self-join on the employee table, joining on the reportsto column.
set schema 'chinook';
SELECT a.firstname, a.lastname, a.reportsto
from employee a, employee b
WHERE A.reportsto <> B.reportsto;