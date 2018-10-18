/***********************************************************************************************************************
Date		: 23-Sept-2018
*********************************************************************************************************************/

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[CHECK_USER_EXIST_BY_EMAIL_EMPNO]','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[CHECK_USER_EXIST_BY_EMAIL_EMPNO]
END
GO

CREATE PROCEDURE [dbo].[CHECK_USER_EXIST_BY_EMAIL_EMPNO]
	@UserEmail nvarchar(50),
	@UserEmpNo nvarchar(10), 
	@UserID nvarchar(20),
	@UserMob nvarchar(10)
AS

	Set @UserEmail = ''
	Set @UserMob = ''

	If (EXISTS(SELECT 1 FROM RankUsers WHERE UserEmail = @UserEmail))
	BEGIN
	   select 1 --Email exists
	END
	ELSE IF (EXISTS(SELECT 1 FROM RankUsers WHERE UserEmpNo = @UserEmpNo))
	BEGIN
	   select 2 --Emp no exists
	END	
	ELSE IF (EXISTS(SELECT 1 FROM RankUsers WHERE UserID = @UserID))
	BEGIN
	   select 3 --UserId already exists
	END	
	ELSE IF (EXISTS(SELECT 1 FROM RankUsers WHERE UserMob = @UserMob))
	BEGIN
	   select 4 --Mobile Number already exists
	END	
	ELSE
	BEGIN
		select -1 --User Not Exists
	END
GO

