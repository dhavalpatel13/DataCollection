USE [RANK1]
GO

--Drop Table type if Exist
IF TYPE_ID('[dbo].[FinInfoData]') IS NOT NULL
BEGIN
	DROP TYPE [dbo].[FinInfoData];
END
GO

CREATE TYPE [dbo].[FinInfoData] AS TABLE 
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
	[FinYear] [nvarchar](10) NOT NULL,
	[ExpCapAAR] [money] NULL,
	[ExpLibOverall] [money] NULL,
	[ExpLibEngg] [money] NULL,
	[ExpLibMgmt] [money] NULL,
	[ExpLibArch] [money] NULL,
	[ExpNewEqpLabs] [money] NULL,
	[ExpEnggWS] [money] NULL,
	[ExpStudios] [money] NULL,
	[ExpOtherCapAssets] [money] NULL,
	[ExpOperational] [money] NULL,
	[ExpMaintRun] [money] NULL,
	[ExpSalT] [money] NULL,
	[ExpSalNT] [money] NULL,
	[ExpMisc1] [money] NULL,
	[ExpMisc2] [money] NULL,
	[ExpTotal] [money] NULL,
	[ExpRemarks] [nvarchar](100) NULL,
	[SchFsUGFT] [money] NULL,
	[SchFsUG5FT] [money] NULL,
	[SchFsPGFT] [money] NULL,
	[SchFsPGPT] [money] NULL,
	[SchSSUGFT] [money] NULL,
	[SchSSUG5FT] [money] NULL,
	[SchSSPGFT] [money] NULL,
	[SchSSPGPT] [money] NULL,
	[SchTotal] [money] NULL,
	[SchRemarks] [nvarchar](100) NULL
);

GO
