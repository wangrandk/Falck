-- Author: Ran Wang --
-- Date: 2020.08.03 --
-- Description: Delta loading merge with type 0, I, II SCD


-- VARIABLES
DECLARE @CurrentDateTime datetime= cast(getdate() as datetime2);

merge [dim].[Employee] as [target]
using [staging].[Employee] as [source]
on (	[source].[EmployeeId] = [target].[EmployeeId])

-- ==================================================
-- SCD1
-- ==================================================
WHEN MATCHED AND
([source].[EmployeeName] <> [target].[EmployeeName] OR ([source].[EmployeeName] IS NULL AND [target].[EmployeeName] IS NOT NULL) OR ([source].[EmployeeName] IS NOT NULL AND [target].[EmployeeName] IS NULL)) 
--and
--([target].[EmployeeTitle] = [source].[EmployeeTitle]) and
-- ([target].[ManagerId] = [source].[ManagerId]
THEN UPDATE
set [target].[EmployeeName] = [source].[EmployeeName],
    [target].[UpdatedDate] = @CurrentDateTime ;
-- ==================================================
-- SCD2
-- ==================================================
INSERT INTO [dim].[CustomerPhone]
(
	    [EmployeeId], 
        [EmployeeName], 
        [EmployeeTitle], 
        [ManagerId], 
        [SalaryNumber],
		[InsertedDate],
		[UpdatedDate]
)
SELECT
	    [EmployeeId], 
        [EmployeeName], 
        [EmployeeTitle], 
        [ManagerId], 
        [SalaryNumber],
		[InsertedDate],
		[UpdatedDate]
FROM
( 
merge [dim].[Employee] as [target]
using [staging].[Employee] as [source]
on ([source].[EmployeeId] = [target].[EmployeeId] 
--and [source].[EmployeeName] <> [target].[EmployeeName] 
)
	WHEN NOT MATCHED BY TARGET
	THEN INSERT
	(
        [EmployeeId], 
        [EmployeeName], 
        [EmployeeTitle], 
        [ManagerId], 
        [SalaryNumber],
		[InsertedDate],
		[UpdatedDate]
	)
	VALUES
	(
		
        [EmployeeId], 
        [EmployeeName], 
        [EmployeeTitle], 
        [ManagerId], 
        [SalaryNumber],
		@CurrentDateTime,
		@CurrentDateTime
	)

WHEN MATCHED AND
(
	([target].[EmployeeTitle] <> [source].[EmployeeTitle] OR ([target].[EmployeeTitle] IS NULL AND [source].[EmployeeTitle] IS NOT NULL) OR ([target].[EmployeeTitle] IS NOT NULL AND [source].[EmployeeTitle] IS NULL)) or
    ([target].[ManagerId] <> [source].[ManagerId] OR ([target].[ManagerId] IS NULL AND [source].[ManagerId] IS NOT NULL) OR ([target].[ManagerId] IS NOT NULL AND [source].[ManagerId] IS NULL))
)
	THEN UPDATE
	set
         [target].[EmployeeTitle] = [source].[EmployeeTitle],
		 [target].[ManagerId] = [source].[ManagerId], 
		 [target].[UpdatedDate] = getdate()
	OUTPUT
		$Action as [MERGE_ACTION],
		[source].[EmployeeId] AS [EmployeeId],
		[source].[EmployeeName] AS [EmployeeName],		
		[source].[EmployeeTitle] AS [EmployeeTitle],
		[source].[ManagerId] AS [ManagerId],		
		[target].[SalaryNumber] AS [SalaryNumber],
		@CurrentDateTime,
		@CurrentDateTime

) MERGE_OUTPUT
WHERE MERGE_OUTPUT.[MERGE_ACTION] = 'UPDATE' 
	AND MERGE_OUTPUT.[EmployeeId] IS NOT NULL
;
END
GO



