# LIBRARY MANAGEMENT SYSTEM (SQL CAPSTONE PROJECT)

📚 Introduction

This project is a Library Management System designed using MySQL. It helps track books, employees, branches, and customer transactions such as book issues and returns. The system ensures easy management of a library's inventory and users.

🏛 Database Schema

The project consists of six tables:

Branch - Stores branch details.

Employee - Stores information about library employees.

Books - Contains details of available books.

Customer - Stores customer registration information.

IssueStatus - Tracks issued books.

ReturnStatus - Tracks returned books.




## SQL SCRIPT


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

![image](https://github.com/user-attachments/assets/bbd12728-89bd-4831-80e1-66b6c6062bdf)

INSERT INTO Employee VALUES (101, 'John Doe', 'Manager', 60000, 1);
INSERT INTO Employee VALUES (102, 'Jane Smith', 'Clerk', 45000, 2);
SELECT * FROM Employee;

![image](https://github.com/user-attachments/assets/5411c621-69e2-49cf-a23b-64c2da22d83f)

INSERT INTO Books VALUES ('978-3-16-148410-0', 'History of Time', 'Science', 30, 'yes', 'Stephen Hawking', 'ABC Publishing');
INSERT INTO Books VALUES ('978-1-4028-9462-6', 'Learn SQL', 'Education', 25, 'no', 'John Doe', 'XYZ Press');
SELECT * FROM Books;

![image](https://github.com/user-attachments/assets/ec6eb687-b2cd-4dda-897d-fbb60c962ba4)

INSERT INTO Customer VALUES (201, 'Alice Brown', '5th Ave, NY', '2021-12-15');
INSERT INTO Customer VALUES (202, 'Bob White', 'Sunset Blvd, LA', '2023-06-10');

SELECT * FROM Customer;

![image](https://github.com/user-attachments/assets/4a2cf48a-8002-45f3-af3f-e981d670c0f7)

INSERT INTO IssueStatus VALUES (301, 201, 'History of Time', '2023-06-15', '978-3-16-148410-0');
INSERT INTO IssueStatus VALUES (302, 202, 'Learn SQL', '2023-07-01', '978-1-4028-9462-6');

SELECT * FROM IssueStatus;

![image](https://github.com/user-attachments/assets/688e3730-72f6-44c0-890b-79750e460b36)


INSERT INTO ReturnStatus VALUES (401, 201, 'History of Time', '2023-07-10', '978-3-16-148410-0');
INSERT INTO ReturnStatus VALUES (402, 202, 'Learn SQL', '2023-08-01', '978-1-4028-9462-6');

SELECT * FROM ReturnStatus;

![image](https://github.com/user-attachments/assets/127c2f38-f86b-46b7-93e9-5f7adebbb875)


# -- QUERIES

-- 1.Retrieve the book title, category, and rental price of all available books. 

SELECT Book_title,Category,Rental_Price FROM Books WHERE Status='Yes';

![image](https://github.com/user-attachments/assets/6021113d-114f-4ba0-bc69-6a1aaa131e04)


-- 2. List the employee names and their respective salaries in descending order of salary

 SELECT Emp_name,Salary FROM Employee ORDER BY Salary DESC;

 ![image](https://github.com/user-attachments/assets/bfa5f003-a71b-4652-be33-2fd9efbebe24)


 -- 3. Retrieve the book titles and the corresponding customers who have issued those books.

 SELECT Books.Book_title,Customer.customer_name FROM IssueStatus
 
 JOIN Books ON IssueStatus.Isbn_book=BOOKS.ISBN
 
 JOIN Customer ON IssueStatus.Issued_cust=Customer.customer_id;

 ![image](https://github.com/user-attachments/assets/e7dae580-6edb-4611-973b-f713909f0690)
 

 -- 4. Display the total count of books in each category.

  SELECT category,count(*) AS Total_CatergorywiseCounts FROM Books GROUP BY Category;

  ![image](https://github.com/user-attachments/assets/6cac67f8-c2ea-4b18-925b-d2f12206f45a)
  

  -- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.

SELECT Emp_name,position FROM Employee where salary>50000;

![image](https://github.com/user-attachments/assets/d190644b-154a-42af-b183-462e9b11350a)


-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.

 INSERT INTO Customer VALUES (203, 'Reggi Brown', '5th Ave, NY', '2021-11-15');
 
 SELECT Customer_name FROM Customer WHERE Reg_date < '2022-01-01' AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

 ![image](https://github.com/user-attachments/assets/7733fac9-5e1e-4da0-a5ea-2454cb5b7ddd)


  -- 7. Display the branch numbers and the total count of employees in each branch.
 
SELECT Branch_no, COUNT(*) AS Employee_Count FROM Employee GROUP BY Branch_no;

![image](https://github.com/user-attachments/assets/d7c254de-86e8-49f5-b7ce-de8f7e87796e)

-- 8. Display the names of customers who have issued books in the month of June 2023.

SELECT DISTINCT Customer.Customer_name FROM IssueStatus

JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id

WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

![image](https://github.com/user-attachments/assets/b059fb1b-61f0-4916-b659-e032594149a7)

-- 9. Retrieve book_title from book table containing history.

SELECT Book_title FROM Books WHERE Book_title LIKE '%history%';

![image](https://github.com/user-attachments/assets/118c6077-04a9-44ac-a505-31f2f554efbc)

-- 10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.


INSERT INTO Employee VALUES (103, 'Emily Johnson', 'Assistant', 40000, 1),(104, 'Michael Brown', 'Librarian', 55000, 1),
(105, 'David Wilson', 'Staff', 35000, 1),(106, 'Sophia Miller', 'Clerk', 30000, 1),(107, 'Daniel Lee', 'Technician', 48000, 1);

SELECT Branch_no, COUNT(*) AS Employee_Count FROM Employee GROUP BY Branch_no HAVING COUNT(*) > 5;

![image](https://github.com/user-attachments/assets/9323d97a-15b1-41d1-bd2d-8ec85ec6bcd5)


-- 11. Retrieve the names of employees who manage branches and their respective branch addresses.

SELECT Employee.Emp_name, Branch.Branch_address FROM Employee

JOIN Branch ON Employee.Emp_Id = Branch.Manager_Id;


![image](https://github.com/user-attachments/assets/67cf8b3b-352b-41ba-9e8b-db86ba15e119)


-- 12. Display the names of customers who have issued books with a rental price higher than Rs. 25.

SELECT DISTINCT Customer.Customer_name FROM IssueStatus

JOIN Books ON IssueStatus.Isbn_book = Books.ISBN

JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id

WHERE Books.Rental_Price > 25;

![image](https://github.com/user-attachments/assets/068abe62-b19a-4665-9e2c-cac395a4af20)



🚀 How to Run

Install MySQL Server.

Open MySQL Workbench or any SQL client.

Copy and paste the SQL script (library_management.sql).

Execute the script to create the database and tables.

Run queries to interact with the database.


📌 Future Enhancements

Add user authentication for admin and customers.

Implement book reservation and overdue tracking.

Develop a front-end UI for easy interaction.

🎯 Conclusion

This Library Management System efficiently manages books, customers, and transactions. It is an essential tool for any library to keep track of inventory and user interactions. Feel free to contribute and enhance the project! 🚀



 

 


