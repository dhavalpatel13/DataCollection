USE [RANK]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.Bulk_Update_SricFA_DATA_BY_DataCaptYM_DeptID','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[Bulk_Update_SricFA_DATA_BY_DataCaptYM_DeptID];
END
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
