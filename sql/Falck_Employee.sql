-- Author: Ran Wang --
-- Date: 2020.08.03 --
-- Description: self-referencing, Breadcrumbs--

--create table #tEmployeeList(
--EmployeeId int,
--EmployeeName nvarchar(250),
--EmployeeTitle nvarchar(250),
--ManagerId int
--)

--insert into #tEmployeeList(EmployeeId, EmployeeName, EmployeeTitle, ManagerId)
--select 1 as EmployeeId, N'John T.' as EmployeeName, N'Director of American Office' as EmployeeTitle, null as ManagerId
--union 
--select 2 as EmployeeId, N'George F.' as EmployeeName, N'Manager' as EmployeeTitle, 1 as ManagerId
--union 
--select 3 as EmployeeId, N'Elliot S.' as EmployeeName, N'Driver' as EmployeeTitle, 2 as ManagerId
--union
--select 11 as EmployeeId, N'Anna K.' as EmployeeName, N'Director of European Office' as EmployeeTitle, null as ManagerId
--union 
--select 12 as EmployeeId, N'Elsa F.' as EmployeeName, N'Senior Manager' as EmployeeTitle, 11 as ManagerId
--union 
--select 13 as EmployeeId, N'Olaf S.' as EmployeeName, N'Snowman' as EmployeeTitle, 12 as ManagerId
--union
--select 21 as EmployeeId, N'Tom K.' as EmployeeName, N'Cat in European Office' as EmployeeTitle, 11 as ManagerId
--union 
--select 22 as EmployeeId, N'Kristoff I.' as EmployeeName, N'Ice Manager' as EmployeeTitle, 21 as ManagerId
--union 
--select 23 as EmployeeId, N'Troll K.' as EmployeeName, N'Stone Manager' as EmployeeTitle, 22 as ManagerId;

--select 
--checksum(EmployeeName)
--,*
--from 
--#tEmployeeList

with _b as (
select
distinct
e. EmployeeId,
e. EmployeeName,
e.EmployeeTitle ,
isnull(m.EmployeeId,null)  as   ManagerId,
isnull(m. EmployeeName, null) as ManagerName,
min(e.EmployeeId) over(partition by len(e.EmployeeId)) as DirectorId,
first_value(e.EmployeeName) over(partition by len(e.EmployeeId) order by len(e.EmployeeId)) as Directorname
FROM
     #tEmployeeList e
LEFT JOIN  #tEmployeeList m ON m. EmployeeId = e. ManagerId 
),

_a as (
select
e.EmployeeId,
e.EmployeeName,
e.EmployeeTitle,
e.ManagerId,
e.ManagerName,
e. DirectorId,
e. Directorname,
cast(e.EmployeeName as nvarchar(max)) as Breadcrumb
--concat(lag(Breadcrumb) over(partition by len(e.EmployeeId) order by len(e.EmployeeId)), '| ', e.EmployeeName)  as Breadcrumb
FROM
     _b e
	 where e.EmployeeId in (1,11)

union all

select
_b.EmployeeId,
_b.EmployeeName,
_b.EmployeeTitle,
_b.ManagerId,
_b.ManagerName,
_b. DirectorId,
_b. Directorname,
concat(_a.Breadcrumb, '| ', _b.EmployeeName)  as Breadcrumb
FROM
     _b  join _a on _a.EmployeeId = _b.ManagerId
)
select 
EmployeeId,
EmployeeName,
EmployeeTitle,
isnull(ManagerId,EmployeeId) as ManagerId,
isnull(ManagerName,EmployeeName) asManagerName,
 DirectorId,
 Directorname,
 Breadcrumb
from _a
order by _a.EmployeeId


--select
--distinct
--e. EmployeeId,
--e. EmployeeName,
--isnull(m.EmployeeId,e. EmployeeId)  as   ManagerId,
--isnull(m. EmployeeName, e. EmployeeName) as ManagerName,
--min(e.EmployeeId) over(partition by len(e.EmployeeId)) as DirectorId,
--first_value(e.EmployeeName) over(partition by len(e.EmployeeId) order by len(e.EmployeeId)) as Directorname
--FROM
--     #tEmployeeList e
--LEFT JOIN  #tEmployeeList m ON m. EmployeeId = e. ManagerId 

--ORDER BY
--    e.EmployeeId;

