USE [RANK1]
GO

IF NOT EXISTS (SELECT TOP 1 1 FROM [dbo].[MenuIDs] WHERE MenuID='INFRA')
BEGIN
	INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl]) 
	VALUES (N'INFRA', N'INFRA FORM', N'/Forms/INFRAForm');
END
GO

update [dbo].[MenuIDs] set [MenuUrl] = N'/Forms/INFRAForm' where  MenuID='INFRA';
GO