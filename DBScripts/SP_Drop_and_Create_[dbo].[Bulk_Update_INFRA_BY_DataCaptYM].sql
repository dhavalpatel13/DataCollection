USE [RANK]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.Bulk_Update_INFRA_BY_DataCaptYM','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[Bulk_Update_INFRA_BY_DataCaptYM];
END
GO

CREATE PROCEDURE [dbo].[Bulk_Update_INFRA_BY_DataCaptYM]
	@InfraDeptData InfraDeptData readonly,
	@InfraInfoData InfraInfoData readonly,
	@DataCaptYM int,
	@IsSaveInfraInfo bit
AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
	declare @MenuID nvarchar(10) = 'INFRA';
	declare @result bit = 0;

	IF EXISTS (select top 1 1 from @InfraDeptData) and EXISTS (select top 1 1 from @InfraInfoData)
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION;

			UPDATE t1
			SET t1.DataUser		   = d1.DataUser
			,t1.DataUpdatedOn	   = GETDATE()
			,t1.DataStatus		   = d1.DataStatus
			,t1.DataStatusLog	   = d1.DataStatusLog	
			,t1.DataValid		   = d1.DataValid		
			,t1.DataLocked		   = d1.DataLocked		
			,t1.ClassRooms = d1.ClassRooms
			,t1.Labs = d1.Labs
			,t1.Auditoriums = d1.Auditoriums
			,t1.ConfRooms = d1.ConfRooms
			,t1.FaclCabins = d1.FaclCabins
			,t1.CompLabs = d1.CompLabs
			,t1.SplLabs = d1.SplLabs
			,t1.OtherLabs = d1.OtherLabs
			from InfraDEPT t1
			inner join @InfraDeptData d1 on d1.DataCaptYM=t1.DataCaptYM 
			and d1.MenuID=t1.MenuID and d1.IDNo=t1.IDNo;
		
			insert into InfraDEPT(
				DataCaptYM
				,DeptID
				,MenuID
				,DataUser
				,DataUpdatedOn
				,DataStatus
				,DataStatusLog
				,DataValid
				,DataLocked
				,ClassRooms,Labs,Auditoriums,ConfRooms
				,FaclCabins,CompLabs,SplLabs,OtherLabs
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
				,ClassRooms,Labs,Auditoriums,ConfRooms
				,FaclCabins,CompLabs,SplLabs,OtherLabs
			FROM @InfraDeptData
			WHERE IDNo = 0 and DataCaptYM = @DataCaptYM AND MenuID = @MenuID;

			IF @IsSaveInfraInfo = 1
			BEGIN
				UPDATE t1
				SET t1.DataUser		= d1.DataUser
				,t1.DataUpdatedOn	= GETDATE()
				,t1.DataStatus		= d1.DataStatus
				,t1.DataStatusLog	= d1.DataStatusLog	
				,t1.DataValid		= d1.DataValid		
				,t1.DataLocked		= d1.DataLocked		
				,t1.InfraDetails	= d1.InfraDetails
				,t1.InfraRemarks    = d1.InfraRemarks
				from InfraInfo t1
				inner join @InfraInfoData d1 on d1.DataCaptYM=t1.DataCaptYM 
				and d1.MenuID=t1.MenuID and d1.IDNo=t1.IDNo;
		
				insert into InfraInfo(
					DataCaptYM
					,DeptID
					,MenuID
					,DataUser
					,DataUpdatedOn
					,DataStatus
					,DataStatusLog
					,DataValid
					,DataLocked
					,InfraNo ,InfraDescr ,InfraDetails ,InfraRemarks
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
					,InfraNo ,InfraDescr ,InfraDetails ,InfraRemarks
				FROM @InfraInfoData
				WHERE IDNo = 0 and DataCaptYM = @DataCaptYM AND MenuID = @MenuID;
			END
			


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
