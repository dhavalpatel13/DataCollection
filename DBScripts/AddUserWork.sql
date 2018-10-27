USE [RANK]
GO
	IF NOT EXISTS (select 1 from UserWork where UserWork = 'ADSRIC')
	BEGIN
		INSERT INTO UserWork VALUES ('ADSRIC','Asscociate Dean SRIC')
	END

	IF NOT EXISTS (select 1 from UserWork where UserWork = 'DSRIC')
	BEGIN
		INSERT INTO UserWork VALUES ('DSRIC','Dean SRIC')
	END

	IF NOT EXISTS (select 1 from RankUsers where UserWork = 'ADSRIC')
	BEGIN
		INSERT INTO [dbo].[RankUsers] ([UserID] ,[UserPassword] ,[UserEmpNo] ,[UserName] ,[DeptID] ,[UserRole] ,[UserWork] ,[UserMob] ,[UserEmail] ,[UserValid] ,[UserCreatedOn] ,[UserDisabledOn] ,[UserRemarks] ,[IsEmailVerified] ,[ActivationCode] ,[ResetPasswordCode])
			 VALUES ('deanadsric' ,'MTIzNDU2' ,'788457' ,'Krishna2' ,'admin' ,'User' ,'ADSRIC' ,'1234567890' ,'Testing@testing.com' ,'Y' ,GETDATE() ,null ,'' ,1 ,NEWID() ,null)
	END

	IF NOT EXISTS (select 1 from RankUsers where UserWork = 'DSRIC')
	BEGIN
		INSERT INTO [dbo].[RankUsers] ([UserID] ,[UserPassword] ,[UserEmpNo] ,[UserName] ,[DeptID] ,[UserRole] ,[UserWork] ,[UserMob] ,[UserEmail] ,[UserValid] ,[UserCreatedOn] ,[UserDisabledOn] ,[UserRemarks] ,[IsEmailVerified] ,[ActivationCode] ,[ResetPasswordCode])
			 VALUES ('deandsric' ,'MTIzNDU2' ,'788459' ,'Krishna3' ,'admin' ,'User' ,'DSRIC' ,'1234567890' ,'Testing1@testing1.com' ,'Y' ,GETDATE() ,null ,'' ,1 ,NEWID() ,null)
	END

	IF NOT EXISTS (SELECT 1 FROM UserMenu WHERE UserID = 'deanadsric')
	BEGIN
		INSERT INTO [dbo].[UserMenu] ([UserID] ,[MenuID]) VALUES ('deanadsric' ,'All')
	END
	IF NOT EXISTS (SELECT 1 FROM UserMenu WHERE UserID = 'deandsric')
	BEGIN
		INSERT INTO [dbo].[UserMenu] ([UserID] ,[MenuID]) VALUES ('deandsric' ,'All')
	END

	IF NOT EXISTS (select 1 from MenuIDs where MenuID = 'TABLE')
	BEGIN
		INSERT INTO [dbo].[MenuIDs] ([MenuID] ,[MenuDetails] ,[MenuUrl] ,[IsAdminMenu])
		VALUES ('TABLE' ,'TABLE DETAIL' ,'/Admin/Table' ,1)
	END

	IF NOT EXISTS (select 1 from MenuIDs where MenuID = 'MESSAGE')
	BEGIN
		INSERT INTO [dbo].[MenuIDs] ([MenuID] ,[MenuDetails] ,[MenuUrl] ,[IsAdminMenu])
		VALUES ('MESSAGE' ,'RANK MESSAGE' ,'/Admin/RankMessage' ,1)
	END

	IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'Id'
          AND Object_ID = Object_ID(N'dbo.RankMesg'))
	BEGIN		
		ALTER TABLE RankMesg
		ADD Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY;
	END
GO