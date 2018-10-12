USE [RANK]
GO

--Drop Table type if Exist
IF TYPE_ID('[dbo].[DofaData]') IS NOT NULL
BEGIN
	DROP TYPE [dbo].[DofaData];
END
GO

CREATE TYPE [dbo].[DofaData] AS TABLE 
(
	[IDNo] [int] NOT NULL,
	[DataCaptYM] [int] NOT NULL,
	[DeptID] [nvarchar](10) NOT NULL,
	[DeptName] [nvarchar](200) NULL,
	[MenuID] [nvarchar](10) NOT NULL,
	[DataUser] [nvarchar](50) NULL,
	[DataUpdatedOn] [datetime] NULL,
	[DataStatus] [smallint] NULL,
	[DataStatusName] [nvarchar](100) NULL,
	[DataStatusLog] [nvarchar](max) NULL,
	[DataValid] [char](1) NULL,
	[DataLocked] [char](1) NULL,
	[empNo] [int] NOT NULL,
	[empName] [nvarchar](50) NULL,
	[empDOB] [datetime] NULL,
	[empDOJ] [datetime] NULL,
	[empDOL] [datetime] NULL,
	[empGender] [char](1) NULL,
	[empDESG] [nvarchar](50) NULL,
	[empDEPT] [nvarchar](10) NULL,
	[empPAN] [nvarchar](10) NULL,
	[empType] [nvarchar](50) NULL,
	[empCat] [nvarchar](50) NULL,
	[empNation] [nvarchar](50) NULL,
	[QualHighYear] [int] NULL,
	[QualHighCourse] [nvarchar](100) NULL,
	[QualHighInst] [nvarchar](200) NULL,
	[ExpAcadMon] [int] NULL,
	[ExpIndMon] [int] NULL,
	[FacExcgIn] [nvarchar](200) NULL,
	[FacExcgOut] [nvarchar](200) NULL,
	[ConfSymSemNat] [int] NULL,
	[ConfSymSemInt] [int] NULL,
	[AwardHonors] [nvarchar](200) NULL
);

GO

SET ANSI_PADDING OFF
GO

