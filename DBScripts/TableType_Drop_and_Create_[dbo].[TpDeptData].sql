USE [RANK1]
GO

--Drop Table type if Exist
IF TYPE_ID('[dbo].[TPDeptData]') IS NOT NULL
BEGIN
	DROP TYPE [dbo].[TPDeptData];
END
GO

CREATE TYPE [dbo].[TPDeptData] AS TABLE 
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
	[StRegUGFT] [int] NULL,
	[StOfferUGFT] [int] NULL,
	[StHighSalUGFT] [money] NULL,
	[StMedianSalUGFT] [money] NULL,
	[StLowestSalUGFT] [money] NULL,
	[StRegUG5FT] [int] NULL,
	[StOfferUG5FT] [int] NULL,
	[StHighSalUG5FT] [money] NULL,
	[StMedianSalUG5FT] [money] NULL,
	[StLowestSalUG5FT] [money] NULL,
	[StRegPGFT] [int] NULL,
	[StOfferPGFT] [int] NULL,
	[StHighSalPGFT] [money] NULL,
	[StMedianSalPGFT] [money] NULL,
	[StLowestSalPGFT] [money] NULL,
	[StRegPGPT] [int] NULL,
	[StOfferPGPT] [int] NULL,
	[StHighSalPGPT] [money] NULL,
	[StMedianSalPGPT] [money] NULL,
	[StLowestSalPGPT] [money] NULL
);

GO
