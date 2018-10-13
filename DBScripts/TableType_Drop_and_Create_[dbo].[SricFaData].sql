USE [RANK]
GO

--Drop Table type if Exist
IF TYPE_ID('[dbo].[SricFaData]') IS NOT NULL
BEGIN
	DROP TYPE [dbo].[SricFaData];
END
GO

CREATE TYPE [dbo].[SricFaData] AS TABLE 
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
	[FAName] [nvarchar](100) NOT NULL,
	[FASRProjQty] [int] NULL,
	[FASRProjOutlay] [money] NULL,
	[FASRProjRcp] [money] NULL,
	[FAICProjQty] [int] NULL,
	[FAICProjOutlay] [money] NULL,
	[FAICProjRcp] [money] NULL,
	[ResStaffNPDF] [int] NULL,
	[ResStaffPC] [int] NULL,
	[ResStaffPF] [int] NULL,
	[ResStaffRFSR] [int] NULL,
	[ResStaffRA] [int] NULL
);

GO
