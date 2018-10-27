USE [RANK1]
GO

IF OBJECT_ID('dbo.Get_All_Table','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[Get_All_Table];
END
GO

CREATE PROCEDURE [dbo].[Get_All_Table]
AS
BEGIN	
	select Name from sys.tables	
END