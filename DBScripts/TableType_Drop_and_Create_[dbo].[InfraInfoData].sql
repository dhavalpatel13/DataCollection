USE [RANK1]
GO

--Drop Table type if Exist
IF TYPE_ID('[dbo].[InfraInfoData]') IS NOT NULL
BEGIN
	DROP TYPE [dbo].[InfraInfoData];
END
GO

CREATE TYPE [dbo].[InfraInfoData] AS TABLE 
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
	[InfraNo] [int] NOT NULL,
	[InfraDescr] [nvarchar](50) NULL,
	[InfraDetails] [nvarchar](50) NULL,
	[InfraRemarks] [nvarchar](100) NULL
);

GO
