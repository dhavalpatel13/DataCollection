/***********************************************************************************************************************
Date		: 21-Sept-2018
*********************************************************************************************************************/

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[DOAA1_INFO_SELECT_BY_DataCaptYM_DeptID_MenuID]','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[DOAA1_INFO_SELECT_BY_DataCaptYM_DeptID_MenuID]
END
GO

CREATE PROCEDURE [dbo].[DOAA1_INFO_SELECT_BY_DataCaptYM_DeptID_MenuID]
	@DataCaptYM int,
	@DeptID nvarchar(10),
	@MenuID nvarchar(10) = 'DOAA'
AS
BEGIN
	IF @MenuID = 'DOAA'
	BEGIN
		SELECT info.*, ds.Details as DataStatusName, dp.DeptName as DeptName FROM stInfo as info
		Inner join DataStatus as ds on info.DataStatus = ds.DataStatus
		inner join Depts as dp on info.DeptID = dp.DeptID
		WHERE DataCaptYM = @DataCaptYM AND info.DeptID = @DeptID AND MenuID = @MenuID
	END
	ELSE IF (@MenuID = 'ADIR' OR @MenuID = 'DOSW')
	BEGIN
		SELECT info2.*, ds.Details as DataStatusName, dp.DeptName as DeptName FROM stInfo2 as info2
		Inner join DataStatus as ds on info2.DataStatus = ds.DataStatus
		inner join Depts as dp on info2.DeptID = dp.DeptID
		WHERE DataCaptYM = @DataCaptYM AND info2.DeptID = @DeptID AND MenuID = @MenuID	
	END
	ELSE IF(@MenuID = 'LIBFORM')
	BEGIN
		SELECT LibInfo.*, ds.Details as DataStatusName, dp.DeptName as DeptName FROM LibInfo 
		Inner join DataStatus as ds on LibInfo.DataStatus = ds.DataStatus
		inner join Depts as dp on LibInfo.DeptID = dp.DeptID
		WHERE DataCaptYM = @DataCaptYM AND LibInfo.DeptID = @DeptID AND MenuID = @MenuID
	END
END
GO

