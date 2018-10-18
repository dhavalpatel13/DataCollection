/***********************************************************************************************************************
Date		: 23-Sept-2018
*********************************************************************************************************************/

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[GET_CURRENT_USER_MENU]','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[GET_CURRENT_USER_MENU]
END
GO

CREATE PROCEDURE [dbo].[GET_CURRENT_USER_MENU]	
	@UserID nvarchar(20)
AS
	Declare @UserRole Nvarchar(50)
	Select @UserRole = UserRole from RankUsers where UserID = @UserID
	
	IF(LOWER(@UserRole) = 'admin')
		SELECT * FROM MenuIDs 
	ELSE
		SELECT * FROM UserMenu WHERE UserID = @UserID
GO

