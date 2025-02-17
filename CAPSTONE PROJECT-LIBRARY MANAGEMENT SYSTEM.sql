-- SQL CAPSTONE PROJECT-LIBRARY MANAGEMENT SYSTEM
-- CREATE DATABASE AND USE IT

CREATE DATABASE Library;
USE Library;

--  CREATE 'BRANCH' TABLE
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);

-- Create Employee Table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10,2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);


-- Create Books Table
CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10,2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(255),
    Publisher VARCHAR(255)
);

-- Create Customer Table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

-- Create IssueStatus Table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);


-- Create ReturnStatus Table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

-- Insert Sample Data into the tables and display it all.

INSERT INTO Branch VALUES (1, 101, 'Main Street, NY', '1234567890');
INSERT INTO Branch VALUES (2, 102, 'Second Ave, LA', '0987654321');
SELECT * FROM Branch;

INSERT INTO Employee VALUES (101, 'John Doe', 'Manager', 60000, 1);
INSERT INTO Employee VALUES (102, 'Jane Smith', 'Clerk', 45000, 2);
SELECT * FROM Employee;

INSERT INTO Books VALUES ('978-3-16-148410-0', 'History of Time', 'Science', 30, 'yes', 'Stephen Hawking', 'ABC Publishing');
INSERT INTO Books VALUES ('978-1-4028-9462-6', 'Learn SQL', 'Education', 25, 'no', 'John Doe', 'XYZ Press');

SELECT * FROM Books;

INSERT INTO Customer VALUES (201, 'Alice Brown', '5th Ave, NY', '2021-12-15');
INSERT INTO Customer VALUES (202, 'Bob White', 'Sunset Blvd, LA', '2023-06-10');

SELECT * FROM Customer;

INSERT INTO IssueStatus VALUES (301, 201, 'History of Time', '2023-06-15', '978-3-16-148410-0');
INSERT INTO IssueStatus VALUES (302, 202, 'Learn SQL', '2023-07-01', '978-1-4028-9462-6');

SELECT * FROM IssueStatus;

INSERT INTO ReturnStatus VALUES (401, 201, 'History of Time', '2023-07-10', '978-3-16-148410-0');
INSERT INTO ReturnStatus VALUES (402, 202, 'Learn SQL', '2023-08-01', '978-1-4028-9462-6');

SELECT * FROM ReturnStatus;

-- QUERIES
-- 1.Retrieve the book title, category, and rental price of all available books. 

SELECT Book_title,Category,Rental_Price FROM Books WHERE Status='Yes';

-- 2. List the employee names and their respective salaries in descending order of salary

 SELECT Emp_name,Salary FROM Employee ORDER BY Salary DESC;
 
 -- 3. Retrieve the book titles and the corresponding customers who have issued those books.
 
 SELECT Books.Book_title,Customer.customer_name FROM IssueStatus
 JOIN Books ON IssueStatus.Isbn_book=BOOKS.ISBN
 JOIN Customer ON IssueStatus.Issued_cust=Customer.customer_id;
 
 -- 4. Display the total count of books in each category.
 
 SELECT category,count(*) AS Total_CatergorywiseCounts FROM Books GROUP BY Category;
 
 -- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
 
 SELECT Emp_name,position FROM Employee where salary>50000;
 
 -- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
 
 INSERT INTO Customer VALUES (203, 'Reggi Brown', '5th Ave, NY', '2021-11-15');
 
 SELECT Customer_name FROM Customer WHERE Reg_date < '2022-01-01' AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);
 
 -- 7. Display the branch numbers and the total count of employees in each branch.
 
SELECT Branch_no, COUNT(*) AS Employee_Count FROM Employee GROUP BY Branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023.

SELECT DISTINCT Customer.Customer_name FROM IssueStatus
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

-- 9. Retrieve book_title from book table containing history.

SELECT Book_title FROM Books WHERE Book_title LIKE '%history%';

-- 10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.


INSERT INTO Employee VALUES (103, 'Emily Johnson', 'Assistant', 40000, 1),(104, 'Michael Brown', 'Librarian', 55000, 1),
(105, 'David Wilson', 'Staff', 35000, 1),(106, 'Sophia Miller', 'Clerk', 30000, 1),(107, 'Daniel Lee', 'Technician', 48000, 1);

SELECT Branch_no, COUNT(*) AS Employee_Count FROM Employee GROUP BY Branch_no HAVING COUNT(*) > 5;

-- 11. Retrieve the names of employees who manage branches and their respective branch addresses.

SELECT Employee.Emp_name, Branch.Branch_address FROM Employee
JOIN Branch ON Employee.Emp_Id = Branch.Manager_Id;

-- 12. Display the names of customers who have issued books with a rental price higher than Rs. 25.

SELECT DISTINCT Customer.Customer_name FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Books.Rental_Price > 25;


