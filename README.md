# Falck_test

## BI Developer test TSQL Exercises

### Contents

[Exercise 1](#Exercise 1)<br/>
[Exercise 2](#Exercise 2)<br/>
[Exercise 3](#Exercise 3)<br/>


**Exercise 1.**

Table Employee has the following columns: **EmployeeId, EmployeeName, EmployeeTitle, ManagerId**. Column ManagerId represents self-referencing relationship between Manager and Employee.

Table looks following.


![Alt text](/pic/1.1.png "Employee 1")

Task. Please write a query in **T-SQL** that returns the following columns:
**EmployeeId, EmployeeName, EmployeeTitle, ManagerId, ManagerName, DirectorName** (Employee who does not have Manager), Position Breadcrumbs (concatenation of Employee's Name and names of all his/her managers). Example bellow.

![Alt text](/pic/1.2.png "Employee 2")

Result:
check sql script in: - [Falck Employee](/sql/Falck_Employee.sql) 

![Alt text](/pic/1.3.PNG "Employee 3")


**Exercise 2.** 
Table **Salary** has the following columns: Calendar Date, Employee, Department, Salary.
Table Salary:

![Alt text](/pic/2.1.png "Salary 1")

Task. Please write a query in **T-SQL** that returns the following columns:
Calendar Date, Employee, Department, Salary, First Employee's Salary by Date, Employee Salary from previous period, Employee Salary from following period, Summarized Salary from all Department, Cumulative Sum of Departments Salary

![Alt text](/pic/2.1.png "Salary 2")

Result:
check sql script in: - [Falck Salary](/sql/Falck_Salary.sql) 

![Alt text](/pic/2.3.PNG "Salary 3")


**Exercise 3.**
Let say you are responsible for implementing T-SQL code for daily load of Dimension Employee.
Incremental load occurs every day and load delta changes into table Staging.Employee. Table Staging.Employee has following columns: EmployeeId, EmployeeName, EmployeeTitle, ManagerId, SalaryNumber.
Task. Please write code in **T-SQL** that mimic process of loading Dimension Employee with following technical specification.
Target Datawarehouse table has name Dimension.Employee and has unique key.
Attributes of the dimension must meet following requirements:
•	**Employee Id** - Business key from Source System
•	**Employee Name** - Keep only the last value for all historical records (SCD Type I)
•	**Employee Title** - track history (SCD Type II). Every change is represented as a new record.
•	**Manager Id** - track history (SCD Type II). Every change is represented as a new record.
•	**Salary Number** - do not keep history, it persists only the firstly added value (SCD Type 0)
Everything else depends on your imagination.

Result:
check sql script in: - [Falck Delta Merger Employee](/sql/Falck_DeltaMerger_Employee.sql) 
