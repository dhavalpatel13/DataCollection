USE [RANK]
GO

--Drop Table if Exist
IF OBJECT_ID('dbo.dofainfo','U') IS NOT NULL
BEGIN
	DROP TABLE [dbo].[dofaInfo];
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[dofaInfo](
	[IDNo] [int] IDENTITY(1,1) NOT NULL,
	[DataCaptYM] [int] NOT NULL,
	[DeptID] [nvarchar](10) NOT NULL,
	[MenuID] [nvarchar](10) NOT NULL,
	[DataUser] [nvarchar](50) NULL,
	[DataUpdatedOn] [datetime] NULL,
	[DataStatus] [smallint] NULL,
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
	[AwardHonors] [nvarchar](200) NULL,
 CONSTRAINT [PK_dofaInfo] PRIMARY KEY CLUSTERED 
(
	[DataCaptYM] ASC,
	[DeptID] ASC,
	[MenuID] ASC,
	[empNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


