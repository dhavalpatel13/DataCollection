USE [RANK]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.DOFA_DATA_SELECT_BY_DataCaptYM_DeptID_MenuID','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[DOFA_DATA_SELECT_BY_DataCaptYM_DeptID_MenuID];
END
GO

CREATE PROCEDURE [dbo].[DOFA_DATA_SELECT_BY_DataCaptYM_DeptID_MenuID]
	@DataCaptYM int,
	@DeptID nvarchar(10)
AS
BEGIN
	SELECT info.*, ds.Details as DataStatusName, dp.DeptName as DeptName FROM dofaInfo as info
		Inner join DataStatus as ds on info.DataStatus = ds.DataStatus
		inner join Depts as dp on info.DeptID = dp.DeptID
		WHERE DataCaptYM = @DataCaptYM AND info.DeptID = @DeptID AND MenuID = 'DOFA'
END

GO
