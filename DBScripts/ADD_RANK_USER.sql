/***********************************************************************************************************************
Date		: 21-Sept-2018
*********************************************************************************************************************/

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[ADD_RANK_USER]','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[ADD_RANK_USER]
END
GO

CREATE PROCEDURE [dbo].[ADD_RANK_USER]
	@UserID nvarchar(20),
	@UserEmpNo nvarchar(10),
	@UserName nvarchar(50),
	@UserPassword nvarchar(500),		
	@UserMob nvarchar(10),
	@UserEmail nvarchar(50),
	@UserValid char(1),
	@UserRemarks nvarchar(100),
	@DeptID nvarchar(10),
	@UserWork nvarchar(10),
	@UserRole nvarchar(10),
	@IsEmailVerified bit,
	@ActivationCode UniqueIdentifier
AS
	DECLARE @UserCreatedOn datetime = GETDATE()
    
	INSERT INTO [dbo].[RankUsers]
           (UserID,
		    UserEmpNo,
			UserName,
			UserPassword,	
			UserMob,
			UserEmail,
			UserValid,
			UserRemarks,
			DeptID,
			UserWork,
			UserRole,
			IsEmailVerified,
			ActivationCode,
			UserCreatedOn)
     VALUES
           (@UserID,
			@UserEmpNo,
			@UserName,
			@UserPassword,	
			@UserMob,
			@UserEmail,
			@UserValid,
			@UserRemarks,
			@DeptID,
			@UserWork,
			@UserRole,
			@IsEmailVerified,
			@ActivationCode,
			@UserCreatedOn)

    SELECT  @UserID = SCOPE_IDENTITY()   
    SELECT  @UserID              
GO

