USE [RANK]
GO

IF NOT EXISTS (SELECT TOP 1 1 FROM [dbo].[MenuIDs] WHERE MenuID='REPORTS')
BEGIN
	INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl]) 
	VALUES (N'REPORTS', N'REPORTS FORM', N'/Forms/ReportsForm');

	ALTER TABLE MenuIDs ADD IsAdminMenu BIT DEFAULT(0);
	UPDATE MenuIDs SET IsAdminMenu = 0
	UPDATE MenuIDs SET IsAdminMenu = 1 WHERE MenuID in ('REPORTS','USERS')
END
GO

