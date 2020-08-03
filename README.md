# Falck_test

## BI Developer test: TSQL Exercises

### Contents

[Exercise 1](#Exercise-1)<br/>
[Exercise 2](#Exercise-2)<br/>
[Exercise 3](#Exercise-3)<br/>


## Exercise 1

Table Employee has the following columns: **EmployeeId, EmployeeName, EmployeeTitle, ManagerId**. Column ManagerId represents self-referencing relationship between Manager and Employee.

Table looks following.


![Alt text](/pic/1.1.png "Employee 1")

Task. Please write a query in **T-SQL** that returns the following columns:
**EmployeeId, EmployeeName, EmployeeTitle, ManagerId, ManagerName, DirectorName** (Employee who does not have Manager), Position Breadcrumbs (concatenation of Employee's Name and names of all his/her managers). Example bellow.

![Alt text](/pic/1.2.png "Employee 2")

Result:
check sql script in: - [Falck Employee](/sql/Falck_Employee.sql) 

![Alt text](/pic/1.3.PNG "Employee 3")


## Exercise 2
Table **Salary** has the following columns: Calendar Date, Employee, Department, Salary.
Table Salary:

![Alt text](/pic/2.1.png "Salary 1")

Task. Please write a query in **T-SQL** that returns the following columns:
Calendar Date, Employee, Department, Salary, First Employee's Salary by Date, Employee Salary from previous period, Employee Salary from following period, Summarized Salary from all Department, Cumulative Sum of Departments Salary

![Alt text](/pic/2.1.png "Salary 2")

Result:
check sql script in: - [Falck Salary](/sql/Falck_Salary.sql) 

![Alt text](/pic/2.3.PNG "Salary 3")


## Exercise 3
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


## BI Developer test: Migrate Datawarehouse from On Premise setup to Cloud

### Contents
[Prerequisites](#Prerequisites)<br/>
[Goal](#Goal)<br/>
[Scenario](#Scenario)<br/>
[Goal](#Goal)<br/>
[Scenario](#Scenario)<br/>
[Results in a nutshell](#Results-in-a-nutshell)<br/>
[Possible steps](#Possible-steps)<br/>


## Prerequisites
-	SQL Server 2016+ installed 
-	Azure Subscription. If you do not have Azure Subscription, Resource Group with resources (Azure SQL, Azure Blob Storage, Azure Data Factory) they will be created for your user by us (This case should be discussed in advance). 
-	Visual Studio 2017+ installed
Approximate time for accomplishing: 1-2 hours

## Goal
migrate part of already existing data from On Premise to Cloud storage using:
-	Azure Data Factory 
-	Azure Blob Storage

## Scenario
Let say you are working as a BI Developer. Your task is to migrate data for 2 tables from legacy On Premise DB to new Cloud Solution using Microsoft Azure stack.

## Results in a nutshell
Create process for copying data from database WideWorldImportersDW for tables Dimension.Customer, Fact.Sale from On Premise database to Azure SQL database using Azure data Factory. As an intermediate step load data into Azure Blob Storage. Everything else depends on your imagination.
## Possible steps
1.	Restore On Premise database WideWorldImportersDW on local SQL Server. 
    Links where to get .bak file:
	  https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-dw-install-configure?view=sql-server-ver15
	  https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0
	 ![Alt text](/pic/3.1.png "Restore On Premise database") 
1.	Deploy WideWorldImportersDW to Azure SQL DB (Publishing to Azure SQL Database). 
    Link where to get source code:
    https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers/wwi-dw-ssdt#publishing-to-azure-sql-database 
    ![Alt text](/pic/3.2.png "Publishing to Azure SQL Database: VS") 
    ![Alt text](/pic/3.3.png "Publishing to Azure SQL Database: AZURE Portal") 
1.	Create 2 (for 2 tables) Azure Data Factory Pipelines with at least two activities:<br/>
    - Copy data activity for exporting data from On Premise DB to Blob Storage.
    - Copy data activity for loading data from blob storage to Azure SQl DB.
    Result: Pipeline for **Dimension.Customer**
    ![Alt text](/pic/3.4.png "ADF Pipeline 1") 
    ![Alt text](/pic/3.5.png "Azure blob storage 1") 
    ![Alt text](/pic/3.6.png "SSMS 1") 
    
     Result: Pipeline for **Fact.Sale**
    ![Alt text](/pic/3.7.png "ADF Pipeline 2") 
    ![Alt text](/pic/3.8.png "Azure blob storage 2") 
    ![Alt text](/pic/3.9.png "SSMS 2") 
1.	Copy data from On premise to Cloud
1.	Submit results, present work and relax 😊

