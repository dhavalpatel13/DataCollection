USE [RANK]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.SricFA_DATA_SELECT_BY_DataCaptYM_DeptID','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[SricFA_DATA_SELECT_BY_DataCaptYM_DeptID];
END
GO

CREATE PROCEDURE [dbo].[SricFA_DATA_SELECT_BY_DataCaptYM_DeptID]
	@DataCaptYM int,
	@DeptID nvarchar(10)
AS
BEGIN
	SELECT 
	info.IDNo
	,info.DataCaptYM
	,info.DeptID
	,info.MenuID
	,info.DataUser
	,info.DataUpdatedOn
	,info.DataStatus
	,info.DataStatusLog
	,info.DataValid
	,info.DataLocked
	,info.FAName
	,info.FASRProjQty
	,info.FASRProjOutlay
	,info.FASRProjRcp
	,info.FAICProjQty
	,info.FAICProjOutlay
	,info.FAICProjRcp
	,info.ResStaffNPDF
	,info.ResStaffPC
	,info.ResStaffPF
	,info.ResStaffRFSR
	,info.ResStaffRA
	,ds.Details as DataStatusName
	,dp.DeptName as DeptName 
	FROM sricFA as info
	Inner join DataStatus as ds on info.DataStatus = ds.DataStatus
	inner join Depts as dp on info.DeptID = dp.DeptID
	WHERE DataCaptYM = @DataCaptYM AND info.DeptID = @DeptID AND MenuID = 'SRICFA'
END

GO
