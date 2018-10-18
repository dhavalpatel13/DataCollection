/***********************************************************************************************************************
Date		: 21-Sept-2018
*********************************************************************************************************************/

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[LIBINFO_INSERT]','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[LIBINFO_INSERT]
END
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

