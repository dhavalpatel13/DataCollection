USE [RANK1]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.DFNP_DATA_SELECT_BY_DataCaptYM','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[DFNP_DATA_SELECT_BY_DataCaptYM];
END
GO

CREATE PROCEDURE [dbo].[DFNP_DATA_SELECT_BY_DataCaptYM]
	@DataCaptYM int,
	@DeptID nvarchar(10)
AS
BEGIN
	SELECT sr.*,  d.DeptName, ds.Details as DataStatusName
	FROM Depts d
	LEFT JOIN FinInfo sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
	left JOIN DataStatus as ds on sr.DataStatus = ds.DataStatus
	WHERE sr.MenuID = 'DFNP' and sr.DataCaptYM = @DataCaptYM and sr.DeptID = @DeptID;
END

GO
