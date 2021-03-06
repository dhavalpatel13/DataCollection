USE [master]
GO
/****** Object:  Database [RankTemp]    Script Date: 10/28/2018 2:23:00 AM ******/
CREATE DATABASE [RankTemp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RANK', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\RANK1.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'RANK_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\RANK_log1.ldf' , SIZE = 1088KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [RankTemp] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RankTemp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RankTemp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RankTemp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RankTemp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RankTemp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RankTemp] SET ARITHABORT OFF 
GO
ALTER DATABASE [RankTemp] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RankTemp] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [RankTemp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RankTemp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RankTemp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RankTemp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RankTemp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RankTemp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RankTemp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RankTemp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RankTemp] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RankTemp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RankTemp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RankTemp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RankTemp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RankTemp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RankTemp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RankTemp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RankTemp] SET RECOVERY FULL 
GO
ALTER DATABASE [RankTemp] SET  MULTI_USER 
GO
ALTER DATABASE [RankTemp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RankTemp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RankTemp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RankTemp] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [RankTemp]
GO
/****** Object:  UserDefinedTableType [dbo].[DofaData]    Script Date: 10/28/2018 2:23:00 AM ******/
CREATE TYPE [dbo].[DofaData] AS TABLE(
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
)
GO
/****** Object:  UserDefinedTableType [dbo].[SricDeptData]    Script Date: 10/28/2018 2:23:00 AM ******/
CREATE TYPE [dbo].[SricDeptData] AS TABLE(
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
)
GO
/****** Object:  UserDefinedTableType [dbo].[SricFaData]    Script Date: 10/28/2018 2:23:00 AM ******/
CREATE TYPE [dbo].[SricFaData] AS TABLE(
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
)
GO
/****** Object:  StoredProcedure [dbo].[ADD_RANK_USER]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ADD_RANK_USER]
	@UserID nvarchar(20),
	@UserEmpNo nvarchar(10),
	@UserName nvarchar(50),
	@UserPassword nvarchar(500),		
	@UserMob nvarchar(10),
	@UserEmail nvarchar(50),
	@UserValid char(1),
	@UserRemarks nvarchar(100),
	@DeptID nvarchar(10),
	@UserWork nvarchar(10),
	@UserRole nvarchar(10),
	@IsEmailVerified bit,
	@ActivationCode UniqueIdentifier
AS
	DECLARE @UserCreatedOn datetime = GETDATE()
    
	INSERT INTO [dbo].[RankUsers]
           (UserID,
		    UserEmpNo,
			UserName,
			UserPassword,	
			UserMob,
			UserEmail,
			UserValid,
			UserRemarks,
			DeptID,
			UserWork,
			UserRole,
			IsEmailVerified,
			ActivationCode,
			UserCreatedOn)
     VALUES
           (@UserID,
			@UserEmpNo,
			@UserName,
			@UserPassword,	
			@UserMob,
			@UserEmail,
			@UserValid,
			@UserRemarks,
			@DeptID,
			@UserWork,
			@UserRole,
			@IsEmailVerified,
			@ActivationCode,
			@UserCreatedOn)

    SELECT  @UserID = SCOPE_IDENTITY()   
    SELECT  @UserID              


GO
/****** Object:  StoredProcedure [dbo].[Bulk_Update_DOFA_DATA_BY_DataCaptYM_DeptID_MenuID]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Bulk_Update_DOFA_DATA_BY_DataCaptYM_DeptID_MenuID]
	@dofaData DofaData readonly,
	@DataCaptYM int,
	@DeptID nvarchar(10),
	@empDept nvarchar(10) = ''
AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
	declare @MenuID nvarchar(10) = 'DOFA';
	declare @result bit = 0;

	IF EXISTS (select top  1 1 from @dofaData)
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION;

				UPDATE t1
				SET t1.DataUser		= d1.DataUser
				,t1.DataUpdatedOn	= GETDATE()
				,t1.DataStatus		= d1.DataStatus
				,t1.DataStatusLog	= d1.DataStatusLog	
				,t1.DataValid		= d1.DataValid		
				,t1.DataLocked		= d1.DataLocked		
				,t1.empNo			= d1.empNo
				,t1.empName			= d1.empName			
				,t1.empDOB			= d1.empDOB				
				,t1.empDOJ			= d1.empDOJ			
				,t1.empDOL			= d1.empDOL			
				,t1.empGender		= d1.empGender		
				,t1.empDESG			= d1.empDESG			
				,t1.empPAN			= d1.empPAN			
				,t1.empType			= d1.empType		
				,t1.empCat		    = d1.empCat			
				,t1.empNation		= d1.empNation		
				,t1.QualHighYear	= d1.QualHighYear	
				,t1.QualHighCourse	= d1.QualHighCourse	
				,t1.QualHighInst	= d1.QualHighInst	
				,t1.ExpAcadMon		= d1.ExpAcadMon		
				,t1.ExpIndMon		= d1.ExpIndMon		
				,t1.FacExcgIn		= d1.FacExcgIn		
				,t1.FacExcgOut		= d1.FacExcgOut		
				,t1.ConfSymSemNat	= d1.ConfSymSemNat	
				,t1.ConfSymSemInt	= d1.ConfSymSemInt	
				,t1.AwardHonors		= d1.AwardHonors 
			from dofaInfo t1
			inner join @dofaData d1 on d1.DataCaptYM=t1.DataCaptYM and d1.DeptID=t1.DeptID and d1.MenuID=t1.MenuID 
			and d1.IDNo=t1.IDNo and d1.empDEPT = t1.empDEPT and d1.IDNo > 0;
		
			insert into dofaInfo(
				DataCaptYM
				,DeptID
				,MenuID
				,DataUser
				,DataUpdatedOn
				,DataStatus
				,DataStatusLog
				,DataValid
				,DataLocked
				,empNo
				,empName
				,empDOB
				,empDOJ
				,empDOL
				,empGender
				,empDESG
				,empDEPT
				,empPAN
				,empType
				,empCat
				,empNation
				,QualHighYear
				,QualHighCourse
				,QualHighInst
				,ExpAcadMon
				,ExpIndMon
				,FacExcgIn
				,FacExcgOut
				,ConfSymSemNat
				,ConfSymSemInt
				,AwardHonors
			)
			SELECT DataCaptYM
				,DeptID
				,MenuID
				,DataUser
				,GETDATE()
				,DataStatus
				,DataStatusLog
				,DataValid
				,DataLocked
				,empNo
				,empName
				,empDOB
				,empDOJ
				,empDOL
				,empGender
				,empDESG
				,empDEPT
				,empPAN
				,empType
				,empCat
				,empNation
				,QualHighYear
				,QualHighCourse
				,QualHighInst
				,ExpAcadMon
				,ExpIndMon
				,FacExcgIn
				,FacExcgOut
				,ConfSymSemNat
				,ConfSymSemInt
				,AwardHonors
			FROM @dofaData
			WHERE IDNo = 0 and DataCaptYM = @DataCaptYM AND empDEPT = @empDept AND DeptID = @DeptID AND MenuID = @MenuID;

			IF (@@TRANCOUNT > 0)
			BEGIN
				set @result = 1;           
			END 

			COMMIT TRANSACTION;		

		END TRY
		BEGIN CATCH
			IF (@@TRANCOUNT > 0)
			BEGIN
				ROLLBACK TRANSACTION              
			END 
			set @result = 0; 
			SET @ErrorMessage  =ERROR_MESSAGE();
			SET @ErrorSeverity = ERROR_SEVERITY();
			SET @ErrorState    = ERROR_STATE();
			RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
			
		END CATCH
	END

	select @result;
END


GO
/****** Object:  StoredProcedure [dbo].[Bulk_Update_SRIC_DEPT_BY_DataCaptYM]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Bulk_Update_SRIC_DEPT_BY_DataCaptYM]
	@sricDeptData SricDeptData readonly,
	@DataCaptYM int
AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
	declare @MenuID nvarchar(10) = 'SRIC';
	declare @result bit = 0;

	IF EXISTS (select top 1 1 from @sricDeptData)
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION;

				UPDATE t1
				SET t1.DataUser		   = d1.DataUser
				,t1.DataUpdatedOn	   = GETDATE()
				,t1.DeptID			   = d1.DeptID
				,t1.DataStatus		   = d1.DataStatus
				,t1.DataStatusLog	   = d1.DataStatusLog	
				,t1.DataValid		   = d1.DataValid		
				,t1.DataLocked		   = d1.DataLocked		
				,t1.SRProjQty		   = d1.SRProjQty		  
				,t1.SRFAQty			   = d1.SRFAQty			  
				,t1.SRProjOutlay	   = d1.SRProjOutlay	  
				,t1.SRProjRcp		   = d1.SRProjRcp		  
				,t1.ICProjQty		   = d1.ICProjQty		  
				,t1.ICFAQty			   = d1.ICFAQty			  
				,t1.ICProjOutlay	   = d1.ICProjOutlay	  
				,t1.ICProjRcp		   = d1.ICProjRcp		  
				,t1.ConfSSNat		   = d1.ConfSSNat		  
				,t1.ConfSSNatExp	   = d1.ConfSSNatExp	  
				,t1.ConfSSInt		   = d1.ConfSSInt		  
				,t1.ConfSSIntExp	   = d1.ConfSSIntExp	  
				,t1.IPRFiled		   = d1.IPRFiled		  
				,t1.IPRPub			   = d1.IPRPub			  
				,t1.IPRGranted		   = d1.IPRGranted		  
				,t1.IPRLicensed		   = d1.IPRLicensed		  
				,t1.TechXferFiled	   = d1.TechXferFiled	  
				,t1.TechXferPub		   = d1.TechXferPub		  
				,t1.TechXferGranted	   = d1.TechXferGranted	  
				,t1.TechXferLicensed   = d1.TechXferLicensed  
				,t1.CopyRightsFiled	   = d1.CopyRightsFiled	  
				,t1.CopyRightsPub	   = d1.CopyRightsPub	  
				,t1.CopyRightsGranted  = d1.CopyRightsGranted 
				,t1.CopyRightsLicensed = d1.CopyRightsLicensed
				,t1.LogoDesignFiled	   = d1.LogoDesignFiled	  
				,t1.LogoDesignPub	   = d1.LogoDesignPub	  
				,t1.LogoDesignGranted  = d1.LogoDesignGranted 
				,t1.LogoDesignLicensed = d1.LogoDesignLicensed
			from sricDEPT t1
			inner join @sricDeptData d1 on d1.DataCaptYM=t1.DataCaptYM and d1.MenuID=t1.MenuID and d1.IDNo=t1.IDNo;
		
			insert into sricDEPT (
				DataCaptYM
				,DeptID
				,MenuID
				,DataUser
				,DataUpdatedOn
				,DataStatus
				,DataStatusLog
				,DataValid
				,DataLocked
				,SRProjQty
				,SRFAQty
				,SRProjOutlay
				,SRProjRcp
				,ICProjQty
				,ICFAQty
				,ICProjOutlay
				,ICProjRcp
				,ConfSSNat
				,ConfSSNatExp
				,ConfSSInt
				,ConfSSIntExp
				,IPRFiled
				,IPRPub
				,IPRGranted
				,IPRLicensed
				,TechXferFiled
				,TechXferPub
				,TechXferGranted
				,TechXferLicensed
				,CopyRightsFiled
				,CopyRightsPub
				,CopyRightsGranted
				,CopyRightsLicensed
				,LogoDesignFiled
				,LogoDesignPub
				,LogoDesignGranted
				,LogoDesignLicensed
			)
			SELECT DataCaptYM
				,DeptID
				,MenuID
				,DataUser
				,GETDATE()
				,DataStatus
				,DataStatusLog
				,DataValid
				,DataLocked
				,SRProjQty
				,SRFAQty
				,SRProjOutlay
				,SRProjRcp
				,ICProjQty
				,ICFAQty
				,ICProjOutlay
				,ICProjRcp
				,ConfSSNat
				,ConfSSNatExp
				,ConfSSInt
				,ConfSSIntExp
				,IPRFiled
				,IPRPub
				,IPRGranted
				,IPRLicensed
				,TechXferFiled
				,TechXferPub
				,TechXferGranted
				,TechXferLicensed
				,CopyRightsFiled
				,CopyRightsPub
				,CopyRightsGranted
				,CopyRightsLicensed
				,LogoDesignFiled
				,LogoDesignPub
				,LogoDesignGranted
				,LogoDesignLicensed
			FROM @sricDeptData
			WHERE IDNo = 0 and DataCaptYM = @DataCaptYM AND MenuID = @MenuID;

			IF (@@TRANCOUNT > 0)
			BEGIN
				set @result = 1;           
			END 

			COMMIT TRANSACTION;		

		END TRY
		BEGIN CATCH
			IF (@@TRANCOUNT > 0)
			BEGIN
				ROLLBACK TRANSACTION              
			END 
			set @result = 0; 
			SET @ErrorMessage  =ERROR_MESSAGE();
			SET @ErrorSeverity = ERROR_SEVERITY();
			SET @ErrorState    = ERROR_STATE();
			RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
			
		END CATCH
	END

	select @result;
END


GO
/****** Object:  StoredProcedure [dbo].[Bulk_Update_SricFA_DATA_BY_DataCaptYM_DeptID]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Bulk_Update_SricFA_DATA_BY_DataCaptYM_DeptID]
	@sricFaInfo SricFaData readonly,
	@DataCaptYM int,
	@DeptID nvarchar(10)
AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
	declare @MenuID nvarchar(10) = 'SRICFA';
	declare @result bit = 0;

	IF EXISTS (select top  1 1 from @sricFaInfo)
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION;

				UPDATE t1
				SET t1.DataUser		= d1.DataUser
				,t1.DataUpdatedOn	= GETDATE()
				,t1.DataStatus		= d1.DataStatus
				,t1.DataStatusLog	= d1.DataStatusLog	
				,t1.DataValid		= d1.DataValid		
				,t1.DataLocked		= d1.DataLocked		
				,t1.FAName			= d1.FAName			
				,t1.FASRProjQty		= d1.FASRProjQty		
				,t1.FASRProjOutlay	= d1.FASRProjOutlay	
				,t1.FASRProjRcp		= d1.FASRProjRcp		
				,t1.FAICProjQty		= d1.FAICProjQty		
				,t1.FAICProjOutlay	= d1.FAICProjOutlay	
				,t1.FAICProjRcp		= d1.FAICProjRcp		
				,t1.ResStaffNPDF	= d1.ResStaffNPDF	
				,t1.ResStaffPC		= d1.ResStaffPC		
				,t1.ResStaffPF		= d1.ResStaffPF		
				,t1.ResStaffRFSR	= d1.ResStaffRFSR	
				,t1.ResStaffRA		= d1.ResStaffRA		
			from sricFA t1
			inner join @sricFaInfo d1 on d1.DataCaptYM=t1.DataCaptYM and d1.DeptID=t1.DeptID and d1.MenuID=t1.MenuID 
			and d1.IDNo=t1.IDNo;
		
			insert into sricFA(
				DataCaptYM
				,DeptID
				,MenuID
				,DataUser
				,DataUpdatedOn
				,DataStatus
				,DataStatusLog
				,DataValid
				,DataLocked
				,FAName
				,FASRProjQty
				,FASRProjOutlay
				,FASRProjRcp
				,FAICProjQty
				,FAICProjOutlay
				,FAICProjRcp
				,ResStaffNPDF
				,ResStaffPC
				,ResStaffPF
				,ResStaffRFSR
				,ResStaffRA
			)
			SELECT DataCaptYM
				,DeptID
				,MenuID
				,DataUser
				,GETDATE()
				,DataStatus
				,DataStatusLog
				,DataValid
				,DataLocked
				,FAName
				,FASRProjQty
				,FASRProjOutlay
				,FASRProjRcp
				,FAICProjQty
				,FAICProjOutlay
				,FAICProjRcp
				,ResStaffNPDF
				,ResStaffPC
				,ResStaffPF
				,ResStaffRFSR
				,ResStaffRA
			FROM @sricFaInfo
			WHERE IDNo = 0 and DataCaptYM = @DataCaptYM AND DeptID = @DeptID AND MenuID = @MenuID;

			IF (@@TRANCOUNT > 0)
			BEGIN
				set @result = 1;           
			END 

			COMMIT TRANSACTION;		

		END TRY
		BEGIN CATCH
			IF (@@TRANCOUNT > 0)
			BEGIN
				ROLLBACK TRANSACTION              
			END 
			set @result = 0; 
			SET @ErrorMessage  =ERROR_MESSAGE();
			SET @ErrorSeverity = ERROR_SEVERITY();
			SET @ErrorState    = ERROR_STATE();
			RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
			
		END CATCH
	END

	select @result;
END


GO
/****** Object:  StoredProcedure [dbo].[CHECK_USER_EXIST_BY_EMAIL_EMPNO]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CHECK_USER_EXIST_BY_EMAIL_EMPNO]
	@UserEmail nvarchar(50),
	@UserEmpNo nvarchar(10), 
	@UserID nvarchar(20),
	@UserMob nvarchar(10)
AS

	Set @UserEmail = ''
	Set @UserMob = ''

	If (EXISTS(SELECT 1 FROM RankUsers WHERE UserEmail = @UserEmail))
	BEGIN
	   select 1 --Email exists
	END
	ELSE IF (EXISTS(SELECT 1 FROM RankUsers WHERE UserEmpNo = @UserEmpNo))
	BEGIN
	   select 2 --Emp no exists
	END	
	ELSE IF (EXISTS(SELECT 1 FROM RankUsers WHERE UserID = @UserID))
	BEGIN
	   select 3 --UserId already exists
	END	
	ELSE IF (EXISTS(SELECT 1 FROM RankUsers WHERE UserMob = @UserMob))
	BEGIN
	   select 4 --Mobile Number already exists
	END	
	ELSE
	BEGIN
		select -1 --User Not Exists
	END


GO
/****** Object:  StoredProcedure [dbo].[DOAA1_INFO_INSERT]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DOAA1_INFO_INSERT]
	@DataCaptYM int,
	@DeptID nvarchar(10),
	@MenuID nvarchar(10),
	@DataUser nvarchar(50),	
	@DataStatus smallint,
	@DataStatusLog nvarchar(max),
	@DataValid char(1),
	@DataLocked char(1),
	@stMaleUGFT int,
	@stMaleUG5FT int,
	@stMalePGFT int,
	@stMalePGPT int,
	@stFemaleUGFT int,
	@stFemaleUG5FT int,
	@stFemalePGFT int,
	@stFemalePGPT int,
	@stTotalWithinStateUGFT int,
	@stTotalWithinStateUG5FT int,
	@stTotalWithinStatePGFT int,
	@stTotalWithinStatePGPT int,
	@stTotalOutsideStateUGFT int,
	@stTotalOutsideStateUG5FT int,
	@stTotalOutsideStatePGFT int,
	@stTotalOutsideStatePGPT int,
	@stTotalForeignUGFT int,
	@stTotalForeignUG5FT int,
	@stTotalForeignPGFT int,
	@stTotalForeignPGPT int,
	@stEcoBackMaleUGFT int,
	@stEcoBackMaleUG5FT int,
	@stEcoBackMalePGFT int,
	@stEcoBackMalePGPT int,
	@stSocChaFemaleUGFT int,
	@stSocChaFemaleUG5FT int,
	@stSocChaFemalePGFT int,
	@stSocChaFemalePGPT int,
	@stSocChaMaleUGFT int,
	@stSocChaMaleUG5FT int,
	@stSocChaMalePGFT int,
	@stSocChaMalePGPT int,
	@stPHFemaleUGFT int,
	@stPHFemaleUG5FT int,
	@stPHFemalePGFT int,
	@stPHFemalePGPT int,
	@stPHMaleUGFT int,
	@stPHMaleUG5FT int,
	@stPHMalePGFT int,
	@stPHMalePGPT int,
	@stScholarGovFemaleUGFT int,
	@stScholarGovFemaleUG5FT int,
	@stScholarGovFemalePGFT int,
	@stScholarGovFemalePGPT int,
	@stScholarGovMaleUGFT int,
	@stScholarGovMaleUG5FT int,
	@stScholarGovMalePGFT int,
	@stScholarGovMalePGPT int,
	@stScholorInstFemaleUGFT int,
	@stScholorInstFemaleUG5FT int,
	@stScholorInstFemalePGFT int,
	@stScholorInstFemalePGPT int,
	@stScholorInstMaleUGFT int,
	@stScholorInstMaleUG5FT int,
	@stScholorInstMalePGFT int,
	@stScholorInstMalePGPT int,
	@stScholorPvtFemaleUGFT int,
	@stScholorPvtFemaleUG5FT int,
	@stScholorPvtFemalePGFT int,
	@stScholorPvtFemalePGPT int,
	@stScholorPvtMaleUGFT int,
	@stScholorPvtMaleUG5FT int,
	@stScholorPvtMalePGFT int,
	@stScholorPvtMalePGPT int,
	@stNoScholorMaleUGFT int,
	@stNoScholorMaleUG5FT int,
	@stNoScholorMalePGFT int,
	@stNoScholorMalePGPT int,
	@stIntakeMaleUGFT int,
	@stIntakeMaleUG5FT int,
	@stIntakeMalePGFT int,
	@stIntakeMalePGPT int,
	@stAdmitMaleUGFT int,
	@stAdmitMaleUG5FT int,
	@stAdmitMalePGFT int,
	@stAdmitMalePGPT int,
	@stLateralMaleUGFT int,
	@stLateralMaleUG5FT int,
	@stLateralMalePGFT int,
	@stLateralMalePGPT int,
	@stMinGradMaleUGFT int,
	@stMinGradMaleUG5FT int,
	@stMinGradMalePGFT int,
	@stMinGradMalePGPT int,
	@stPlaceMedSalMaleUGFT int,
	@stPlaceMedSalMaleUG5FT int,
	@stPlaceMedSalMalePGFT int,
	@stPlaceMedSalMalePGPT int,
	@stHigherMaleUGFT int,
	@stHigherMaleUG5FT int,
	@stHigherMalePGFT int,
	@stHigherMalePGPT int,
	@stConfNatMaleUGFT int,
	@stConfNatMaleUG5FT int,
	@stConfNatMalePGFT int,
	@stConfNatMalePGPT int,
	@stConfIntMaleUGFT int,
	@stConfIntMaleUG5FT int,
	@stConfIntMalePGFT int,
	@stConfIntMalePGPT int,
	@stPhDFT int,
	@stPhDPT int,
	@stGradPhDFT int,
	@stGradPhDPT int
AS

	DECLARE @IDNo INT = 0
	DECLARE @DataUpdatedOn datetime = GETDATE()
    
    INSERT INTO [dbo].[stInfo]
           ([DataCaptYM]
           ,[DeptID]
           ,[MenuID]
           ,[DataUser]
           ,[DataUpdatedOn]
           ,[DataStatus]
           ,[DataStatusLog]
           ,[DataValid]
           ,[DataLocked]
           ,[stMaleUGFT]
           ,[stMaleUG5FT]
           ,[stMalePGFT]
           ,[stMalePGPT]
           ,[stFemaleUGFT]
           ,[stFemaleUG5FT]
           ,[stFemalePGFT]
           ,[stFemalePGPT]
           ,[stTotalWithinStateUGFT]
           ,[stTotalWithinStateUG5FT]
           ,[stTotalWithinStatePGFT]
           ,[stTotalWithinStatePGPT]
           ,[stTotalOutsideStateUGFT]
           ,[stTotalOutsideStateUG5FT]
           ,[stTotalOutsideStatePGFT]
           ,[stTotalOutsideStatePGPT]
           ,[stTotalForeignUGFT]
           ,[stTotalForeignUG5FT]
           ,[stTotalForeignPGFT]
           ,[stTotalForeignPGPT]
           ,[stEcoBackMaleUGFT]
           ,[stEcoBackMaleUG5FT]
           ,[stEcoBackMalePGFT]
           ,[stEcoBackMalePGPT]
           ,[stSocChaFemaleUGFT]
           ,[stSocChaFemaleUG5FT]
           ,[stSocChaFemalePGFT]
           ,[stSocChaFemalePGPT]
           ,[stSocChaMaleUGFT]
           ,[stSocChaMaleUG5FT]
           ,[stSocChaMalePGFT]
           ,[stSocChaMalePGPT]
           ,[stPHFemaleUGFT]
           ,[stPHFemaleUG5FT]
           ,[stPHFemalePGFT]
           ,[stPHFemalePGPT]
           ,[stPHMaleUGFT]
           ,[stPHMaleUG5FT]
           ,[stPHMalePGFT]
           ,[stPHMalePGPT]
           ,[stScholarGovFemaleUGFT]
           ,[stScholarGovFemaleUG5FT]
           ,[stScholarGovFemalePGFT]
           ,[stScholarGovFemalePGPT]
           ,[stScholarGovMaleUGFT]
           ,[stScholarGovMaleUG5FT]
           ,[stScholarGovMalePGFT]
           ,[stScholarGovMalePGPT]
           ,[stScholorInstFemaleUGFT]
           ,[stScholorInstFemaleUG5FT]
           ,[stScholorInstFemalePGFT]
           ,[stScholorInstFemalePGPT]
           ,[stScholorInstMaleUGFT]
           ,[stScholorInstMaleUG5FT]
           ,[stScholorInstMalePGFT]
           ,[stScholorInstMalePGPT]
           ,[stScholorPvtFemaleUGFT]
           ,[stScholorPvtFemaleUG5FT]
           ,[stScholorPvtFemalePGFT]
           ,[stScholorPvtFemalePGPT]
           ,[stScholorPvtMaleUGFT]
           ,[stScholorPvtMaleUG5FT]
           ,[stScholorPvtMalePGFT]
           ,[stScholorPvtMalePGPT]
           ,[stNoScholorMaleUGFT]
           ,[stNoScholorMaleUG5FT]
           ,[stNoScholorMalePGFT]
           ,[stNoScholorMalePGPT]
           ,[stIntakeMaleUGFT]
           ,[stIntakeMaleUG5FT]
           ,[stIntakeMalePGFT]
           ,[stIntakeMalePGPT]
           ,[stAdmitMaleUGFT]
           ,[stAdmitMaleUG5FT]
           ,[stAdmitMalePGFT]
           ,[stAdmitMalePGPT]
           ,[stLateralMaleUGFT]
           ,[stLateralMaleUG5FT]
           ,[stLateralMalePGFT]
           ,[stLateralMalePGPT]
           ,[stMinGradMaleUGFT]
           ,[stMinGradMaleUG5FT]
           ,[stMinGradMalePGFT]
           ,[stMinGradMalePGPT]
           ,[stPlaceMedSalMaleUGFT]
           ,[stPlaceMedSalMaleUG5FT]
           ,[stPlaceMedSalMalePGFT]
           ,[stPlaceMedSalMalePGPT]
           ,[stHigherMaleUGFT]
           ,[stHigherMaleUG5FT]
           ,[stHigherMalePGFT]
           ,[stHigherMalePGPT]
           ,[stConfNatMaleUGFT]
           ,[stConfNatMaleUG5FT]
           ,[stConfNatMalePGFT]
           ,[stConfNatMalePGPT]
           ,[stConfIntMaleUGFT]
           ,[stConfIntMaleUG5FT]
           ,[stConfIntMalePGFT]
           ,[stConfIntMalePGPT]
		   ,[stPhDFT]
		   ,[stPhDPT]
		   ,[stGradPhDFT]
		   ,[stGradPhDPT])
     VALUES
           (@DataCaptYM, 
           @DeptID,
           @MenuID,
           @DataUser,
           @DataUpdatedOn,
           @DataStatus,
           @DataStatusLog,
           @DataValid,
           @DataLocked,
           @stMaleUGFT, 
           @stMaleUG5FT, 
           @stMalePGFT, 
           @stMalePGPT, 
           @stFemaleUGFT, 
           @stFemaleUG5FT, 
           @stFemalePGFT, 
           @stFemalePGPT, 
           @stTotalWithinStateUGFT, 
           @stTotalWithinStateUG5FT, 
           @stTotalWithinStatePGFT, 
           @stTotalWithinStatePGPT, 
           @stTotalOutsideStateUGFT, 
           @stTotalOutsideStateUG5FT, 
           @stTotalOutsideStatePGFT, 
           @stTotalOutsideStatePGPT, 
           @stTotalForeignUGFT, 
           @stTotalForeignUG5FT, 
           @stTotalForeignPGFT, 
           @stTotalForeignPGPT, 
           @stEcoBackMaleUGFT, 
           @stEcoBackMaleUG5FT, 
           @stEcoBackMalePGFT, 
           @stEcoBackMalePGPT, 
           @stSocChaFemaleUGFT, 
           @stSocChaFemaleUG5FT, 
           @stSocChaFemalePGFT, 
           @stSocChaFemalePGPT, 
           @stSocChaMaleUGFT, 
           @stSocChaMaleUG5FT, 
           @stSocChaMalePGFT, 
           @stSocChaMalePGPT, 
           @stPHFemaleUGFT, 
           @stPHFemaleUG5FT, 
           @stPHFemalePGFT, 
           @stPHFemalePGPT, 
           @stPHMaleUGFT, 
           @stPHMaleUG5FT, 
           @stPHMalePGFT, 
           @stPHMalePGPT, 
           @stScholarGovFemaleUGFT, 
           @stScholarGovFemaleUG5FT, 
           @stScholarGovFemalePGFT, 
           @stScholarGovFemalePGPT, 
           @stScholarGovMaleUGFT, 
           @stScholarGovMaleUG5FT, 
           @stScholarGovMalePGFT, 
           @stScholarGovMalePGPT, 
           @stScholorInstFemaleUGFT, 
           @stScholorInstFemaleUG5FT, 
           @stScholorInstFemalePGFT, 
           @stScholorInstFemalePGPT, 
           @stScholorInstMaleUGFT, 
           @stScholorInstMaleUG5FT, 
           @stScholorInstMalePGFT, 
           @stScholorInstMalePGPT, 
           @stScholorPvtFemaleUGFT, 
           @stScholorPvtFemaleUG5FT, 
           @stScholorPvtFemalePGFT, 
           @stScholorPvtFemalePGPT, 
           @stScholorPvtMaleUGFT, 
           @stScholorPvtMaleUG5FT, 
           @stScholorPvtMalePGFT, 
           @stScholorPvtMalePGPT, 
           @stNoScholorMaleUGFT, 
           @stNoScholorMaleUG5FT, 
           @stNoScholorMalePGFT, 
           @stNoScholorMalePGPT, 
           @stIntakeMaleUGFT, 
           @stIntakeMaleUG5FT, 
           @stIntakeMalePGFT, 
           @stIntakeMalePGPT, 
           @stAdmitMaleUGFT, 
           @stAdmitMaleUG5FT, 
           @stAdmitMalePGFT, 
           @stAdmitMalePGPT, 
           @stLateralMaleUGFT, 
           @stLateralMaleUG5FT, 
           @stLateralMalePGFT, 
           @stLateralMalePGPT, 
           @stMinGradMaleUGFT, 
           @stMinGradMaleUG5FT, 
           @stMinGradMalePGFT, 
           @stMinGradMalePGPT, 
           @stPlaceMedSalMaleUGFT, 
           @stPlaceMedSalMaleUG5FT, 
           @stPlaceMedSalMalePGFT, 
           @stPlaceMedSalMalePGPT, 
           @stHigherMaleUGFT, 
           @stHigherMaleUG5FT, 
           @stHigherMalePGFT, 
           @stHigherMalePGPT, 
           @stConfNatMaleUGFT, 
           @stConfNatMaleUG5FT, 
           @stConfNatMalePGFT, 
           @stConfNatMalePGPT, 
           @stConfIntMaleUGFT, 
           @stConfIntMaleUG5FT, 
           @stConfIntMalePGFT, 
           @stConfIntMalePGPT,
		   @stPhDFT,
		   @stPhDPT,
		   @stGradPhDFT,
		   @stGradPhDPT)
    SELECT  @IDNo = SCOPE_IDENTITY()   
    SELECT  @IDNo        
      


GO
/****** Object:  StoredProcedure [dbo].[DOAA1_INFO_SELECT_BY_DataCaptYM_DeptID_MenuID]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DOAA1_INFO_SELECT_BY_DataCaptYM_DeptID_MenuID]
	@DataCaptYM int,
	@DeptID nvarchar(10),
	@MenuID nvarchar(10) = 'DOAA'
AS
BEGIN
	IF @MenuID = 'DOAA'
	BEGIN
		SELECT info.*, ds.Details as DataStatusName, dp.DeptName as DeptName FROM stInfo as info
		Inner join DataStatus as ds on info.DataStatus = ds.DataStatus
		inner join Depts as dp on info.DeptID = dp.DeptID
		WHERE DataCaptYM = @DataCaptYM AND info.DeptID = @DeptID AND MenuID = @MenuID
	END
	ELSE IF (@MenuID = 'ADIR' OR @MenuID = 'DOSW')
	BEGIN
		SELECT info2.*, ds.Details as DataStatusName, dp.DeptName as DeptName FROM stInfo2 as info2
		Inner join DataStatus as ds on info2.DataStatus = ds.DataStatus
		inner join Depts as dp on info2.DeptID = dp.DeptID
		WHERE DataCaptYM = @DataCaptYM AND info2.DeptID = @DeptID AND MenuID = @MenuID	
	END
	ELSE IF(@MenuID = 'LIBFORM')
	BEGIN
		SELECT LibInfo.*, ds.Details as DataStatusName, dp.DeptName as DeptName FROM LibInfo 
		Inner join DataStatus as ds on LibInfo.DataStatus = ds.DataStatus
		inner join Depts as dp on LibInfo.DeptID = dp.DeptID
		WHERE DataCaptYM = @DataCaptYM AND LibInfo.DeptID = @DeptID AND MenuID = @MenuID
	END
END


GO
/****** Object:  StoredProcedure [dbo].[DOAA1_INFO_UPDATE]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DOAA1_INFO_UPDATE]
	@IDNo INT ,
	@DataCaptYM int,
	@DeptID nvarchar(10),
	@MenuID nvarchar(10),
	@DataUser nvarchar(50),	
	@DataStatus smallint,
	@DataStatusLog nvarchar(max),
	@DataValid char(1),
	@DataLocked char(1),
	@stMaleUGFT int,
	@stMaleUG5FT int,
	@stMalePGFT int,
	@stMalePGPT int,
	@stFemaleUGFT int,
	@stFemaleUG5FT int,
	@stFemalePGFT int,
	@stFemalePGPT int,
	@stTotalWithinStateUGFT int,
	@stTotalWithinStateUG5FT int,
	@stTotalWithinStatePGFT int,
	@stTotalWithinStatePGPT int,
	@stTotalOutsideStateUGFT int,
	@stTotalOutsideStateUG5FT int,
	@stTotalOutsideStatePGFT int,
	@stTotalOutsideStatePGPT int,
	@stTotalForeignUGFT int,
	@stTotalForeignUG5FT int,
	@stTotalForeignPGFT int,
	@stTotalForeignPGPT int,
	@stEcoBackMaleUGFT int,
	@stEcoBackMaleUG5FT int,
	@stEcoBackMalePGFT int,
	@stEcoBackMalePGPT int,
	@stSocChaFemaleUGFT int,
	@stSocChaFemaleUG5FT int,
	@stSocChaFemalePGFT int,
	@stSocChaFemalePGPT int,
	@stSocChaMaleUGFT int,
	@stSocChaMaleUG5FT int,
	@stSocChaMalePGFT int,
	@stSocChaMalePGPT int,
	@stPHFemaleUGFT int,
	@stPHFemaleUG5FT int,
	@stPHFemalePGFT int,
	@stPHFemalePGPT int,
	@stPHMaleUGFT int,
	@stPHMaleUG5FT int,
	@stPHMalePGFT int,
	@stPHMalePGPT int,
	@stScholarGovFemaleUGFT int,
	@stScholarGovFemaleUG5FT int,
	@stScholarGovFemalePGFT int,
	@stScholarGovFemalePGPT int,
	@stScholarGovMaleUGFT int,
	@stScholarGovMaleUG5FT int,
	@stScholarGovMalePGFT int,
	@stScholarGovMalePGPT int,
	@stScholorInstFemaleUGFT int,
	@stScholorInstFemaleUG5FT int,
	@stScholorInstFemalePGFT int,
	@stScholorInstFemalePGPT int,
	@stScholorInstMaleUGFT int,
	@stScholorInstMaleUG5FT int,
	@stScholorInstMalePGFT int,
	@stScholorInstMalePGPT int,
	@stScholorPvtFemaleUGFT int,
	@stScholorPvtFemaleUG5FT int,
	@stScholorPvtFemalePGFT int,
	@stScholorPvtFemalePGPT int,
	@stScholorPvtMaleUGFT int,
	@stScholorPvtMaleUG5FT int,
	@stScholorPvtMalePGFT int,
	@stScholorPvtMalePGPT int,
	@stNoScholorMaleUGFT int,
	@stNoScholorMaleUG5FT int,
	@stNoScholorMalePGFT int,
	@stNoScholorMalePGPT int,
	@stIntakeMaleUGFT int,
	@stIntakeMaleUG5FT int,
	@stIntakeMalePGFT int,
	@stIntakeMalePGPT int,
	@stAdmitMaleUGFT int,
	@stAdmitMaleUG5FT int,
	@stAdmitMalePGFT int,
	@stAdmitMalePGPT int,
	@stLateralMaleUGFT int,
	@stLateralMaleUG5FT int,
	@stLateralMalePGFT int,
	@stLateralMalePGPT int,
	@stMinGradMaleUGFT int,
	@stMinGradMaleUG5FT int,
	@stMinGradMalePGFT int,
	@stMinGradMalePGPT int,
	@stPlaceMedSalMaleUGFT int,
	@stPlaceMedSalMaleUG5FT int,
	@stPlaceMedSalMalePGFT int,
	@stPlaceMedSalMalePGPT int,
	@stHigherMaleUGFT int,
	@stHigherMaleUG5FT int,
	@stHigherMalePGFT int,
	@stHigherMalePGPT int,
	@stConfNatMaleUGFT int,
	@stConfNatMaleUG5FT int,
	@stConfNatMalePGFT int,
	@stConfNatMalePGPT int,
	@stConfIntMaleUGFT int,
	@stConfIntMaleUG5FT int,
	@stConfIntMalePGFT int,
	@stConfIntMalePGPT int,
	@stPhDFT int,
	@stPhDPT int,
	@stGradPhDFT int,
	@stGradPhDPT int
AS
	DECLARE @DataUpdatedOn datetime = GETDATE()
    
    UPDATE [dbo].[stInfo] 
	SET
           DataCaptYM = @DataCaptYM, 
           DeptID = @DeptID,
           MenuID = @MenuID,
           DataUser = @DataUser,
           DataUpdatedOn = @DataUpdatedOn,
           DataStatus = @DataStatus,
           DataStatusLog = @DataStatusLog,
           DataValid = @DataValid,
           DataLocked = @DataLocked,
           stMaleUGFT = @stMaleUGFT, 
           stMaleUG5FT = @stMaleUG5FT, 
           stMalePGFT = @stMalePGFT, 
           stMalePGPT = @stMalePGPT, 
           stFemaleUGFT = @stFemaleUGFT, 
           stFemaleUG5FT = @stFemaleUG5FT, 
           stFemalePGFT = @stFemalePGFT, 
           stFemalePGPT = @stFemalePGPT, 
           stTotalWithinStateUGFT = @stTotalWithinStateUGFT,
           stTotalWithinStateUG5FT = @stTotalWithinStateUG5FT,
           stTotalWithinStatePGFT = @stTotalWithinStatePGFT,
           stTotalWithinStatePGPT = @stTotalWithinStatePGPT,
           stTotalOutsideStateUGFT = @stTotalOutsideStateUGFT, 
           stTotalOutsideStateUG5FT = @stTotalOutsideStateUG5FT, 
           stTotalOutsideStatePGFT = @stTotalOutsideStatePGFT, 
           stTotalOutsideStatePGPT = @stTotalOutsideStatePGPT, 
           stTotalForeignUGFT = @stTotalForeignUGFT, 
           stTotalForeignUG5FT = @stTotalForeignUG5FT, 
           stTotalForeignPGFT = @stTotalForeignPGFT, 
           stTotalForeignPGPT = @stTotalForeignPGPT, 
           stEcoBackMaleUGFT = @stEcoBackMaleUGFT, 
           stEcoBackMaleUG5FT = @stEcoBackMaleUG5FT, 
           stEcoBackMalePGFT = @stEcoBackMalePGFT, 
           stEcoBackMalePGPT = @stEcoBackMalePGPT, 
           stSocChaFemaleUGFT = @stSocChaFemaleUGFT, 
           stSocChaFemaleUG5FT = @stSocChaFemaleUG5FT, 
           stSocChaFemalePGFT = @stSocChaFemalePGFT, 
           stSocChaFemalePGPT = @stSocChaFemalePGPT, 
           stSocChaMaleUGFT = @stSocChaMaleUGFT, 
           stSocChaMaleUG5FT = @stSocChaMaleUG5FT, 
           stSocChaMalePGFT = @stSocChaMalePGFT, 
           stSocChaMalePGPT = @stSocChaMalePGPT, 
           stPHFemaleUGFT = @stPHFemaleUGFT, 
           stPHFemaleUG5FT = @stPHFemaleUG5FT, 
           stPHFemalePGFT = @stPHFemalePGFT, 
           stPHFemalePGPT = @stPHFemalePGPT, 
           stPHMaleUGFT = @stPHMaleUGFT, 
           stPHMaleUG5FT = @stPHMaleUG5FT, 
           stPHMalePGFT = @stPHMalePGFT, 
           stPHMalePGPT = @stPHMalePGPT, 
           stScholarGovFemaleUGFT =	@stScholarGovFemaleUGFT, 
           stScholarGovFemaleUG5FT =	@stScholarGovFemaleUG5FT, 
           stScholarGovFemalePGFT =	@stScholarGovFemalePGFT, 
           stScholarGovFemalePGPT =	@stScholarGovFemalePGPT, 
           stScholarGovMaleUGFT =	@stScholarGovMaleUGFT, 
           stScholarGovMaleUG5FT =	@stScholarGovMaleUG5FT, 
           stScholarGovMalePGFT =	@stScholarGovMalePGFT, 
           stScholarGovMalePGPT =	@stScholarGovMalePGPT, 
           stScholorInstFemaleUGFT =	@stScholorInstFemaleUGFT, 
           stScholorInstFemaleUG5FT = @stScholorInstFemaleUG5FT, 
           stScholorInstFemalePGFT =	@stScholorInstFemalePGFT, 
           stScholorInstFemalePGPT =	@stScholorInstFemalePGPT, 
           stScholorInstMaleUGFT =	@stScholorInstMaleUGFT, 
           stScholorInstMaleUG5FT =	@stScholorInstMaleUG5FT, 
           stScholorInstMalePGFT =	@stScholorInstMalePGFT, 
           stScholorInstMalePGPT =	@stScholorInstMalePGPT, 
           stScholorPvtFemaleUGFT =	@stScholorPvtFemaleUGFT, 
           stScholorPvtFemaleUG5FT =	@stScholorPvtFemaleUG5FT, 
           stScholorPvtFemalePGFT =	@stScholorPvtFemalePGFT, 
           stScholorPvtFemalePGPT =	@stScholorPvtFemalePGPT, 
           stScholorPvtMaleUGFT =	@stScholorPvtMaleUGFT, 
           stScholorPvtMaleUG5FT = @stScholorPvtMaleUG5FT, 
           stScholorPvtMalePGFT = @stScholorPvtMalePGFT, 
           stScholorPvtMalePGPT = @stScholorPvtMalePGPT, 
           stNoScholorMaleUGFT =	@stNoScholorMaleUGFT, 
           stNoScholorMaleUG5FT = @stNoScholorMaleUG5FT, 
           stNoScholorMalePGFT =	@stNoScholorMalePGFT, 
           stNoScholorMalePGPT =	@stNoScholorMalePGPT, 
           stIntakeMaleUGFT = @stIntakeMaleUGFT, 
           stIntakeMaleUG5FT = @stIntakeMaleUG5FT, 
           stIntakeMalePGFT = @stIntakeMalePGFT, 
           stIntakeMalePGPT = @stIntakeMalePGPT, 
           stAdmitMaleUGFT =	 @stAdmitMaleUGFT, 
           stAdmitMaleUG5FT = @stAdmitMaleUG5FT, 
           stAdmitMalePGFT =	 @stAdmitMalePGFT, 
           stAdmitMalePGPT =	 @stAdmitMalePGPT, 
           stLateralMaleUGFT = @stLateralMaleUGFT, 
           stLateralMaleUG5FT =	@stLateralMaleUG5FT, 
           stLateralMalePGFT = @stLateralMalePGFT, 
           stLateralMalePGPT = @stLateralMalePGPT, 
           stMinGradMaleUGFT = @stMinGradMaleUGFT, 
           stMinGradMaleUG5FT = @stMinGradMaleUG5FT, 
           stMinGradMalePGFT = @stMinGradMalePGFT, 
           stMinGradMalePGPT = @stMinGradMalePGPT, 
           stPlaceMedSalMaleUGFT = @stPlaceMedSalMaleUGFT, 
           stPlaceMedSalMaleUG5FT = @stPlaceMedSalMaleUG5FT, 
           stPlaceMedSalMalePGFT = @stPlaceMedSalMalePGFT, 
           stPlaceMedSalMalePGPT = @stPlaceMedSalMalePGPT, 
           stHigherMaleUGFT =	@stHigherMaleUGFT, 
           stHigherMaleUG5FT =	@stHigherMaleUG5FT, 
           stHigherMalePGFT =	@stHigherMalePGFT, 
           stHigherMalePGPT =	@stHigherMalePGPT, 
           stConfNatMaleUGFT =	@stConfNatMaleUGFT, 
           stConfNatMaleUG5FT =	@stConfNatMaleUG5FT, 
           stConfNatMalePGFT =	@stConfNatMalePGFT, 
           stConfNatMalePGPT =	@stConfNatMalePGPT, 
           stConfIntMaleUGFT =	@stConfIntMaleUGFT, 
           stConfIntMaleUG5FT =	@stConfIntMaleUG5FT, 
           stConfIntMalePGFT =	@stConfIntMalePGFT, 
           stConfIntMalePGPT =	@stConfIntMalePGPT,
		   stPhDFT = @stPhDFT,
		   stPhDPT = @stPhDPT,
		   stGradPhDFT = @stGradPhDFT,
		   stGradPhDPT = @stGradPhDPT
     WHERE IDNo = @IDNo
      
      


GO
/****** Object:  StoredProcedure [dbo].[DOFA_DATA_SELECT_BY_DataCaptYM_DeptID_MenuID]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DOFA_DATA_SELECT_BY_DataCaptYM_DeptID_MenuID]
	@DataCaptYM int,
	@DeptID nvarchar(10),
	@empDept nvarchar(10) = ''
AS
BEGIN
	SELECT 
	info.IDNo
	,info.DataCaptYM
	,info.DeptID
	,info.MenuID
	,info.DataUser
	,info.DataUpdatedOn
	,info.DataStatus
	,info.DataStatusLog
	,info.DataValid
	,info.DataLocked
	,info.empNo
	,info.empName
	,(CASE WHEN info.empDOB is NULL then '' ELSE REPLACE(CONVERT(NVARCHAR,CAST(info.empDOB AS DATETIME), 106), ' ', '-') END) as empDOB
	,(CASE WHEN info.empDOJ is NULL then '' ELSE REPLACE(CONVERT(NVARCHAR,CAST(info.empDOJ AS DATETIME), 106), ' ', '-') END) as empDOJ
	,(CASE WHEN info.empDOL is NULL then '' ELSE REPLACE(CONVERT(NVARCHAR,CAST(info.empDOL AS DATETIME), 106), ' ', '-') END) as empDOL
	,info.empGender
	,info.empDESG
	,info.empDEPT
	,info.empPAN
	,info.empType
	,info.empCat
	,info.empNation
	,info.QualHighYear
	,info.QualHighCourse
	,info.QualHighInst
	,info.ExpAcadMon
	,info.ExpIndMon
	,info.FacExcgIn
	,info.FacExcgOut
	,info.ConfSymSemNat
	,info.ConfSymSemInt
	,info.AwardHonors
	,ds.Details as DataStatusName
	,dp.DeptName as DeptName 
	FROM dofaInfo as info
	INNER JOIN DataStatus as ds on info.DataStatus = ds.DataStatus
	INNER JOIN Depts as dp on info.empDEPT = dp.DeptID
	WHERE DataCaptYM = @DataCaptYM AND info.DeptID = @DeptID 
	AND (ISNULL(@empDept,'') = '' OR info.empDEPT = @empDept) AND MenuID = 'DOFA'
END



GO
/****** Object:  StoredProcedure [dbo].[Get_All_Table]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Get_All_Table]
AS
BEGIN	
	select Name from sys.tables	
END
GO
/****** Object:  StoredProcedure [dbo].[GET_CURRENT_USER_MENU]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GET_CURRENT_USER_MENU]	
	@UserID nvarchar(20)
AS
BEGIN
	SELECT * FROM UserMenu WHERE UserID = @UserID
END



GO
/****** Object:  StoredProcedure [dbo].[GET_LOGIN_USER]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GET_LOGIN_USER]
	@UserName nvarchar(20),
	@UserPassword nvarchar(20)
AS
	SELECT * FROM RankUsers WHERE UserName = @UserName And UserPassword = @UserPassword


GO
/****** Object:  StoredProcedure [dbo].[GET_RANK_INFO_MSG]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GET_RANK_INFO_MSG]		
AS
	SELECT TOP 1 * FROM RankMesg


	

GO
/****** Object:  StoredProcedure [dbo].[Get_Table_Detail]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Get_Table_Detail]
@TableName NVARCHAR(500)
AS
BEGIN	
	DECLARE @sqlCommand varchar(1000)
	DECLARE @columnList varchar(75)
	DECLARE @city varchar(75)
	--SET @columnList = 'CustomerID, ContactName, City'
	SET @city = '''London'''
	SET @sqlCommand = 'SELECT * FROM ' + @TableName
	EXEC (@sqlCommand)
END
GO
/****** Object:  StoredProcedure [dbo].[LIBINFO_INSERT]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[LIBINFO_INSERT]
	@DataCaptYM int,
	@DeptID nvarchar(10),
	@MenuID nvarchar(10),
	@DataUser nvarchar(50),	
	@DataStatus smallint,
	@DataStatusLog nvarchar(max),
	@DataValid char(1),
	@DataLocked char(1),
	@SubscJourDB int,
	@PrintedBooks int,
	@TotalCollection int,
	@FYAddition	int,
	@LibMembers	int,
	@LibSeatCap	int,
	@SemWSOrg int,
	@BooksChMono int,
	@JourPapers	int,
	@ConfSympWSPapers int,
	@SciTechReports	int
AS

	DECLARE @IDNo INT = 0
	DECLARE @DataUpdatedOn datetime = GETDATE()
    
    INSERT INTO [dbo].[LibInfo]
			(
			[DataCaptYM],
			[DeptID],
			[MenuID],
			[DataUser],
			[DataUpdatedOn],
			[DataStatus],
			[DataStatusLog],
			[DataValid],
			[DataLocked],
			[SubscJourDB],
			[PrintedBooks],
			[TotalCollection],
			[FYAddition],
			[LibMembers],
			[LibSeatCap],
			[SemWSOrg],
			[BooksChMono],
			[JourPapers],
			[ConfSympWSPapers],
			[SciTechReports]
			)
     VALUES
           (@DataCaptYM, 
			@DeptID,
			@MenuID,
			@DataUser,
			@DataUpdatedOn,
			@DataStatus,
			@DataStatusLog,
			@DataValid,
			@DataLocked,
			@SubscJourDB,
			@PrintedBooks,
			@TotalCollection,
			@FYAddition,
			@LibMembers,
			@LibSeatCap,
			@SemWSOrg,
			@BooksChMono,
			@JourPapers,
			@ConfSympWSPapers,
			@SciTechReports
           )
    SELECT  @IDNo = SCOPE_IDENTITY()   
    SELECT  @IDNo        
      


GO
/****** Object:  StoredProcedure [dbo].[LIBINFO_UPDATE]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[LIBINFO_UPDATE]
	@IDNo int,
	@DataCaptYM int,
	@DeptID nvarchar(10),
	@MenuID nvarchar(10),
	@DataUser nvarchar(50),	
	@DataStatus smallint,
	@DataStatusLog nvarchar(max),
	@DataValid char(1),
	@DataLocked char(1),
	@SubscJourDB int,
	@PrintedBooks int,
	@TotalCollection int,
	@FYAddition	int,
	@LibMembers	int,
	@LibSeatCap	int,
	@SemWSOrg int,
	@BooksChMono int,
	@JourPapers	int,
	@ConfSympWSPapers int,
	@SciTechReports	int
AS
	DECLARE @DataUpdatedOn datetime = GETDATE()
    
    UPDATE [dbo].[LibInfo] 
	SET
           DataCaptYM = @DataCaptYM, 
           DeptID = @DeptID,
           MenuID = @MenuID,
           DataUser = @DataUser,
           DataUpdatedOn = @DataUpdatedOn,
           DataStatus = @DataStatus,
           DataStatusLog = @DataStatusLog,
           DataValid = @DataValid,
           DataLocked = @DataLocked,
           SubscJourDB = @SubscJourDB,
		   PrintedBooks = @PrintedBooks,
		   TotalCollection = @TotalCollection,
		   FYAddition = @FYAddition,
		   LibMembers = @LibMembers,
		   LibSeatCap = @LibSeatCap,
		   SemWSOrg = @SemWSOrg,
		   BooksChMono = @BooksChMono,
		   JourPapers = @JourPapers,
		   ConfSympWSPapers = @ConfSympWSPapers,
		   SciTechReports = @SciTechReports
     WHERE IDNo = @IDNo


GO
/****** Object:  StoredProcedure [dbo].[Rpt_SELECT_BY_DataCaptYM_DeptID]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Rpt_SELECT_BY_DataCaptYM_DeptID]
	@DataCaptYM int,
	@MenuID nvarchar(10),
	@DeptID nvarchar(10) = ''
AS
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SET @DeptID = ISNULL(@DeptID,'');

	IF(@MenuID='DOFA')
	BEGIN
		SELECT 
		 info.IDNo as 'IDNo'
		,info.empNo as 'EmpNo'
		,info.empName as 'Name of Faculty Members (FC)'
		,(CASE WHEN info.empDOB is NULL then '' ELSE REPLACE(CONVERT(NVARCHAR,CAST(info.empDOB AS DATETIME), 106), ' ', '-') END) as 'DOB'
		,info.empDESG as 'Designation'
		,info.empGender as 'Gender'
		,info.empNation as 'Nationality'
		,info.QualHighCourse as 'Highest Qualification - Course'
		,info.QualHighYear as 'Highest Qualification - Year'
		,info.QualHighInst as 'Highest Qualification - Institute'
		,info.empPAN as 'PAN No.'
		,info.ExpIndMon as 'Industry Experience (in Years)'
		,info.ExpAcadMon as 'Academic Experience(in Months)'
		,dp.DeptName as 'Department'
		,(CASE WHEN info.empDOJ is NULL then '' ELSE REPLACE(CONVERT(NVARCHAR,CAST(info.empDOJ AS DATETIME), 106), ' ', '-') END) as 'Institute Joining Date'
		,(CASE WHEN info.empDOL is NULL then '' ELSE REPLACE(CONVERT(NVARCHAR,CAST(info.empDOL AS DATETIME), 106), ' ', '-') END) as 'Leaving Date (as on date)'
		,info.empType as 'Association Type'
		,info.FacExcgIn as 'Faculty Exchange Inbound'
		,info.FacExcgOut as 'Faculty Exchange Outbound'
		,info.ConfSymSemNat as 'No. of Conference / Symposia / Seminars National'
		,info.ConfSymSemInt as 'No. of Conference / Symposia / Seminars International'
		,info.AwardHonors as 'Awards and Honors'
		FROM dofaInfo as info
		INNER JOIN Depts as dp on info.empDEPT = dp.DeptID
		WHERE DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID
		AND (@DeptID = '' OR info.empDEPT = @DeptID);

	END

	ELSE IF(@MenuID='SRICFA')
	BEGIN
		SELECT 
		 info.IDNo as 'IDNo'
		,info.FAName as 'Organization / Agency Name'
		,info.FASRProjQty as 'No. of Projects (SR)'
		,info.FASRProjOutlay as 'Outlay (SR)'
		,info.FASRProjRcp as 'Receipt (SR)'
		,info.FAICProjQty as 'No. of Projects (IC)'
		,info.FAICProjOutlay as 'Outlay (IC)'
		,info.FAICProjRcp as 'Receipt (IC)'
		,info.ResStaffNPDF as 'N-PDF'
		,info.ResStaffPC as 'Project Consultant'
		,info.ResStaffPF as 'Project Fellow'
		,info.ResStaffRA as 'Research Associate'
		,info.ResStaffRFSR as 'JRF/SRF/Fellow (SR)'
		FROM sricFA as info
		WHERE DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID;

	END

	ELSE IF(@MenuID='SRIC')
	BEGIN
		SELECT d.DeptName as [Department - Sponsored Research Projects (Deptt.-wise)]
		,sr.SRProjQty as [No. of Project]
		,sr.SRFAQty as [Total No. of Funding Agencies]
		,sr.SRProjOutlay as [Total Outlay]
		,sr.SRProjRcp as [Total Receipt] -- block 1
		FROM Depts d
		LEFT JOIN sricDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
		WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
		ORDER BY DeptName;

		SELECT d.DeptName as [Department - Consultancy Projects (Deptt.-wise)]
		,sr.ICProjQty as [No. of Project]
		,sr.ICFAQty as [Total No. of Sponsors]
		,sr.ICProjOutlay as [Contracted Amount]
		,sr.ICProjRcp as [Actual Receipt] -- block 2
		FROM Depts d
		LEFT JOIN sricDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
		WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
		ORDER BY DeptName;

		SELECT d.DeptName as [Department - Conference / Symposia / Seminars]
		,sr.ConfSSNat as [National]
		,sr.ConfSSNatExp as [Expenditure]
		,sr.ConfSSInt as [International]
		,sr.ConfSSIntExp as [Total Expenditure] -- block 3
		FROM Depts d
		LEFT JOIN sricDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
		WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
		ORDER BY DeptName;

		SELECT d.DeptName as [Details of Intellectual Property]
		,sr.IPRFiled as [Patents Filed]
		,sr.IPRPub as [Patent Published]
		,sr.IPRGranted as [Patent Granted]
		,sr.IPRLicensed as [Patent Licensed] -- block 4
		FROM Depts d
		LEFT JOIN sricDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
		WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
		ORDER BY DeptName;

		SELECT d.DeptName as [Details of Technology Transfer]
		,sr.TechXferFiled as [Filed]
		,sr.TechXferPub as [Published]
		,sr.TechXferGranted as [Granted]
		,sr.TechXferLicensed as [Licensed] -- block 5
		FROM Depts d
		LEFT JOIN sricDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
		WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
		ORDER BY DeptName;

		SELECT d.DeptName as [Details of Logo/Design Copy Rights]
		,sr.CopyRightsFiled as [Filed]
		,sr.CopyRightsPub as [Published]
		,sr.CopyRightsGranted as [Granted]
		,sr.CopyRightsLicensed as [Licensed] -- block 6
		FROM Depts d
		LEFT JOIN sricDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
		WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
		ORDER BY DeptName;

		SELECT d.DeptName as [Details of Copy Rights]
		,sr.LogoDesignFiled as [Filed]
		,sr.LogoDesignPub as [Published]
		,sr.LogoDesignGranted as [Granted]
		,sr.LogoDesignLicensed as [Licensed] -- block 7
		FROM Depts d
		LEFT JOIN sricDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
		WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
		ORDER BY DeptName;

	END

	ELSE IF(@MenuID='LIBFORM')
	BEGIN

		SELECT 
		 info.IDNo as 'IDNo'
		,dp.DeptName as 'Place'
		,info.SubscJourDB as 'No. Subscription of Journals & Databases'
		,info.PrintedBooks as 'No. of Printed Books'
		,info.TotalCollection as 'Total Collection'
		,info.FYAddition as 'Additions in Financial Year'
		,info.LibMembers as 'No. of Library Membership'
		,info.LibSeatCap as 'Seating Capacity'
		,info.SemWSOrg as 'No. of Seminars/ Workshops organized by MGCL'
		,info.BooksChMono as 'Books/ Chapters in books/ monograph'
		,info.JourPapers as 'Papers in Journals'
		,info.ConfSympWSPapers as 'Papers in Conferences/ Symposia/ Seminar/ Workshop'
		,info.SciTechReports as 'Scientific & Technical Reports'
		FROM LibInfo as info
		inner join Depts as dp on info.DeptID = dp.DeptID
		WHERE DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND (@DeptID = '' OR info.DeptID = @DeptID); 

	END

	ELSE IF(@MenuID='ADIR')
	BEGIN

		create table #adir1
		(
			[Tuition Fees] nvarchar(max),
			[International] money
		);

		insert into #adir1 
		select top 1 'Undergraduate Fees (US $)' as [Tuition Fees],
		stFeeUGInt as [International]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID; 

		insert into #adir1 
		select top 1 'Postgraduate Fees (US $)' as [Tuition Fees],
		stFeePGInt as [International]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID; 

		insert into #adir1 
		select top 1 'Ph.D (US $)' as [Tuition Fees],
		stFeePHDInt as [International]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID;

		create table #adir2
		(
			[Regional Rankings Indicator] nvarchar(max),
			[Full Time] int,
			[Part Time] int
		);

		insert into #adir2
		select top 1 'Undergraduate Exchange Students - Inbound' as [Regional Rankings Indicator],
		stExchUGInFT as [Full Time],
		stExchUGInPT as [Part Time]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID; 

		insert into #adir2
		select top 1 'Undergraduate Exchange Students - Outbound' as [Regional Rankings Indicator],
		stExchUGOutFT as [Full Time],
		stExchUGOutPT as [Part Time]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID; 

		insert into #adir2
		select top 1 'Postgraduate Exchange Students - Inbound' as [Regional Rankings Indicator],
		stExchPGInFT as [Full Time],
		stExchPGInPT as [Part Time]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID; 

		insert into #adir2
		select top 1 'Postgraduate Exchange Students - Outbound' as [Regional Rankings Indicator],
		stExchPGOutFT as [Full Time],
		stExchPGOutPT as [Part Time]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID; 

		select * from #adir1;
		select * from #adir2;

	END

	ELSE IF(@MenuID='DOSW')
	BEGIN

		create table #dosw
		(
			[Tuition Fees] nvarchar(max),
			[Domestic] money
		);

		insert into #dosw 
		select top 1 'Undergraduate Fees (INR)' as [Tuition Fees],
		stFeeUGNat as [Domestic]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID; 

		insert into #dosw 
		select top 1 'Postgraduate Fees (INR)' as [Tuition Fees],
		stFeePGNat as [Domestic]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID; 

		insert into #dosw 
		select top 1 'Ph.D (INR)' as [Tuition Fees],
		stFeePHDNat as [Domestic]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID;

		select * from #dosw;

	END

	ELSE IF(@MenuID='DOAA')
	BEGIN

		create table #doaa1
		(
			[Details of Students] nvarchar(max),
			[UG] int,
			[UG-5YRS] int,
			[PG-FT] int,
			[PG-PT] int
		);

		insert into #doaa1
		select top 1 'No. of Male Students' as [Details of Students],
		stMaleUGFT as [UG],
		stMaleUG5FT as [UG-5YRS],
		stMalePGFT as [PG-FT],
		stMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of Female Students' as [Details of Students],
		stFemaleUGFT as [UG],
		stFemaleUG5FT as [UG-5YRS],
		stFemalePGFT as [PG-FT],
		stFemalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Total Students Within State (Including male & female)' as [Details of Students],
		stTotalWithinStateUGFT as [UG],
		stTotalWithinStateUG5FT as [UG-5YRS],
		stTotalWithinStatePGFT as [PG-FT],
		stTotalWithinStatePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Outside State (Including male & female)' as [Details of Students],
		stTotalOutsideStateUGFT as [UG],
		stTotalOutsideStateUG5FT as [UG-5YRS],
		stTotalOutsideStatePGFT as [PG-FT],
		stTotalOutsideStatePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Outside Country (Including male & female)' as [Details of Students],
		stTotalForeignUGFT as [UG],
		stTotalForeignUG5FT as [UG-5YRS],
		stTotalForeignPGFT as [PG-FT],
		stTotalForeignPGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Economically Backward (Including male & female)' as [Details of Students],
		stEcoBackMaleUGFT as [UG],
		stEcoBackMaleUG5FT as [UG-5YRS],
		stEcoBackMalePGFT as [PG-FT],
		stEcoBackMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Socially Challenged (SC+ST+OBC Female)' as [Details of Students],
		stSocChaFemaleUGFT as [UG],
		stSocChaFemaleUG5FT as [UG-5YRS],
		stSocChaFemalePGFT as [PG-FT],
		stSocChaFemalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Socially Challenged (SC+ST+OBC Male)' as [Details of Students],
		stSocChaFemaleUGFT as [UG],
		stSocChaFemaleUG5FT as [UG-5YRS],
		stSocChaFemalePGFT as [PG-FT],
		stSocChaFemalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Physically Challenged (SC+ST+OBC Female)' as [Details of Students],
		stPHFemaleUGFT as [UG],
		stPHFemaleUG5FT as [UG-5YRS],
		stPHFemalePGFT as [PG-FT],
		stPHFemalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Physically Challenged (SC+ST+OBC Male)' as [Details of Students],
		stPHMaleUGFT as [UG],
		stPHMaleUG5FT as [UG-5YRS],
		stPHMalePGFT as [PG-FT],
		stPHMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of students receiving Freeships /Scholarships from the State and Central Government (Female)' as [Details of Students],
		stScholarGovFemaleUGFT as [UG],
		stScholarGovFemaleUG5FT as [UG-5YRS],
		stScholarGovFemalePGFT as [PG-FT],
		stScholarGovFemalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of students receiving Freeships /Scholarships from the State and Central Government (Male)' as [Details of Students],
		stScholarGovMaleUGFT as [UG],
		stScholarGovMaleUG5FT as [UG-5YRS],
		stScholarGovMalePGFT as [PG-FT],
		stScholarGovMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of students receiving Freeships /Scholarships from Institution (Female)' as [Details of Students],
		stScholorInstFemaleUGFT as [UG],
		stScholorInstFemaleUG5FT as [UG-5YRS],
		stScholorInstFemalePGFT as [PG-FT],
		stScholorInstFemalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of students receiving Freeships /Scholarships from Institution (Male)' as [Details of Students],
		stScholorInstMaleUGFT as [UG],
		stScholorInstMaleUG5FT as [UG-5YRS],
		stScholorInstMalePGFT as [PG-FT],
		stScholorInstMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Funds No. of students receiving Freeships /Scholarships from the Private Bodies (Female)' as [Details of Students],
		stScholorPvtFemaleUGFT as [UG],
		stScholorPvtFemaleUG5FT as [UG-5YRS],
		stScholorPvtFemalePGFT as [PG-FT],
		stScholorPvtFemalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Funds No. of students receiving Freeships /Scholarships from the Private Bodies (Male)' as [Details of Students],
		stScholorPvtMaleUGFT as [UG],
		stScholorPvtMaleUG5FT as [UG-5YRS],
		stScholorPvtMalePGFT as [PG-FT],
		stScholorPvtMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of Students who are not receiving any Freeships /Scholarships' as [Details of Students],
		stNoScholorMaleUGFT as [UG],
		stNoScholorMaleUG5FT as [UG-5YRS],
		stNoScholorMalePGFT as [PG-FT],
		stNoScholorMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of first year students intake in the year' as [Details of Students],
		stIntakeMaleUGFT as [UG],
		stIntakeMaleUG5FT as [UG-5YRS],
		stIntakeMalePGFT as [PG-FT],
		stIntakeMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of first year students admitted in the year' as [Details of Students],
		stAdmitMaleUGFT as [UG],
		stAdmitMaleUG5FT as [UG-5YRS],
		stAdmitMalePGFT as [PG-FT],
		stAdmitMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';
		
		insert into #doaa1
		select top 1 'No. of students admitted through Lateral entry' as [Details of Students],
		stLateralMaleUGFT as [UG],
		stLateralMaleUG5FT as [UG-5YRS],
		stLateralMalePGFT as [PG-FT],
		stLateralMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';
		
		insert into #doaa1
		select top 1 'No. of students graduating in minimum stipulated time' as [Details of Students],
		stMinGradMaleUGFT as [UG],
		stMinGradMaleUG5FT as [UG-5YRS],
		stMinGradMalePGFT as [PG-FT],
		stMinGradMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of students placed Median salary of placed graduates per annum (Amount in Rs.)' as [Details of Students],
		stPlaceMedSalMaleUGFT as [UG],
		stPlaceMedSalMaleUG5FT as [UG-5YRS],
		stPlaceMedSalMalePGFT as [PG-FT],
		stPlaceMedSalMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of students selected for Higher Studies' as [Details of Students],
		stHigherMaleUGFT as [UG],
		stHigherMaleUG5FT as [UG-5YRS],
		stHigherMalePGFT as [PG-FT],
		stHigherMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';
		
		insert into #doaa1
		select top 1 'No. of National Conference (Student)' as [Details of Students],
		stConfNatMaleUGFT as [UG],
		stConfNatMaleUG5FT as [UG-5YRS],
		stConfNatMalePGFT as [PG-FT],
		stConfNatMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';
		
		insert into #doaa1
		select top 1 'No. of International Conference (Student)' as [Details of Students],
		stConfIntMaleUGFT as [UG],
		stConfIntMaleUG5FT as [UG-5YRS],
		stConfIntMalePGFT as [PG-FT],
		stConfIntMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';
		
		insert into #doaa1
		select top 1 'Total' as [Details of Students],
		 sum([UG]) as [UG],
		 sum([UG-5YRS]) as [UG-5YRS],
		 sum([PG-FT]) as [PG-FT],
		 sum([PG-PT]) as [PG-PT]
		from #doaa1;
		
		create table #doaa2
		(
			[Ph.D Student Details] nvarchar(max),
			[FullTime(FT)] int,
			[PartTime(PT)] int
		);

		insert into #doaa2
		select top 1 'Total Students in Financial Year (Sample Data)' as [Ph.D Student Details],
		stPhDFT as [FullTime(FT)],
		stPhDPT as [PartTime(PT)]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa2
		select top 1 'No. of Ph.D students graduated in Financial Year (including Integrated Ph.D)' as [Ph.D Student Details],
		stGradPhDFT as [FullTime(FT)],
		stGradPhDPT as [PartTime(PT)]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		select * from #doaa1;
		select * from #doaa2;
	END
END



GO
/****** Object:  StoredProcedure [dbo].[SRIC_DEPT_DATA_SELECT_BY_DataCaptYM]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SRIC_DEPT_DATA_SELECT_BY_DataCaptYM]
	@DataCaptYM int
AS
BEGIN
	SELECT ISNULL(sr.IDNo, 0) as IDNo ,ISNULL(sr.DataCaptYM, @DataCaptYM) as DataCaptYM
	,d.DeptID, d.DeptName, ISNULL(sr.MenuID,'SRIC') as MenuID
	,sr.DataUser,sr.DataUpdatedOn, sr.DataStatus, ds.Details as DataStatusName, sr.DataStatusLog, sr.DataValid, sr.DataLocked
	,sr.SRProjQty, sr.SRFAQty, sr.SRProjOutlay, sr.SRProjRcp -- block 1
	,sr.ICProjQty, sr.ICFAQty, sr.ICProjOutlay, sr.ICProjRcp -- block 2
	,sr.ConfSSNat, sr.ConfSSNatExp, sr.ConfSSInt, sr.ConfSSIntExp -- block 3
	,sr.IPRFiled, sr.IPRPub, sr.IPRGranted, sr.IPRLicensed -- block 4
	,sr.TechXferFiled, sr.TechXferPub, sr.TechXferGranted, sr.TechXferLicensed -- block 5
	,sr.CopyRightsFiled, sr.CopyRightsPub, sr.CopyRightsGranted, sr.CopyRightsLicensed -- block 6
	,sr.LogoDesignFiled, sr.LogoDesignPub, sr.LogoDesignGranted, sr.LogoDesignLicensed -- block 7
	FROM Depts d
	LEFT JOIN sricDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
	left JOIN DataStatus as ds on sr.DataStatus = ds.DataStatus
	WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
	ORDER BY DeptName;
END



GO
/****** Object:  StoredProcedure [dbo].[SricFA_DATA_SELECT_BY_DataCaptYM_DeptID]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SricFA_DATA_SELECT_BY_DataCaptYM_DeptID]
	@DataCaptYM int,
	@DeptID nvarchar(10)
AS
BEGIN
	SELECT 
	info.IDNo
	,info.DataCaptYM
	,info.DeptID
	,info.MenuID
	,info.DataUser
	,info.DataUpdatedOn
	,info.DataStatus
	,info.DataStatusLog
	,info.DataValid
	,info.DataLocked
	,info.FAName
	,info.FASRProjQty
	,info.FASRProjOutlay
	,info.FASRProjRcp
	,info.FAICProjQty
	,info.FAICProjOutlay
	,info.FAICProjRcp
	,info.ResStaffNPDF
	,info.ResStaffPC
	,info.ResStaffPF
	,info.ResStaffRFSR
	,info.ResStaffRA
	,ds.Details as DataStatusName
	,dp.DeptName as DeptName 
	FROM sricFA as info
	Inner join DataStatus as ds on info.DataStatus = ds.DataStatus
	inner join Depts as dp on info.DeptID = dp.DeptID
	WHERE DataCaptYM = @DataCaptYM AND info.DeptID = @DeptID AND MenuID = 'SRICFA'
END



GO
/****** Object:  StoredProcedure [dbo].[stINFO2_INSERT]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[stINFO2_INSERT]
	@DataCaptYM int,
	@DeptID nvarchar(10),
	@MenuID nvarchar(10),
	@DataUser nvarchar(50),	
	@DataStatus smallint,
	@DataStatusLog nvarchar(max),
	@DataValid char(1),
	@DataLocked char(1),
	@stFeeUGNat int, 
	@stFeeUGInt int,
	@stFeePGNat int, 
	@stFeePGInt int, 
	@stFeePHDNat int,
	@stFeePHDInt int, 
	@stExchUGInFT int, 
	@stExchUGInPT int, 
	@stExchPGInFT int, 
	@stExchPGInPT int, 
	@stExchUGOutFT int,
	@stExchUGOutPT int,
	@stExchPGOutFT int,
	@stExchPGOutPT int
AS

	DECLARE @IDNo INT = 0
	DECLARE @DataUpdatedOn datetime = GETDATE()
    
    INSERT INTO [dbo].[stInfo2]
			([DataCaptYM]
			,[DeptID]
			,[MenuID]
			,[DataUser]
			,[DataUpdatedOn]
			,[DataStatus]
			,[DataStatusLog]
			,[DataValid]
			,[DataLocked]
			,[stFeeUGNat] 
			,[stFeeUGInt]
			,[stFeePGNat] 
			,[stFeePGInt]
			,[stFeePHDNat]
			,[stFeePHDInt]
			,[stExchUGInFT] 
			,[stExchUGInPT] 
			,[stExchPGInFT] 
			,[stExchPGInPT]
			,[stExchUGOutFT]
			,[stExchUGOutPT]
			,[stExchPGOutFT]
			,[stExchPGOutPT]
           )
     VALUES
           (@DataCaptYM, 
			@DeptID,
			@MenuID,
			@DataUser,
			@DataUpdatedOn,
			@DataStatus,
			@DataStatusLog,
			@DataValid,
			@DataLocked,
			@stFeeUGNat, 
			@stFeeUGInt,
			@stFeePGNat, 
			@stFeePGInt, 
			@stFeePHDNat,
			@stFeePHDInt, 
			@stExchUGInFT, 
			@stExchUGInPT, 
			@stExchPGInFT, 
			@stExchPGInPT, 
			@stExchUGOutFT,
			@stExchUGOutPT,
			@stExchPGOutFT,
			@stExchPGOutPT
           )
    SELECT  @IDNo = SCOPE_IDENTITY()   
    SELECT  @IDNo        
      


GO
/****** Object:  StoredProcedure [dbo].[stINFO2_UPDATE]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[stINFO2_UPDATE]
	@IDNo INT ,
	@DataCaptYM int,
	@DeptID nvarchar(10),
	@MenuID nvarchar(10),
	@DataUser nvarchar(50),	
	@DataStatus smallint,
	@DataStatusLog nvarchar(max),
	@DataValid char(1),
	@DataLocked char(1),
	@stFeeUGNat int, 
	@stFeeUGInt int,
	@stFeePGNat int, 
	@stFeePGInt int, 
	@stFeePHDNat int,
	@stFeePHDInt int, 
	@stExchUGInFT int, 
	@stExchUGInPT int, 
	@stExchPGInFT int, 
	@stExchPGInPT int, 
	@stExchUGOutFT int,
	@stExchUGOutPT int,
	@stExchPGOutFT int,
	@stExchPGOutPT int
AS
	DECLARE @DataUpdatedOn datetime = GETDATE()
    
    UPDATE [dbo].[stInfo2] 
	SET
           DataCaptYM = @DataCaptYM, 
           DeptID = @DeptID,
           MenuID = @MenuID,
           DataUser = @DataUser,
           DataUpdatedOn = @DataUpdatedOn,
           DataStatus = @DataStatus,
           DataStatusLog = @DataStatusLog,
           DataValid = @DataValid,
           DataLocked = @DataLocked,
           stFeeUGNat = @stFeeUGNat, 
		   stFeeUGInt = @stFeeUGInt,
		   stFeePGNat = @stFeePGNat, 
		   stFeePGInt = @stFeePGInt, 
		   stFeePHDNat = @stFeePHDNat,
		   stFeePHDInt = @stFeePHDInt, 
		   stExchUGInFT = @stExchUGInFT, 
		   stExchUGInPT = @stExchUGInPT, 
		   stExchPGInFT = @stExchPGInFT, 
		   stExchPGInPT = @stExchPGInPT, 
		   stExchUGOutFT = @stExchUGOutFT,
		   stExchUGOutPT = @stExchUGOutPT,
		   stExchPGOutFT = @stExchPGOutFT,
		   stExchPGOutPT = @stExchPGOutPT
     WHERE IDNo = @IDNo


GO
/****** Object:  StoredProcedure [dbo].[UPDATE_RANK_USER]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UPDATE_RANK_USER]
	@UserID nvarchar(20),
	@UserEmpNo nvarchar(10),
	@UserName nvarchar(50),
	@UserPassword nvarchar(500),	
	@UserMob nvarchar(10),
	@UserEmail nvarchar(50),
	@UserValid char(1),
	@DeptID nvarchar(10),
	@UserRole nvarchar(10),
	@UserWork nvarchar(10)
AS
	DECLARE @UserCreatedOn datetime = GETDATE()
	DECLARE @UserDisabledOn datetime = GETDATE()

	UPDATE [dbo].[RankUsers] 
	SET UserEmpNo = @UserEmpNo,
		UserName = @UserName,
		UserPassword = @UserPassword,
		UserMob = @UserMob,
		UserEmail = @UserEmail,
		UserValid = @UserValid,
		DeptID = @DeptID,
		UserRole = @UserRole,
		UserWork = @UserWork,
		UserDisabledOn = (CASE WHEN @UserValid = 'N'
							   THEN @UserDisabledOn 
							   ELSE NULL END)
	WHERE UserID = @UserID

    


GO
/****** Object:  Table [dbo].[DataStatus]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataStatus](
	[DataStatus] [smallint] NOT NULL,
	[Details] [nvarchar](50) NULL,
 CONSTRAINT [PK_DataStatus] PRIMARY KEY CLUSTERED 
(
	[DataStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Depts]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Depts](
	[SNo] [smallint] NULL,
	[DeptID] [nvarchar](50) NOT NULL,
	[DeptName] [nvarchar](50) NULL,
	[DeptType] [char](1) NULL,
	[DeptCAT] [char](1) NULL,
 CONSTRAINT [PK_Depts] PRIMARY KEY CLUSTERED 
(
	[DeptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dofaInfo]    Script Date: 10/28/2018 2:23:00 AM ******/
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
	[empDOR] [datetime] NULL,
	[empDOJ] [datetime] NULL,
	[empDOL] [datetime] NULL,
	[empGender] [char](1) NULL,
	[empDESG] [nvarchar](50) NULL,
	[empDEPT] [nvarchar](10) NOT NULL,
	[empPAN] [nvarchar](10) NULL,
	[empType] [nvarchar](50) NULL,
	[empCat] [nvarchar](50) NULL,
	[empNation] [nvarchar](50) NULL,
	[QualHighYear] [int] NULL,
	[QualHighCourse] [nvarchar](100) NULL,
	[QualHighInst] [nvarchar](100) NULL,
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
/****** Object:  Table [dbo].[LibInfo]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LibInfo](
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
	[SubscJourDB] [int] NULL,
	[PrintedBooks] [int] NULL,
	[TotalCollection] [int] NULL,
	[FYAddition] [int] NULL,
	[LibMembers] [int] NULL,
	[LibSeatCap] [int] NULL,
	[SemWSOrg] [int] NULL,
	[BooksChMono] [int] NULL,
	[JourPapers] [int] NULL,
	[ConfSympWSPapers] [int] NULL,
	[SciTechReports] [int] NULL,
 CONSTRAINT [PK_LibInfo] PRIMARY KEY CLUSTERED 
(
	[DataCaptYM] ASC,
	[DeptID] ASC,
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MenuIDs]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuIDs](
	[MenuID] [nvarchar](10) NOT NULL,
	[MenuDetails] [nvarchar](100) NULL,
	[MenuUrl] [nvarchar](500) NULL,
	[IsAdminMenu] [bit] NULL,
 CONSTRAINT [PK_MenuIDs] PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RankMesg]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RankMesg](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](max) NULL,
 CONSTRAINT [PK_RankMesg] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RankUsers]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RankUsers](
	[UserID] [nvarchar](20) NOT NULL,
	[UserPassword] [nvarchar](500) NULL,
	[UserEmpNo] [nvarchar](10) NULL,
	[UserName] [nvarchar](50) NULL,
	[DeptID] [nvarchar](10) NULL,
	[UserRole] [nvarchar](20) NULL,
	[UserWork] [nvarchar](20) NULL,
	[UserMob] [nvarchar](10) NULL,
	[UserEmail] [nvarchar](50) NULL,
	[UserValid] [char](1) NULL,
	[UserCreatedOn] [datetime] NULL,
	[UserDisabledOn] [datetime] NULL,
	[UserRemarks] [nvarchar](100) NULL,
	[IsEmailVerified] [bit] NULL,
	[ActivationCode] [uniqueidentifier] NULL,
	[ResetPasswordCode] [nvarchar](100) NULL,
 CONSTRAINT [PK_RankUsers] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sricDEPT]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sricDEPT](
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
	[LogoDesignLicensed] [int] NULL,
 CONSTRAINT [PK_sricDEPT] PRIMARY KEY CLUSTERED 
(
	[DataCaptYM] ASC,
	[DeptID] ASC,
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sricFA]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sricFA](
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
	[ResStaffRA] [int] NULL,
 CONSTRAINT [PK_sricFA] PRIMARY KEY CLUSTERED 
(
	[DataCaptYM] ASC,
	[DeptID] ASC,
	[MenuID] ASC,
	[FAName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[stInfo]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stInfo](
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
	[stMaleUGFT] [int] NULL,
	[stMaleUG5FT] [int] NULL,
	[stMalePGFT] [int] NULL,
	[stMalePGPT] [int] NULL,
	[stFemaleUGFT] [int] NULL,
	[stFemaleUG5FT] [int] NULL,
	[stFemalePGFT] [int] NULL,
	[stFemalePGPT] [int] NULL,
	[stTotalWithinStateUGFT] [int] NULL,
	[stTotalWithinStateUG5FT] [int] NULL,
	[stTotalWithinStatePGFT] [int] NULL,
	[stTotalWithinStatePGPT] [int] NULL,
	[stTotalOutsideStateUGFT] [int] NULL,
	[stTotalOutsideStateUG5FT] [int] NULL,
	[stTotalOutsideStatePGFT] [int] NULL,
	[stTotalOutsideStatePGPT] [int] NULL,
	[stTotalForeignUGFT] [int] NULL,
	[stTotalForeignUG5FT] [int] NULL,
	[stTotalForeignPGFT] [int] NULL,
	[stTotalForeignPGPT] [int] NULL,
	[stEcoBackMaleUGFT] [int] NULL,
	[stEcoBackMaleUG5FT] [int] NULL,
	[stEcoBackMalePGFT] [int] NULL,
	[stEcoBackMalePGPT] [int] NULL,
	[stSocChaFemaleUGFT] [int] NULL,
	[stSocChaFemaleUG5FT] [int] NULL,
	[stSocChaFemalePGFT] [int] NULL,
	[stSocChaFemalePGPT] [int] NULL,
	[stSocChaMaleUGFT] [int] NULL,
	[stSocChaMaleUG5FT] [int] NULL,
	[stSocChaMalePGFT] [int] NULL,
	[stSocChaMalePGPT] [int] NULL,
	[stPHFemaleUGFT] [int] NULL,
	[stPHFemaleUG5FT] [int] NULL,
	[stPHFemalePGFT] [int] NULL,
	[stPHFemalePGPT] [int] NULL,
	[stPHMaleUGFT] [int] NULL,
	[stPHMaleUG5FT] [int] NULL,
	[stPHMalePGFT] [int] NULL,
	[stPHMalePGPT] [int] NULL,
	[stScholarGovFemaleUGFT] [int] NULL,
	[stScholarGovFemaleUG5FT] [int] NULL,
	[stScholarGovFemalePGFT] [int] NULL,
	[stScholarGovFemalePGPT] [int] NULL,
	[stScholarGovMaleUGFT] [int] NULL,
	[stScholarGovMaleUG5FT] [int] NULL,
	[stScholarGovMalePGFT] [int] NULL,
	[stScholarGovMalePGPT] [int] NULL,
	[stScholorInstFemaleUGFT] [int] NULL,
	[stScholorInstFemaleUG5FT] [int] NULL,
	[stScholorInstFemalePGFT] [int] NULL,
	[stScholorInstFemalePGPT] [int] NULL,
	[stScholorInstMaleUGFT] [int] NULL,
	[stScholorInstMaleUG5FT] [int] NULL,
	[stScholorInstMalePGFT] [int] NULL,
	[stScholorInstMalePGPT] [int] NULL,
	[stScholorPvtFemaleUGFT] [int] NULL,
	[stScholorPvtFemaleUG5FT] [int] NULL,
	[stScholorPvtFemalePGFT] [int] NULL,
	[stScholorPvtFemalePGPT] [int] NULL,
	[stScholorPvtMaleUGFT] [int] NULL,
	[stScholorPvtMaleUG5FT] [int] NULL,
	[stScholorPvtMalePGFT] [int] NULL,
	[stScholorPvtMalePGPT] [int] NULL,
	[stNoScholorMaleUGFT] [int] NULL,
	[stNoScholorMaleUG5FT] [int] NULL,
	[stNoScholorMalePGFT] [int] NULL,
	[stNoScholorMalePGPT] [int] NULL,
	[stIntakeMaleUGFT] [int] NULL,
	[stIntakeMaleUG5FT] [int] NULL,
	[stIntakeMalePGFT] [int] NULL,
	[stIntakeMalePGPT] [int] NULL,
	[stAdmitMaleUGFT] [int] NULL,
	[stAdmitMaleUG5FT] [int] NULL,
	[stAdmitMalePGFT] [int] NULL,
	[stAdmitMalePGPT] [int] NULL,
	[stLateralMaleUGFT] [int] NULL,
	[stLateralMaleUG5FT] [int] NULL,
	[stLateralMalePGFT] [int] NULL,
	[stLateralMalePGPT] [int] NULL,
	[stMinGradMaleUGFT] [int] NULL,
	[stMinGradMaleUG5FT] [int] NULL,
	[stMinGradMalePGFT] [int] NULL,
	[stMinGradMalePGPT] [int] NULL,
	[stPlaceMedSalMaleUGFT] [int] NULL,
	[stPlaceMedSalMaleUG5FT] [int] NULL,
	[stPlaceMedSalMalePGFT] [int] NULL,
	[stPlaceMedSalMalePGPT] [int] NULL,
	[stHigherMaleUGFT] [int] NULL,
	[stHigherMaleUG5FT] [int] NULL,
	[stHigherMalePGFT] [int] NULL,
	[stHigherMalePGPT] [int] NULL,
	[stConfNatMaleUGFT] [int] NULL,
	[stConfNatMaleUG5FT] [int] NULL,
	[stConfNatMalePGFT] [int] NULL,
	[stConfNatMalePGPT] [int] NULL,
	[stConfIntMaleUGFT] [int] NULL,
	[stConfIntMaleUG5FT] [int] NULL,
	[stConfIntMalePGFT] [int] NULL,
	[stConfIntMalePGPT] [int] NULL,
	[stPhDFT] [int] NULL,
	[stPhDPT] [int] NULL,
	[stGradPhDFT] [int] NULL,
	[stGradPhDPT] [int] NULL,
 CONSTRAINT [PK_stInfo_1] PRIMARY KEY CLUSTERED 
(
	[DataCaptYM] ASC,
	[DeptID] ASC,
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[stInfo2]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stInfo2](
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
	[stFeeUGNat] [money] NULL,
	[stFeeUGInt] [money] NULL,
	[stFeePGNat] [money] NULL,
	[stFeePGInt] [money] NULL,
	[stFeePHDNat] [money] NULL,
	[stFeePHDInt] [money] NULL,
	[stExchUGInFT] [int] NULL,
	[stExchUGInPT] [int] NULL,
	[stExchPGInFT] [int] NULL,
	[stExchPGInPT] [int] NULL,
	[stExchUGOutFT] [int] NULL,
	[stExchUGOutPT] [int] NULL,
	[stExchPGOutFT] [int] NULL,
	[stExchPGOutPT] [int] NULL,
 CONSTRAINT [PK_stInfo2] PRIMARY KEY CLUSTERED 
(
	[DataCaptYM] ASC,
	[DeptID] ASC,
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserMenu]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserMenu](
	[UserMenuID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [nvarchar](20) NOT NULL,
	[MenuID] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_UserMenuID] PRIMARY KEY CLUSTERED 
(
	[UserMenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[UserRole] [nvarchar](10) NOT NULL,
	[UserRoleDetails] [nvarchar](50) NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[UserRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserWork]    Script Date: 10/28/2018 2:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserWork](
	[UserWork] [nvarchar](10) NOT NULL,
	[UserWorkDetails] [nvarchar](50) NULL,
 CONSTRAINT [PK_UserWork] PRIMARY KEY CLUSTERED 
(
	[UserWork] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (1, N'Data Entry Started by Operator')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (2, N'Data Entry Completed by Operator')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (3, N'Data Checking by HOD')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (4, N'Data Checking Completed by HOD')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (5, N'Data Sent to Asso.DEAN')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (6, N'Data Checked by Asso.DEAN')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (7, N'Data Verified by DEAN')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (8, N'Reserved')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (9, N'Reserved')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (10, N'Data Locked')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (37, N'ADIR', N'ADIR', N'C', N'X')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (1, N'AHEC', N'Alternate Hydro Energy Center', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (2, N'ARCH', N'Architecture & Planning', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (3, N'ASE', N'Applied Science & Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (4, N'BIO', N'Biotechnology', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (5, N'CCE', N'Centre for Continuing Education', N'C', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (6, N'CED', N'CIVIL ENGG', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (7, N'CHED', N'Chemical Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (8, N'CHY', N'Chemistry', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (9, N'COEDMM', N'Centre of Exc. in Disaster Mitigation & Management', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (10, N'CSE', N'Computer Science & Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (11, N'CTS', N'Center for Transportation Systems', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (12, N'DOAA', N'DOAA', N'C', N'X')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (13, N'DOFA', N'DOFA', N'C', N'X')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (14, N'DOMS', N'Management Studies', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (15, N'DORA', N'DORA', N'C', N'X')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (16, N'DOSW', N'DOSW', N'C', N'X')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (17, N'ECE', N'Electronics & Communication Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (18, N'EED', N'Electrical Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (19, N'EQD', N'Earthquake Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (20, N'ESC', N'Earth Sciences', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (21, N'FAO', N'FAO', N'C', N'X')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (22, N'HSS', N'Humanities and Social Sciences', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (23, N'HYD', N'Hydrology', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (24, N'ICC', N'Institute Computer Center', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (25, N'IIC', N'Institute Instrumentation Centre', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (26, N'LIB', N'MGCL', N'A', N'X')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (27, N'MAT', N'Mathematics', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (28, N'MET', N'Metallurgical & Materials Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (29, N'MIED', N'Mechanical & Industrial Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (30, N'NANO', N'Centre of Nanotechnology', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (31, N'PHY', N'Physics', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (32, N'PPE', N'Polymar & Process Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (33, N'PPT', N'Pulp & Paper Technology', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (34, N'QIP', N'QIP', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (35, N'SRIC', N'SRIC', N'C', N'X')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (36, N'WRDM', N'Water Resources Development & Management', N'A', N'S')
GO
SET IDENTITY_INSERT [dbo].[dofaInfo] ON 

GO
INSERT [dbo].[dofaInfo] ([IDNo], [DataCaptYM], [DeptID], [MenuID], [DataUser], [DataUpdatedOn], [DataStatus], [DataStatusLog], [DataValid], [DataLocked], [empNo], [empName], [empDOB], [empDOR], [empDOJ], [empDOL], [empGender], [empDESG], [empDEPT], [empPAN], [empType], [empCat], [empNation], [QualHighYear], [QualHighCourse], [QualHighInst], [ExpAcadMon], [ExpIndMon], [FacExcgIn], [FacExcgOut], [ConfSymSemNat], [ConfSymSemInt], [AwardHonors]) VALUES (1, 201801, N'DOFA', N'DOFA', N'Krishna3', CAST(0x0000A98601457511 AS DateTime), 10, N'Krishna3 Sat, 27 Oct 2018 19:44:57', N'Y', N'N', 1, N'test', CAST(0x0000A98500000000 AS DateTime), NULL, CAST(0x0000A98600000000 AS DateTime), CAST(0x0000A98A00000000 AS DateTime), N'M', N'test', N'AHEC', N'123456', N'test', NULL, N'test', 123, N'test', N'test', 12, 12, N'setset', N'tset', 12, 145, N'12')
GO
INSERT [dbo].[dofaInfo] ([IDNo], [DataCaptYM], [DeptID], [MenuID], [DataUser], [DataUpdatedOn], [DataStatus], [DataStatusLog], [DataValid], [DataLocked], [empNo], [empName], [empDOB], [empDOR], [empDOJ], [empDOL], [empGender], [empDESG], [empDEPT], [empPAN], [empType], [empCat], [empNation], [QualHighYear], [QualHighCourse], [QualHighInst], [ExpAcadMon], [ExpIndMon], [FacExcgIn], [FacExcgOut], [ConfSymSemNat], [ConfSymSemInt], [AwardHonors]) VALUES (2, 201801, N'DOFA', N'DOFA', N'Krishna3', CAST(0x0000A98601457511 AS DateTime), 10, N'Krishna3 Sat, 27 Oct 2018 19:44:57', N'Y', N'N', 2, N'test', CAST(0x0000A98600000000 AS DateTime), NULL, CAST(0x0000A98600000000 AS DateTime), CAST(0x0000A98A00000000 AS DateTime), N'F', N'test', N'AHEC', N'1556', N'test', NULL, N'Test', 159, N'test', N'test', 14, 45, N'test', N'test', 45, 65, N'456')
GO
SET IDENTITY_INSERT [dbo].[dofaInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[LibInfo] ON 

GO
INSERT [dbo].[LibInfo] ([IDNo], [DataCaptYM], [DeptID], [MenuID], [DataUser], [DataUpdatedOn], [DataStatus], [DataStatusLog], [DataValid], [DataLocked], [SubscJourDB], [PrintedBooks], [TotalCollection], [FYAddition], [LibMembers], [LibSeatCap], [SemWSOrg], [BooksChMono], [JourPapers], [ConfSympWSPapers], [SciTechReports]) VALUES (1, 201801, N'AHEC', N'LIBFORM', N'Krishna3', CAST(0x0000A98601346942 AS DateTime), 10, N'Krishna3 Sat, 27 Oct 2018 18:42:53', N'Y', N'N', 12, 12, 45, 65, 98, 32, 85, 84, 45, 9, 12)
GO
INSERT [dbo].[LibInfo] ([IDNo], [DataCaptYM], [DeptID], [MenuID], [DataUser], [DataUpdatedOn], [DataStatus], [DataStatusLog], [DataValid], [DataLocked], [SubscJourDB], [PrintedBooks], [TotalCollection], [FYAddition], [LibMembers], [LibSeatCap], [SemWSOrg], [BooksChMono], [JourPapers], [ConfSympWSPapers], [SciTechReports]) VALUES (4, 201804, N'AHEC', N'LIBFORM', N'BAHEC', CAST(0x0000A98601330B15 AS DateTime), 1, N'BAHEC Sat, 27 Oct 2018 18:37:54', N'Y', N'N', 12, 12, 45, 65, 98, 32, 85, 84, 45, 9, 12)
GO
INSERT [dbo].[LibInfo] ([IDNo], [DataCaptYM], [DeptID], [MenuID], [DataUser], [DataUpdatedOn], [DataStatus], [DataStatusLog], [DataValid], [DataLocked], [SubscJourDB], [PrintedBooks], [TotalCollection], [FYAddition], [LibMembers], [LibSeatCap], [SemWSOrg], [BooksChMono], [JourPapers], [ConfSympWSPapers], [SciTechReports]) VALUES (5, 201807, N'AHEC', N'LIBFORM', N'BAHEC', CAST(0x0000A98601330B15 AS DateTime), 1, N'BAHEC Sat, 27 Oct 2018 18:37:54', N'Y', N'N', 12, 12, 45, 65, 98, 32, 85, 84, 45, 9, 12)
GO
SET IDENTITY_INSERT [dbo].[LibInfo] OFF
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl], [IsAdminMenu]) VALUES (N'ADIR', N'ADIR FORM', N'/Forms/ADIRForm', 0)
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl], [IsAdminMenu]) VALUES (N'DOAA', N'DOAA FORM', N'/Forms/DOAAForm', 0)
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl], [IsAdminMenu]) VALUES (N'DOFA', N'DOFA FORM', N'/Forms/DOFAForm', 0)
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl], [IsAdminMenu]) VALUES (N'DOSW', N'DOSW FORM', N'/Forms/DOSWForm', 0)
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl], [IsAdminMenu]) VALUES (N'LIBFORM', N'LIB FORM', N'/Forms/LIBForm', 0)
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl], [IsAdminMenu]) VALUES (N'MESSAGE', N'RANK MESSAGE', N'/Admin/RankMessage', 1)
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl], [IsAdminMenu]) VALUES (N'REPORTS', N'REPORTS FORM', N'/Admin/ReportsForm', 1)
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl], [IsAdminMenu]) VALUES (N'SRIC', N'SRIC FORM', N'/Forms/SRICForm', 0)
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl], [IsAdminMenu]) VALUES (N'SRICFA', N'SRICFA FORM', N'/Forms/SRICFAForm', 0)
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl], [IsAdminMenu]) VALUES (N'TABLE', N'TABLE DETAIL', N'/Admin/Table', 1)
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl], [IsAdminMenu]) VALUES (N'USERS', N'REGISTER USERS ', N'/Admin/Index', 1)
GO
SET IDENTITY_INSERT [dbo].[RankMesg] ON 

GO
INSERT [dbo].[RankMesg] ([Id], [Message]) VALUES (1, N'Testing Testing Testing Testing TEsting TEsting Test test test')
GO
SET IDENTITY_INSERT [dbo].[RankMesg] OFF
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'admin', N'MTIzNDU2', N'403', N'Administrator', N'admin', N'admin', N'Admin', N'1234567890', N'bhavinvachhani403@gmail.com', N'Y', CAST(0x0000A96400BCEBC7 AS DateTime), NULL, N'', 1, NULL, NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'B0013', N'MTIzNDU2', N'100013', N'BDOAA', N'DOAA', N'User', N'DO', N'1234567890', N'bhavinvachhani403@gmail.com', N'Y', CAST(0x0000A986010AF630 AS DateTime), NULL, N'', 1, N'461562d8-fe1d-44fb-8201-2c29c68d2f9c', NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'B0014', N'MTIzNDU2', N'100014', N'BDOAA HOD', N'DOAA', N'User', N'HOD', N'1234567890', N'bhavinvachhani403@gmail.com', N'Y', CAST(0x0000A986010AF630 AS DateTime), NULL, N'', 1, N'f621955e-b3fa-4e8e-84c7-63a756600059', NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'B003', N'MTIzNDU2', N'100003', N'BADIR', N'ADIR', N'User', N'DO', N'1234567890', N'bhavinvachhani403@gmail.com', N'Y', CAST(0x0000A9860106A26B AS DateTime), NULL, N'', 1, N'cf29a67a-adf1-4e14-a04e-fb414c201d2d', NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'B004', N'MTIzNDU2', N'100004', N'BADIR HOD', N'ADIR', N'User', N'HOD', N'1234567890', N'bhavinvachhani403@gmail.com', N'Y', CAST(0x0000A9860106A26B AS DateTime), NULL, N'', 1, N'a12e6b49-4920-4c56-bdf7-d9ea3c47b57a', NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'B005', N'MTIzNDU2', N'100005', N'BDOFA', N'DOFA', N'User', N'DO', N'1234567890', N'bhavinvachhani403@gmail.com', N'Y', CAST(0x0000A9860106A26B AS DateTime), NULL, N'', 1, N'c44c0181-6ebf-4326-a485-c5e25fa04b69', NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'B006', N'MTIzNDU2', N'100006', N'BDOFA HOD', N'DOFA', N'User', N'HOD', N'1234567890', N'bhavinvachhani403@gmail.com', N'Y', CAST(0x0000A9860106A26B AS DateTime), NULL, N'', 1, N'4b149995-a3ce-4ddd-8158-09e304d1277b', NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'B007', N'MTIzNDU2', N'100007', N'BDOSW', N'DOSW', N'User', N'DO', N'1234567890', N'bhavinvachhani403@gmail.com', N'Y', CAST(0x0000A9860106A26B AS DateTime), NULL, N'', 1, N'710b5933-f289-4e5e-88b2-a6095fc6b085', NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'B008', N'MTIzNDU2', N'100008', N'BDOSW HOD', N'DOSW', N'User', N'HOD', N'1234567890', N'bhavinvachhani403@gmail.com', N'Y', CAST(0x0000A9860106A26B AS DateTime), NULL, N'', 1, N'e93dabef-4df4-41ee-bee4-bcef09ba4a13', NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'B009', N'MTIzNDU2', N'100009', N'BSRIC', N'SRIC', N'User', N'DO', N'1234567890', N'bhavinvachhani403@gmail.com', N'Y', CAST(0x0000A9860106A26B AS DateTime), NULL, N'', 1, N'58d19fb3-ee5b-41ac-8473-8109f0ca0023', NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'B010', N'MTIzNDU2', N'100010', N'BSRIC HOD', N'SRIC', N'User', N'HOD', N'1234567890', N'bhavinvachhani403@gmail.com', N'Y', CAST(0x0000A9860106A26B AS DateTime), NULL, N'', 1, N'79b30e57-f999-46a3-a87a-ddba9b9ddc0c', NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'B011', N'MTIzNDU2', N'100011', N'BAHEC', N'AHEC', N'User', N'DO', N'1234567890', N'bhavinvachhani403@gmail.com', N'Y', CAST(0x0000A9860106A26B AS DateTime), NULL, N'', 1, N'818871a5-4aaa-4156-86c9-9e384e2d3bde', NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'B012', N'MTIzNDU2', N'100012', N'BAHEC HOD', N'AHEC', N'User', N'HOD', N'1234567890', N'bhavinvachhani403@gmail.com', N'Y', CAST(0x0000A9860106A26B AS DateTime), NULL, N'', 1, N'8bc1f417-a146-4d7d-b657-170a190465bd', NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'DEANADSRIC', N'MTIzNDU2', N'788457', N'Krishna2', N'admin', N'User', N'ADSRIC', N'1234567890', N'bhavinvachhani403@gmail.com', N'Y', CAST(0x0000A98600C1028A AS DateTime), NULL, N'', 1, NULL, NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'DEANDSRIC', N'MTIzNDU2', N'788459', N'Krishna3', N'admin', N'User', N'DSRIC', N'1234567890', N'bhavinvachhani403@gmail.com', N'Y', CAST(0x0000A98600C1028A AS DateTime), NULL, N'', 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[stInfo] ON 

GO
INSERT [dbo].[stInfo] ([IDNo], [DataCaptYM], [DeptID], [MenuID], [DataUser], [DataUpdatedOn], [DataStatus], [DataStatusLog], [DataValid], [DataLocked], [stMaleUGFT], [stMaleUG5FT], [stMalePGFT], [stMalePGPT], [stFemaleUGFT], [stFemaleUG5FT], [stFemalePGFT], [stFemalePGPT], [stTotalWithinStateUGFT], [stTotalWithinStateUG5FT], [stTotalWithinStatePGFT], [stTotalWithinStatePGPT], [stTotalOutsideStateUGFT], [stTotalOutsideStateUG5FT], [stTotalOutsideStatePGFT], [stTotalOutsideStatePGPT], [stTotalForeignUGFT], [stTotalForeignUG5FT], [stTotalForeignPGFT], [stTotalForeignPGPT], [stEcoBackMaleUGFT], [stEcoBackMaleUG5FT], [stEcoBackMalePGFT], [stEcoBackMalePGPT], [stSocChaFemaleUGFT], [stSocChaFemaleUG5FT], [stSocChaFemalePGFT], [stSocChaFemalePGPT], [stSocChaMaleUGFT], [stSocChaMaleUG5FT], [stSocChaMalePGFT], [stSocChaMalePGPT], [stPHFemaleUGFT], [stPHFemaleUG5FT], [stPHFemalePGFT], [stPHFemalePGPT], [stPHMaleUGFT], [stPHMaleUG5FT], [stPHMalePGFT], [stPHMalePGPT], [stScholarGovFemaleUGFT], [stScholarGovFemaleUG5FT], [stScholarGovFemalePGFT], [stScholarGovFemalePGPT], [stScholarGovMaleUGFT], [stScholarGovMaleUG5FT], [stScholarGovMalePGFT], [stScholarGovMalePGPT], [stScholorInstFemaleUGFT], [stScholorInstFemaleUG5FT], [stScholorInstFemalePGFT], [stScholorInstFemalePGPT], [stScholorInstMaleUGFT], [stScholorInstMaleUG5FT], [stScholorInstMalePGFT], [stScholorInstMalePGPT], [stScholorPvtFemaleUGFT], [stScholorPvtFemaleUG5FT], [stScholorPvtFemalePGFT], [stScholorPvtFemalePGPT], [stScholorPvtMaleUGFT], [stScholorPvtMaleUG5FT], [stScholorPvtMalePGFT], [stScholorPvtMalePGPT], [stNoScholorMaleUGFT], [stNoScholorMaleUG5FT], [stNoScholorMalePGFT], [stNoScholorMalePGPT], [stIntakeMaleUGFT], [stIntakeMaleUG5FT], [stIntakeMalePGFT], [stIntakeMalePGPT], [stAdmitMaleUGFT], [stAdmitMaleUG5FT], [stAdmitMalePGFT], [stAdmitMalePGPT], [stLateralMaleUGFT], [stLateralMaleUG5FT], [stLateralMalePGFT], [stLateralMalePGPT], [stMinGradMaleUGFT], [stMinGradMaleUG5FT], [stMinGradMalePGFT], [stMinGradMalePGPT], [stPlaceMedSalMaleUGFT], [stPlaceMedSalMaleUG5FT], [stPlaceMedSalMalePGFT], [stPlaceMedSalMalePGPT], [stHigherMaleUGFT], [stHigherMaleUG5FT], [stHigherMalePGFT], [stHigherMalePGPT], [stConfNatMaleUGFT], [stConfNatMaleUG5FT], [stConfNatMalePGFT], [stConfNatMalePGPT], [stConfIntMaleUGFT], [stConfIntMaleUG5FT], [stConfIntMalePGFT], [stConfIntMalePGPT], [stPhDFT], [stPhDPT], [stGradPhDFT], [stGradPhDPT]) VALUES (1, 201801, N'DOAA', N'DOAA', N'Krishna3', CAST(0x0000A9860168E3D9 AS DateTime), 1, N'Krishna3 Sat, 27 Oct 2018 21:53:57', N'Y', N'N', 12, 23, 56, 45, 12, 458, 98, 56, 145, 458, 48, 63, 45, 658, 544, 452, 125, 48, 48, 89, 455, 478, 452, 21, 125, 465, 88, 988, 456, 475, 87, 897, 45, 12, 478, 218, 458, 98, 566, 32, 8, 87, 45, 544, 564, 548, 78, 875, 423, 45, 4654, 654, 64, 64, 64, 564, 654, 623, 463, 334, 46, 54, 64, 6, 465, 423, 425, 64, 65, 456, 432, 654, 56, 465, 434, 654, 65, 456, 432, 564, 523, 465, 456, 56, 56, 523, 655, 543, 54, 54, 54, 523, 632, 56, 532, 65, 65, 632, 523, 632, 23, 232, 434, 322)
GO
INSERT [dbo].[stInfo] ([IDNo], [DataCaptYM], [DeptID], [MenuID], [DataUser], [DataUpdatedOn], [DataStatus], [DataStatusLog], [DataValid], [DataLocked], [stMaleUGFT], [stMaleUG5FT], [stMalePGFT], [stMalePGPT], [stFemaleUGFT], [stFemaleUG5FT], [stFemalePGFT], [stFemalePGPT], [stTotalWithinStateUGFT], [stTotalWithinStateUG5FT], [stTotalWithinStatePGFT], [stTotalWithinStatePGPT], [stTotalOutsideStateUGFT], [stTotalOutsideStateUG5FT], [stTotalOutsideStatePGFT], [stTotalOutsideStatePGPT], [stTotalForeignUGFT], [stTotalForeignUG5FT], [stTotalForeignPGFT], [stTotalForeignPGPT], [stEcoBackMaleUGFT], [stEcoBackMaleUG5FT], [stEcoBackMalePGFT], [stEcoBackMalePGPT], [stSocChaFemaleUGFT], [stSocChaFemaleUG5FT], [stSocChaFemalePGFT], [stSocChaFemalePGPT], [stSocChaMaleUGFT], [stSocChaMaleUG5FT], [stSocChaMalePGFT], [stSocChaMalePGPT], [stPHFemaleUGFT], [stPHFemaleUG5FT], [stPHFemalePGFT], [stPHFemalePGPT], [stPHMaleUGFT], [stPHMaleUG5FT], [stPHMalePGFT], [stPHMalePGPT], [stScholarGovFemaleUGFT], [stScholarGovFemaleUG5FT], [stScholarGovFemalePGFT], [stScholarGovFemalePGPT], [stScholarGovMaleUGFT], [stScholarGovMaleUG5FT], [stScholarGovMalePGFT], [stScholarGovMalePGPT], [stScholorInstFemaleUGFT], [stScholorInstFemaleUG5FT], [stScholorInstFemalePGFT], [stScholorInstFemalePGPT], [stScholorInstMaleUGFT], [stScholorInstMaleUG5FT], [stScholorInstMalePGFT], [stScholorInstMalePGPT], [stScholorPvtFemaleUGFT], [stScholorPvtFemaleUG5FT], [stScholorPvtFemalePGFT], [stScholorPvtFemalePGPT], [stScholorPvtMaleUGFT], [stScholorPvtMaleUG5FT], [stScholorPvtMalePGFT], [stScholorPvtMalePGPT], [stNoScholorMaleUGFT], [stNoScholorMaleUG5FT], [stNoScholorMalePGFT], [stNoScholorMalePGPT], [stIntakeMaleUGFT], [stIntakeMaleUG5FT], [stIntakeMalePGFT], [stIntakeMalePGPT], [stAdmitMaleUGFT], [stAdmitMaleUG5FT], [stAdmitMalePGFT], [stAdmitMalePGPT], [stLateralMaleUGFT], [stLateralMaleUG5FT], [stLateralMalePGFT], [stLateralMalePGPT], [stMinGradMaleUGFT], [stMinGradMaleUG5FT], [stMinGradMalePGFT], [stMinGradMalePGPT], [stPlaceMedSalMaleUGFT], [stPlaceMedSalMaleUG5FT], [stPlaceMedSalMalePGFT], [stPlaceMedSalMalePGPT], [stHigherMaleUGFT], [stHigherMaleUG5FT], [stHigherMalePGFT], [stHigherMalePGPT], [stConfNatMaleUGFT], [stConfNatMaleUG5FT], [stConfNatMalePGFT], [stConfNatMalePGPT], [stConfIntMaleUGFT], [stConfIntMaleUG5FT], [stConfIntMalePGFT], [stConfIntMalePGPT], [stPhDFT], [stPhDPT], [stGradPhDFT], [stGradPhDPT]) VALUES (3, 201804, N'DOAA', N'DOAA', N'BDOAA', CAST(0x0000A986010CB809 AS DateTime), 1, N'BDOAA Sat, 27 Oct 2018 16:18:20', N'Y', N'N', 12, 23, 56, 45, 12, 458, 98, 56, 145, 458, 48, 63, 45, 658, 544, 452, 125, 48, 48, 89, 455, 478, 452, 21, 125, 465, 88, 988, 456, 475, 87, 897, 45, 12, 478, 218, 458, 98, 566, 32, 8, 87, 45, 544, 564, 548, 78, 875, 423, 45, 4654, 654, 64, 64, 64, 564, 654, 623, 463, 334, 46, 54, 64, 6, 465, 423, 425, 64, 65, 456, 432, 654, 56, 465, 434, 654, 65, 456, 432, 564, 523, 465, 456, 56, 56, 523, 655, 543, 54, 54, 54, 523, 632, 56, 532, 65, 65, 632, 523, 632, 23, 232, 434, 322)
GO
INSERT [dbo].[stInfo] ([IDNo], [DataCaptYM], [DeptID], [MenuID], [DataUser], [DataUpdatedOn], [DataStatus], [DataStatusLog], [DataValid], [DataLocked], [stMaleUGFT], [stMaleUG5FT], [stMalePGFT], [stMalePGPT], [stFemaleUGFT], [stFemaleUG5FT], [stFemalePGFT], [stFemalePGPT], [stTotalWithinStateUGFT], [stTotalWithinStateUG5FT], [stTotalWithinStatePGFT], [stTotalWithinStatePGPT], [stTotalOutsideStateUGFT], [stTotalOutsideStateUG5FT], [stTotalOutsideStatePGFT], [stTotalOutsideStatePGPT], [stTotalForeignUGFT], [stTotalForeignUG5FT], [stTotalForeignPGFT], [stTotalForeignPGPT], [stEcoBackMaleUGFT], [stEcoBackMaleUG5FT], [stEcoBackMalePGFT], [stEcoBackMalePGPT], [stSocChaFemaleUGFT], [stSocChaFemaleUG5FT], [stSocChaFemalePGFT], [stSocChaFemalePGPT], [stSocChaMaleUGFT], [stSocChaMaleUG5FT], [stSocChaMalePGFT], [stSocChaMalePGPT], [stPHFemaleUGFT], [stPHFemaleUG5FT], [stPHFemalePGFT], [stPHFemalePGPT], [stPHMaleUGFT], [stPHMaleUG5FT], [stPHMalePGFT], [stPHMalePGPT], [stScholarGovFemaleUGFT], [stScholarGovFemaleUG5FT], [stScholarGovFemalePGFT], [stScholarGovFemalePGPT], [stScholarGovMaleUGFT], [stScholarGovMaleUG5FT], [stScholarGovMalePGFT], [stScholarGovMalePGPT], [stScholorInstFemaleUGFT], [stScholorInstFemaleUG5FT], [stScholorInstFemalePGFT], [stScholorInstFemalePGPT], [stScholorInstMaleUGFT], [stScholorInstMaleUG5FT], [stScholorInstMalePGFT], [stScholorInstMalePGPT], [stScholorPvtFemaleUGFT], [stScholorPvtFemaleUG5FT], [stScholorPvtFemalePGFT], [stScholorPvtFemalePGPT], [stScholorPvtMaleUGFT], [stScholorPvtMaleUG5FT], [stScholorPvtMalePGFT], [stScholorPvtMalePGPT], [stNoScholorMaleUGFT], [stNoScholorMaleUG5FT], [stNoScholorMalePGFT], [stNoScholorMalePGPT], [stIntakeMaleUGFT], [stIntakeMaleUG5FT], [stIntakeMalePGFT], [stIntakeMalePGPT], [stAdmitMaleUGFT], [stAdmitMaleUG5FT], [stAdmitMalePGFT], [stAdmitMalePGPT], [stLateralMaleUGFT], [stLateralMaleUG5FT], [stLateralMalePGFT], [stLateralMalePGPT], [stMinGradMaleUGFT], [stMinGradMaleUG5FT], [stMinGradMalePGFT], [stMinGradMalePGPT], [stPlaceMedSalMaleUGFT], [stPlaceMedSalMaleUG5FT], [stPlaceMedSalMalePGFT], [stPlaceMedSalMalePGPT], [stHigherMaleUGFT], [stHigherMaleUG5FT], [stHigherMalePGFT], [stHigherMalePGPT], [stConfNatMaleUGFT], [stConfNatMaleUG5FT], [stConfNatMalePGFT], [stConfNatMalePGPT], [stConfIntMaleUGFT], [stConfIntMaleUG5FT], [stConfIntMalePGFT], [stConfIntMalePGPT], [stPhDFT], [stPhDPT], [stGradPhDFT], [stGradPhDPT]) VALUES (4, 201807, N'DOAA', N'DOAA', N'BDOAA', CAST(0x0000A986010D2E72 AS DateTime), 1, N'BDOAA Sat, 27 Oct 2018 16:20:03', N'Y', N'N', 12, 23, 56, 45, 12, 458, 98, 56, 145, 458, 48, 63, 45, 658, 544, 452, 125, 48, 48, 89, 455, 478, 452, 21, 125, 465, 88, 988, 456, 475, 87, 897, 45, 12, 478, 218, 458, 98, 566, 32, 8, 87, 45, 544, 564, 548, 78, 875, 423, 45, 4654, 654, 64, 64, 64, 564, 654, 623, 463, 334, 46, 54, 64, 6, 465, 423, 425, 64, 65, 456, 432, 654, 56, 465, 434, 654, 65, 456, 432, 564, 523, 465, 456, 56, 56, 523, 655, 543, 54, 54, 54, 523, 632, 56, 532, 65, 65, 632, 523, 632, 23, 232, 434, 322)
GO
SET IDENTITY_INSERT [dbo].[stInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[stInfo2] ON 

GO
INSERT [dbo].[stInfo2] ([IDNo], [DataCaptYM], [DeptID], [MenuID], [DataUser], [DataUpdatedOn], [DataStatus], [DataStatusLog], [DataValid], [DataLocked], [stFeeUGNat], [stFeeUGInt], [stFeePGNat], [stFeePGInt], [stFeePHDNat], [stFeePHDInt], [stExchUGInFT], [stExchUGInPT], [stExchPGInFT], [stExchPGInPT], [stExchUGOutFT], [stExchUGOutPT], [stExchPGOutFT], [stExchPGOutPT]) VALUES (1, 201801, N'ADIR', N'ADIR', N'BADIR HOD', CAST(0x0000A9860171450C AS DateTime), 1, N'BADIR HOD Sat, 27 Oct 2018 22:24:24', N'Y', N'N', 0.0000, 45.0000, 0.0000, 123.0000, 0.0000, 45.0000, 12, 45, 12, 159, 65, 23, 123, 45)
GO
INSERT [dbo].[stInfo2] ([IDNo], [DataCaptYM], [DeptID], [MenuID], [DataUser], [DataUpdatedOn], [DataStatus], [DataStatusLog], [DataValid], [DataLocked], [stFeeUGNat], [stFeeUGInt], [stFeePGNat], [stFeePGInt], [stFeePHDNat], [stFeePHDInt], [stExchUGInFT], [stExchUGInPT], [stExchPGInFT], [stExchPGInPT], [stExchUGOutFT], [stExchUGOutPT], [stExchPGOutFT], [stExchPGOutPT]) VALUES (2, 201804, N'ADIR', N'ADIR', N'BADIR', CAST(0x0000A98601358678 AS DateTime), 1, N'BADIR Sat, 27 Oct 2018 18:46:56', N'Y', N'N', 0.0000, 89.0000, 0.0000, 12.0000, 0.0000, 65.0000, 12, 45, 12, 159, 65, 23, 123, 45)
GO
INSERT [dbo].[stInfo2] ([IDNo], [DataCaptYM], [DeptID], [MenuID], [DataUser], [DataUpdatedOn], [DataStatus], [DataStatusLog], [DataValid], [DataLocked], [stFeeUGNat], [stFeeUGInt], [stFeePGNat], [stFeePGInt], [stFeePHDNat], [stFeePHDInt], [stExchUGInFT], [stExchUGInPT], [stExchPGInFT], [stExchPGInPT], [stExchUGOutFT], [stExchUGOutPT], [stExchPGOutFT], [stExchPGOutPT]) VALUES (3, 201807, N'ADIR', N'ADIR', N'BADIR', CAST(0x0000A986013522BD AS DateTime), 1, N'BADIR Sat, 27 Oct 2018 18:45:31', N'Y', N'N', 0.0000, 45.0000, 0.0000, 123.0000, 0.0000, 45.0000, 12, 45, 12, 159, 65, 23, 123, 45)
GO
SET IDENTITY_INSERT [dbo].[stInfo2] OFF
GO
SET IDENTITY_INSERT [dbo].[UserMenu] ON 

GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (1, N'admin', N'ALL')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (2, N'deanadsric', N'ALL')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (3, N'deandsric', N'ALL')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (4, N'B003', N'ADIR')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (5, N'B004', N'ADIR')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (6, N'B005', N'DOFA')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (7, N'B006', N'DOFA')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (8, N'B007', N'DOSW')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (9, N'B008', N'DOSW')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (10, N'B009', N'SRIC')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (11, N'B009', N'SRICFA')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (14, N'B011', N'LIBFORM')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (15, N'B012', N'LIBFORM')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (16, N'B010', N'SRIC')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (17, N'B010', N'SRICFA')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (18, N'B0013', N'DOAA')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (19, N'B0014', N'DOAA')
GO
SET IDENTITY_INSERT [dbo].[UserMenu] OFF
GO
INSERT [dbo].[UserRole] ([UserRole], [UserRoleDetails]) VALUES (N'Admin', N'admin')
GO
INSERT [dbo].[UserRole] ([UserRole], [UserRoleDetails]) VALUES (N'User', N'user')
GO
INSERT [dbo].[UserWork] ([UserWork], [UserWorkDetails]) VALUES (N'Admin', N'Admin')
GO
INSERT [dbo].[UserWork] ([UserWork], [UserWorkDetails]) VALUES (N'ADSRIC', N'Asscociate Dean SRIC')
GO
INSERT [dbo].[UserWork] ([UserWork], [UserWorkDetails]) VALUES (N'DO', N'Dataentry Operator')
GO
INSERT [dbo].[UserWork] ([UserWork], [UserWorkDetails]) VALUES (N'DSRIC', N'Dean SRIC')
GO
INSERT [dbo].[UserWork] ([UserWork], [UserWorkDetails]) VALUES (N'HOD', N'Head of the dept Operator')
GO
ALTER TABLE [dbo].[MenuIDs] ADD  DEFAULT ((0)) FOR [IsAdminMenu]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dept and Library' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LibInfo', @level2type=N'COLUMN',@level2name=N'IDNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'for SRIC' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sricDEPT', @level2type=N'COLUMN',@level2name=N'IDNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'for SRIC' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sricFA', @level2type=N'COLUMN',@level2name=N'IDNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'For DOAA' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'stInfo', @level2type=N'COLUMN',@level2name=N'IDNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'For DOSW & ADIR' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'stInfo2', @level2type=N'COLUMN',@level2name=N'IDNo'
GO
USE [master]
GO
ALTER DATABASE [RankTemp] SET  READ_WRITE 
GO
