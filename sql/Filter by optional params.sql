/*
  filter a table by a bunch of different optional parameters
  will create a new plan for each unique combo of params used, but will perform better than using (@Param1 is null or Col1 = @Param1)
*/

CREATE OR ALTER PROCEDURE dbo.Select_FilterByDiffParams
	@Param1 INT = NULL,
	@Param2 VARCHAR(50) = NULL,
	@Param3 UNIQUEIDENTIFIER = NULL
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SQL NVARCHAR(MAX),  /*the sql that we'll execute*/
		@ParamDefinition NVARCHAR(MAX) = '' /*the params that are optional*/


	/*set the base sql*/
	SET @SQL =
	'
		SELECT 
			PK_ID,
			Col1,
			Col2,
			Col3
		FROM dbo.TableToFilter
		WHERE 1 = 1
	'

	/*add optional filters*/
	if (@Param1 IS NOT NULL)
	BEGIN
		SET @SQL = @SQL + ' and Col1 = @Param1'
	END


	if (@Param2 IS NOT NULL)
	BEGIN
		SET @SQL = @SQL + ' and Col2 = @Param2'
	END


	if (@Param3 IS NOT NULL)
	BEGIN
		SET @SQL = @SQL + ' and Col3 = @Param1'
	END
	

	SET @ParamDefinition = '@Param1 INT, @Param2 VARCHAR(50), @Param3 UNIQUEIDENTIFIER'
	
	EXEC sp_executesql 
		@SQL, 
		@ParamDefinition,
		@Param1,
		@Param2,
		@Param3
end
