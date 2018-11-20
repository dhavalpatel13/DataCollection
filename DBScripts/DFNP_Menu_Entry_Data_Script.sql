USE [RANK1]
GO

IF NOT EXISTS (SELECT TOP 1 1 FROM [dbo].[MenuIDs] WHERE MenuID='DFNP')
BEGIN
	INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl]) 
	VALUES (N'DFNP', N'DFNP FORM', N'/Forms/DFNPForm');
END
GO

update [dbo].[MenuIDs] set [MenuUrl] = N'/Forms/DFNPForm' where  MenuID='DFNP';
GO