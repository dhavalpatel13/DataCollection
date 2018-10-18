/***********************************************************************************************************************
Date		: 21-Sept-2018
*********************************************************************************************************************/

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[UPDATE_RANK_USER]','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[UPDATE_RANK_USER]
END
GO

CREATE PROCEDURE [dbo].[UPDATE_RANK_USER]
	@UserID nvarchar(20),
	@UserEmpNo nvarchar(10),
	@UserName nvarchar(50),
	@UserPassword nvarchar(500),	
	@UserMob nvarchar(10),
	@UserEmail nvarchar(50),
	@UserValid char(1),
	@DeptID nvarchar(10),
	@UserRole nvarchar(10),
	@UserWork nvarchar(10)
AS
	DECLARE @UserCreatedOn datetime = GETDATE()
	DECLARE @UserDisabledOn datetime = GETDATE()

	UPDATE [dbo].[RankUsers] 
	SET UserEmpNo = @UserEmpNo,
		UserName = @UserName,
		UserPassword = @UserPassword,
		UserMob = @UserMob,
		UserEmail = @UserEmail,
		UserValid = @UserValid,
		DeptID = @DeptID,
		UserRole = @UserRole,
		UserWork = @UserWork,
		UserDisabledOn = (CASE WHEN @UserValid = 'N'
							   THEN @UserDisabledOn 
							   ELSE NULL END)
	WHERE UserID = @UserID

    
GO
