USE [RANK1]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.TP_DEPT_DATA_SELECT_BY_DataCaptYM','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[TP_DEPT_DATA_SELECT_BY_DataCaptYM];
END
GO

CREATE PROCEDURE [dbo].[TP_DEPT_DATA_SELECT_BY_DataCaptYM]
	@DataCaptYM int
AS
BEGIN
	SELECT ISNULL(sr.IDNo, 0) as IDNo ,ISNULL(sr.DataCaptYM, @DataCaptYM) as DataCaptYM
	,d.DeptID, d.DeptName, ISNULL(sr.MenuID,'TPDEPT') as MenuID
	,sr.DataUser,sr.DataUpdatedOn, sr.DataStatus, ds.Details as DataStatusName
	,sr.DataStatusLog, sr.DataValid, sr.DataLocked
	,StRegUGFT,StOfferUGFT,StHighSalUGFT,StMedianSalUGFT,StLowestSalUGFT
	,StRegUG5FT,StOfferUG5FT,StHighSalUG5FT,StMedianSalUG5FT,StLowestSalUG5FT
	,StRegPGFT,StOfferPGFT,StHighSalPGFT,StMedianSalPGFT,StLowestSalPGFT
	,StRegPGPT,StOfferPGPT,StHighSalPGPT,StMedianSalPGPT,StLowestSalPGPT
	FROM Depts d
	LEFT JOIN TpDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
	left JOIN DataStatus as ds on sr.DataStatus = ds.DataStatus
	WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
	ORDER BY DeptName;
END

GO
