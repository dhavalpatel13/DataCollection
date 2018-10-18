/***********************************************************************************************************************
Date		: 21-Sept-2018
*********************************************************************************************************************/

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[stINFO2_UPDATE]','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[stINFO2_UPDATE]
END
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

