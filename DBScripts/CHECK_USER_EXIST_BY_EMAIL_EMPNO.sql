/***********************************************************************************************************************
Date		: 23-Sept-2018
*********************************************************************************************************************/

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[GET_LOGIN_USER]','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[GET_LOGIN_USER]
END
GO

CREATE PROCEDURE [dbo].[GET_LOGIN_USER]
	@UserName nvarchar(20),
	@UserPassword nvarchar(20)
AS
	SELECT * FROM RankUsers WHERE UserName = @UserName And UserPassword = @UserPassword
GO

