/***********************************************************************************************************************
Date		: 21-Sept-2018
*********************************************************************************************************************/

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[LIBINFO_UPDATE]','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[LIBINFO_UPDATE]
END
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

