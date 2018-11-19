USE [RANK1]
GO

--Drop Table if Exist
IF OBJECT_ID('dbo.InfraDEPT','U') IS NOT NULL
BEGIN
	DROP TABLE [dbo].[InfraDEPT];
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[InfraDEPT](
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
	[ClassRooms] [int] NULL,
	[Labs] [int] NULL,
	[Auditoriums] [int] NULL,
	[ConfRooms] [int] NULL,
	[FaclCabins] [int] NULL,
	[CompLabs] [int] NULL,
	[SplLabs] [int] NULL,
	[OtherLabs] [int] NULL,
 CONSTRAINT [PK_InfraDEPT] PRIMARY KEY CLUSTERED 
(
	[DataCaptYM] ASC,
	[DeptID] ASC,
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
