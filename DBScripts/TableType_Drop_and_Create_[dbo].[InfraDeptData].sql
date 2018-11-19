USE [RANK1]
GO

--Drop Table type if Exist
IF TYPE_ID('[dbo].[InfraDeptData]') IS NOT NULL
BEGIN
	DROP TYPE [dbo].[InfraDeptData];
END
GO

CREATE TYPE [dbo].[InfraDeptData] AS TABLE 
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
	[ClassRooms] [int] NULL,
	[Labs] [int] NULL,
	[Auditoriums] [int] NULL,
	[ConfRooms] [int] NULL,
	[FaclCabins] [int] NULL,
	[CompLabs] [int] NULL,
	[SplLabs] [int] NULL,
	[OtherLabs] [int] NULL
);

GO
