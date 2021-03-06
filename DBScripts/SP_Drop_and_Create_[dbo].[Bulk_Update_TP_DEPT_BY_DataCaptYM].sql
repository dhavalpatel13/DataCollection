USE [RANK1]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.Bulk_Update_TP_DEPT_BY_DataCaptYM','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[Bulk_Update_TP_DEPT_BY_DataCaptYM];
END
GO

CREATE PROCEDURE [dbo].[Bulk_Update_TP_DEPT_BY_DataCaptYM]
	@TpDeptData TpDeptData readonly,
	@DataCaptYM int
AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
	declare @MenuID nvarchar(10) = 'TPDEPT';
	declare @result bit = 0;

	IF EXISTS (select top 1 1 from @TpDeptData)
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
				,t1.StRegUGFT = d1.StRegUGFT
				,t1.StOfferUGFT = d1.StOfferUGFT
				,t1.StHighSalUGFT = d1.StHighSalUGFT
				,t1.StMedianSalUGFT = d1.StMedianSalUGFT
				,t1.StLowestSalUGFT = d1.StLowestSalUGFT
				,t1.StRegUG5FT = d1.StRegUG5FT
				,t1.StOfferUG5FT = d1.StOfferUG5FT
				,t1.StHighSalUG5FT = d1.StHighSalUG5FT
				,t1.StMedianSalUG5FT = d1.StMedianSalUG5FT
				,t1.StLowestSalUG5FT = d1.StLowestSalUG5FT
				,t1.StRegPGFT = d1.StRegPGFT
				,t1.StOfferPGFT = d1.StOfferPGFT
				,t1.StHighSalPGFT = d1.StHighSalPGFT
				,t1.StMedianSalPGFT = d1.StMedianSalPGFT
				,t1.StLowestSalPGFT = d1.StLowestSalPGFT
				,t1.StRegPGPT = d1.StRegPGPT
				,t1.StOfferPGPT = d1.StOfferPGPT
				,t1.StHighSalPGPT = d1.StHighSalPGPT
				,t1.StMedianSalPGPT = d1.StMedianSalPGPT
				,t1.StLowestSalPGPT = d1.StLowestSalPGPT
			from TpDEPT t1
			inner join @TpDeptData d1 on d1.DataCaptYM=t1.DataCaptYM and d1.MenuID=t1.MenuID and d1.IDNo=t1.IDNo;
		
			insert into TpDEPT(
				DataCaptYM
				,DeptID
				,MenuID
				,DataUser
				,DataUpdatedOn
				,DataStatus
				,DataStatusLog
				,DataValid
				,DataLocked
				,StRegUGFT,StOfferUGFT,StHighSalUGFT,StMedianSalUGFT,StLowestSalUGFT
				,StRegUG5FT,StOfferUG5FT,StHighSalUG5FT,StMedianSalUG5FT,StLowestSalUG5FT
				,StRegPGFT,StOfferPGFT,StHighSalPGFT,StMedianSalPGFT,StLowestSalPGFT
				,StRegPGPT,StOfferPGPT,StHighSalPGPT,StMedianSalPGPT,StLowestSalPGPT
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
				,StRegUGFT,StOfferUGFT,StHighSalUGFT,StMedianSalUGFT,StLowestSalUGFT
				,StRegUG5FT,StOfferUG5FT,StHighSalUG5FT,StMedianSalUG5FT,StLowestSalUG5FT
				,StRegPGFT,StOfferPGFT,StHighSalPGFT,StMedianSalPGFT,StLowestSalPGFT
				,StRegPGPT,StOfferPGPT,StHighSalPGPT,StMedianSalPGPT,StLowestSalPGPT
			FROM @TpDeptData
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
