USE [RANK1]
GO

IF OBJECT_ID('dbo.Get_Table_Detail','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[Get_Table_Detail];
END
GO

CREATE PROCEDURE [dbo].[Get_Table_Detail]
@TableName NVARCHAR(500)
AS
BEGIN	
	DECLARE @sqlCommand varchar(1000)
	DECLARE @columnList varchar(75)
	DECLARE @city varchar(75)
	--SET @columnList = 'CustomerID, ContactName, City'
	SET @sqlCommand = 'SELECT * FROM ' + @TableName
	EXEC (@sqlCommand)
END