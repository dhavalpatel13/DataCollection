USE [RANK]
GO
/****** Object:  StoredProcedure [dbo].[GET_CURRENT_USER_MENU]    Script Date: 9/26/2018 8:21:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GET_RANK_INFO_MSG]		
AS
	SELECT TOP 1 * FROM RankMesg

	Update RankMesg set Message = 'Testing ' 
	'No messages at the moment.'

	select  * from RankUsers