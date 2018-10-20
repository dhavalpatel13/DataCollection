USE [RANK]
GO

IF NOT EXISTS (SELECT TOP 1 1 FROM [dbo].[MenuIDs] WHERE MenuID='REPORTS')
BEGIN
	INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl]) 
	VALUES (N'REPORTS', N'Reports Form', N'/Forms/ReportsForm');
END
GO
