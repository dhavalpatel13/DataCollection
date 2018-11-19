USE [RANK1]
GO

IF NOT EXISTS (SELECT TOP 1 1 FROM [dbo].[MenuIDs] WHERE MenuID='TPDEPT')
BEGIN
	INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl]) 
	VALUES (N'TPDEPT', N'TP FORM', N'/Forms/TPDEPTForm');
END
GO

update [dbo].[MenuIDs] set [MenuUrl] = N'/Forms/TPDEPTForm' where  MenuID='TPDEPT';
GO