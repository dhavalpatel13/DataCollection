USE [RANK1]
GO

--Drop Table type if Exist
IF TYPE_ID('[dbo].[DofaPeerData]') IS NOT NULL
BEGIN
	DROP TYPE [dbo].[DofaPeerData];
END
GO

CREATE TYPE [dbo].[DofaPeerData] AS TABLE 
(
	[IDNo] [int] NOT NULL,
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
	[PeerNo] [int]	NOT NULL,
	[PeerType] [nvarchar](50) NULL,
	[PeerTitle] [nvarchar](50) NULL,
	[PeerFName] [nvarchar](50) NULL,
	[PeerLName] [nvarchar](50) NULL,
	[PeerJob] [nvarchar](100) NULL,
	[PeerDept] [nvarchar](100) NULL,
	[PeerInst] [nvarchar](100) NULL,
	[PeerCountry] [nvarchar](50) NULL,
	[PeerEmail] [nvarchar](100) NULL,
	[PeerMob] [nvarchar](50) NULL,
	[PeerDetails] [nvarchar](500) NULL,
	[PeerRemarks] [nvarchar](500) NULL
);

GO
