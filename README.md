# LIBRARY MANAGEMENT SYSTEM (SQL CAPSTONE PROJECT)

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



