/***********************************************************************************************************************
Date		: 21-Sept-2018
*********************************************************************************************************************/

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[DOAA1_INFO_INSERT]','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[DOAA1_INFO_INSERT]
END
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

