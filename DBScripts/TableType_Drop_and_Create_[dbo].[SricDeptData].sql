USE [RANK]
GO

--Drop Table type if Exist
IF TYPE_ID('[dbo].[SricDeptData]') IS NOT NULL
BEGIN
	DROP TYPE [dbo].[SricDeptData];
END
GO

CREATE TYPE [dbo].[SricDeptData] AS TABLE 
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
	[SRProjQty] [int] NULL,
	[SRFAQty] [int] NULL,
	[SRProjOutlay] [money] NULL,
	[SRProjRcp] [money] NULL,
	[ICProjQty] [int] NULL,
	[ICFAQty] [int] NULL,
	[ICProjOutlay] [money] NULL,
	[ICProjRcp] [money] NULL,
	[ConfSSNat] [int] NULL,
	[ConfSSNatExp] [money] NULL,
	[ConfSSInt] [int] NULL,
	[ConfSSIntExp] [money] NULL,
	[IPRFiled] [int] NULL,
	[IPRPub] [int] NULL,
	[IPRGranted] [int] NULL,
	[IPRLicensed] [int] NULL,
	[TechXferFiled] [int] NULL,
	[TechXferPub] [int] NULL,
	[TechXferGranted] [int] NULL,
	[TechXferLicensed] [int] NULL,
	[CopyRightsFiled] [int] NULL,
	[CopyRightsPub] [int] NULL,
	[CopyRightsGranted] [int] NULL,
	[CopyRightsLicensed] [int] NULL,
	[LogoDesignFiled] [int] NULL,
	[LogoDesignPub] [int] NULL,
	[LogoDesignGranted] [int] NULL,
	[LogoDesignLicensed] [int] NULL
);

GO
