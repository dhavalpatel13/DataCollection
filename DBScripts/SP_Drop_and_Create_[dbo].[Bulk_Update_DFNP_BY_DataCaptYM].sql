USE [RANK1]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.Bulk_Update_DFNP_BY_DataCaptYM','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[Bulk_Update_DFNP_BY_DataCaptYM];
END
GO

CREATE PROCEDURE [dbo].[Bulk_Update_DFNP_BY_DataCaptYM]
	@FinInfoData FinInfoData readonly,
	@DataCaptYM int
AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
	declare @MenuID nvarchar(10) = 'DFNP';
	declare @result bit = 0;

	IF EXISTS (select top 1 1 from @FinInfoData)
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
				,t1.FinYear = d1.FinYear
				,t1.ExpCapAAR = d1.ExpCapAAR
				,t1.ExpLibOverall = d1.ExpLibOverall
				,t1.ExpLibEngg = d1.ExpLibEngg
				,t1.ExpLibMgmt = d1.ExpLibMgmt
				,t1.ExpLibArch = d1.ExpLibArch
				,t1.ExpNewEqpLabs = d1.ExpNewEqpLabs
				,t1.ExpEnggWS = d1.ExpEnggWS
				,t1.ExpStudios = d1.ExpStudios
				,t1.ExpOtherCapAssets = d1.ExpOtherCapAssets
				,t1.ExpOperational = d1.ExpOperational
				,t1.ExpMaintRun = d1.ExpMaintRun
				,t1.ExpSalT = d1.ExpSalT
				,t1.ExpSalNT = d1.ExpSalNT
				,t1.ExpMisc1 = d1.ExpMisc1
				,t1.ExpMisc2 = d1.ExpMisc2
				,t1.ExpTotal = d1.ExpTotal
				,t1.ExpRemarks = d1.ExpRemarks
				,t1.SchFsUGFT = d1.SchFsUGFT
				,t1.SchFsUG5FT = d1.SchFsUG5FT
				,t1.SchFsPGFT = d1.SchFsPGFT
				,t1.SchFsPGPT = d1.SchFsPGPT
				,t1.SchSSUGFT = d1.SchSSUGFT
				,t1.SchSSUG5FT = d1.SchSSUG5FT
				,t1.SchSSPGFT = d1.SchSSPGFT
				,t1.SchSSPGPT = d1.SchSSPGPT
				,t1.SchTotal = d1.SchTotal
				,t1.SchRemarks = d1.SchRemarks
			from FinInfo t1
			inner join @FinInfoData d1 on d1.DataCaptYM=t1.DataCaptYM and d1.MenuID=t1.MenuID and d1.IDNo=t1.IDNo;
		
			insert into FinInfo(
				DataCaptYM
				,DeptID
				,MenuID
				,DataUser
				,DataUpdatedOn
				,DataStatus
				,DataStatusLog
				,DataValid
				,DataLocked
				,FinYear,ExpCapAAR,ExpLibOverall,ExpLibEngg,ExpLibMgmt,ExpLibArch
				,ExpNewEqpLabs,ExpEnggWS,ExpStudios,ExpOtherCapAssets,ExpOperational
				,ExpMaintRun,ExpSalT,ExpSalNT,ExpMisc1,ExpMisc2,ExpTotal,ExpRemarks
				,SchFsUGFT,SchFsUG5FT,SchFsPGFT,SchFsPGPT,SchSSUGFT
				,SchSSUG5FT,SchSSPGFT,SchSSPGPT,SchTotal,SchRemarks
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
				,FinYear,ExpCapAAR,ExpLibOverall,ExpLibEngg,ExpLibMgmt,ExpLibArch
				,ExpNewEqpLabs,ExpEnggWS,ExpStudios,ExpOtherCapAssets,ExpOperational
				,ExpMaintRun,ExpSalT,ExpSalNT,ExpMisc1,ExpMisc2,ExpTotal,ExpRemarks
				,SchFsUGFT,SchFsUG5FT,SchFsPGFT,SchFsPGPT,SchSSUGFT
				,SchSSUG5FT,SchSSPGFT,SchSSPGPT,SchTotal,SchRemarks
			FROM @FinInfoData
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
