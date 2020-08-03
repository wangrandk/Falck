-- Author: Ran Wang --
-- Date: 2020.08.03 --
-- Description: running sum, window functions--

--create table #tSalary(
--CalendarDate date,
--Employee nvarchar(250),
--Department nvarchar(250),
--Salary numeric(18, 2)
--)

--insert into #tSalary(CalendarDate, Employee, Department, Salary)
--select '20190101' as CalendarDate, N'Employee #1' as Employee, N'Sales' as Department, 1000 as Salary  
--union
--select '20190201' as CalendarDate, N'Employee #1' as Employee, N'Sales' as Department, 1200 as Salary  
--union
--select '20190301' as CalendarDate, N'Employee #1' as Employee, N'Sales' as Department, 1500 as Salary  
--union
--select '20190401' as CalendarDate, N'Employee #1' as Employee, N'Sales' as Department, 1700 as Salary 
--union
--select '20190101' as CalendarDate, N'Employee #2' as Employee, N'Sales' as Department, 2000 as Salary  
--union
--select '20190201' as CalendarDate, N'Employee #2' as Employee, N'Sales' as Department, 2200 as Salary  
--union
--select '20190301' as CalendarDate, N'Employee #2' as Employee, N'Sales' as Department, 2500 as Salary
--union
--select '20190401' as CalendarDate, N'Employee #2' as Employee, N'Sales' as Department, 2700 as Salary 
--union
--select '20190101' as CalendarDate, N'Employee #3' as Employee, N'Marketing' as Department, 3000 as Salary  
--union
--select '20190201' as CalendarDate, N'Employee #3' as Employee, N'Marketing' as Department, 3200 as Salary  
--union
--select '20190301' as CalendarDate, N'Employee #3' as Employee, N'Marketing' as Department, 3500 as Salary
--union
--select '20190401' as CalendarDate, N'Employee #3' as Employee, N'Marketing' as Department, 3700 as Salary


with _a as(
select 
CalendarDate 
,Employee     
,Department   
,Salary
,FirstSalary = first_value(salary) over (partition by Employee,Department order by CalendarDate)
,PreviousSalary = lag(salary,1) over (partition by Employee order by CalendarDate)
,NextSalary = lead(salary,1) over (partition by Employee order by CalendarDate)
,SumOfDepartmentSalary = sum(salary) over (partition by CalendarDate, Department)
from 
#tSalary
)
select 
*
,CumulativeValueOfDepartmentSalary = sum(SumOfDepartMentSalary) over (partition by Employee order by CalendarDate)
from _a
CumulativeValueOfDepartmentSalary
order by Employee, CalendarDate