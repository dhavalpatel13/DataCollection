/***********************************************************************************************************************
Date		: 21-Sept-2018
*********************************************************************************************************************/

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[stINFO2_INSERT]','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[stINFO2_INSERT]
END
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

