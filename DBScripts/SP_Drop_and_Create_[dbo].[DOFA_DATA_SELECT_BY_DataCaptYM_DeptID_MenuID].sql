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
	@DeptID nvarchar(10),
	@empDept nvarchar(10) = ''
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
	,info.empNo
	,info.empName
	,(CASE WHEN info.empDOB is NULL then '' ELSE REPLACE(CONVERT(NVARCHAR,CAST(info.empDOB AS DATETIME), 106), ' ', '-') END) as empDOB
	,(CASE WHEN info.empDOJ is NULL then '' ELSE REPLACE(CONVERT(NVARCHAR,CAST(info.empDOJ AS DATETIME), 106), ' ', '-') END) as empDOJ
	,(CASE WHEN info.empDOL is NULL then '' ELSE REPLACE(CONVERT(NVARCHAR,CAST(info.empDOL AS DATETIME), 106), ' ', '-') END) as empDOL
	,info.empGender
	,info.empDESG
	,info.empDEPT
	,info.empPAN
	,info.empType
	,info.empCat
	,info.empNation
	,info.QualHighYear
	,info.QualHighCourse
	,info.QualHighInst
	,info.ExpAcadMon
	,info.ExpIndMon
	,info.FacExcgIn
	,info.FacExcgOut
	,info.ConfSymSemNat
	,info.ConfSymSemInt
	,info.AwardHonors
	,ds.Details as DataStatusName
	,dp.DeptName as DeptName 
	FROM dofaInfo as info
	INNER JOIN DataStatus as ds on info.DataStatus = ds.DataStatus
	INNER JOIN Depts as dp on info.empDEPT = dp.DeptID
	WHERE DataCaptYM = @DataCaptYM AND info.DeptID = @DeptID 
	AND (ISNULL(@empDept,'') = '' OR info.empDEPT = @empDept) AND MenuID = 'DOFA'
END

GO
