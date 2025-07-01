Create database Employees;
use  Employees;

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name varchar(20),
    DeptID INT,
    Salary INT
);

CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName varchar(20)
);

insert into  Employees values
(121, 'Keerthi', 1, 35000),
(122, 'Harika', 2, 28000),
(123, 'Neerja', 2, 45000),
(124, 'Mahesh', 3, 55000),
(125, 'Frank', 4, 30000),
(126, 'Grace', 4, 35000),
(127, 'Hannah', 1, 52000);


insert into  Departments values
(1, 'Finance'),
(2, 'Marketing'),
(3, 'IT'),
(4, 'HR');

/*Subquery in SELECT:*/
SELECT EmpID, Name,(SELECT DeptName FROM Departments D WHERE D.DeptID = E.DeptID) AS Department
FROM Employees E;

/*Correlated Subquery:*/
SELECT Name, Salary 
FROM Employees E 
WHERE Salary >
 (
    SELECT AVG(Salary) 
    FROM Employees 
    WHERE DeptID = E.DeptID
);

/* Subquery in FROM: */
SELECT DeptID, AVG_Salary 
FROM (
    SELECT DeptID, AVG(Salary) AS AVG_Salary 
    FROM Employees 
    GROUP BY DeptID
) AS DeptAvgs
WHERE AVG_Salary > 50000;
 
 /*Subquery with = (Scalar Subquery)*/
 SELECT * FROM Employees 
WHERE DeptID = (
    SELECT DeptID 
    FROM Departments 
    WHERE DeptName = 'Finance'
);

/*Subquery with IN (Multiple Row Subquery)*/
SELECT * FROM Employees 
WHERE DeptID IN (
    SELECT DeptID 
    FROM Departments 
    WHERE DeptName IN ('HR', 'Finance')
);

/*Subquery with EXISTS (Correlated)*/
SELECT * FROM Employees E
WHERE EXISTS (
    SELECT 1 
    FROM Departments D 
    WHERE D.DeptID = E.DeptID
);

SELECT * FROM Employees E
WHERE Salary > (
    SELECT AVG(Salary) 
    FROM Employees 
    WHERE DeptID = E.DeptID
);

/*Nested Subquery in SELECT*/
SELECT EmpID, Name, Salary,
    (SELECT DeptName 
     FROM Departments D 
     WHERE D.DeptID = E.DeptID) AS Department FROM Employees E;

