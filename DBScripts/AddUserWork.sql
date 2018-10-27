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
			 VALUES ('DEANADSRIC' ,'MTIzNDU2' ,'788457' ,'Krishna2' ,'admin' ,'User' ,'ADSRIC' ,'1234567890' ,'Testing@testing.com' ,'Y' ,GETDATE() ,null ,'' ,1 ,NEWID() ,null)
	END

	IF NOT EXISTS (select 1 from RankUsers where UserWork = 'DSRIC')
	BEGIN
		INSERT INTO [dbo].[RankUsers] ([UserID] ,[UserPassword] ,[UserEmpNo] ,[UserName] ,[DeptID] ,[UserRole] ,[UserWork] ,[UserMob] ,[UserEmail] ,[UserValid] ,[UserCreatedOn] ,[UserDisabledOn] ,[UserRemarks] ,[IsEmailVerified] ,[ActivationCode] ,[ResetPasswordCode])
			 VALUES ('DEANDSRIC' ,'MTIzNDU2' ,'788459' ,'Krishna3' ,'admin' ,'User' ,'DSRIC' ,'1234567890' ,'Testing1@testing1.com' ,'Y' ,GETDATE() ,null ,'' ,1 ,NEWID() ,null)
	END

	IF NOT EXISTS (SELECT 1 FROM UserMenu WHERE UserID = 'DEANADSRIC')
	BEGIN
		INSERT INTO [dbo].[UserMenu] ([UserID] ,[MenuID]) VALUES ('DEANADSRIC' ,'All')
	END
	IF NOT EXISTS (SELECT 1 FROM UserMenu WHERE UserID = 'DEANDSRIC')
	BEGIN
		INSERT INTO [dbo].[UserMenu] ([UserID] ,[MenuID]) VALUES ('DEANDSRIC' ,'All')
	END

GO