USE [RANK]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.SRIC_DEPT_DATA_SELECT_BY_DataCaptYM','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[SRIC_DEPT_DATA_SELECT_BY_DataCaptYM];
END
GO

CREATE PROCEDURE [dbo].[SRIC_DEPT_DATA_SELECT_BY_DataCaptYM]
	@DataCaptYM int
AS
BEGIN
	SELECT ISNULL(sr.IDNo, 0) as IDNo ,ISNULL(sr.DataCaptYM, @DataCaptYM) as DataCaptYM
	,d.DeptID, d.DeptName, ISNULL(sr.MenuID,'SRIC') as MenuID
	,sr.DataUser,sr.DataUpdatedOn, sr.DataStatus, ds.Details as DataStatusName, sr.DataStatusLog, sr.DataValid, sr.DataLocked
	,sr.SRProjQty, sr.SRFAQty, sr.SRProjOutlay, sr.SRProjRcp -- block 1
	,sr.ICProjQty, sr.ICFAQty, sr.ICProjOutlay, sr.ICProjRcp -- block 2
	,sr.ConfSSNat, sr.ConfSSNatExp, sr.ConfSSInt, sr.ConfSSIntExp -- block 3
	,sr.IPRFiled, sr.IPRPub, sr.IPRGranted, sr.IPRLicensed -- block 4
	,sr.TechXferFiled, sr.TechXferPub, sr.TechXferGranted, sr.TechXferLicensed -- block 5
	,sr.CopyRightsFiled, sr.CopyRightsPub, sr.CopyRightsGranted, sr.CopyRightsLicensed -- block 6
	,sr.LogoDesignFiled, sr.LogoDesignPub, sr.LogoDesignGranted, sr.LogoDesignLicensed -- block 7
	FROM Depts d
	LEFT JOIN sricDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
	left JOIN DataStatus as ds on sr.DataStatus = ds.DataStatus
	WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
	ORDER BY DeptName;
END

GO
