USE [RANK1]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.Bulk_Update_DofaPeer_DATA_BY_DataCaptYM_DeptID','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[Bulk_Update_DofaPeer_DATA_BY_DataCaptYM_DeptID];
END
GO

CREATE PROCEDURE [dbo].[Bulk_Update_DofaPeer_DATA_BY_DataCaptYM_DeptID]
	@DofaPeerInfo DofaPeerData readonly,
	@DataCaptYM int,
	@DeptID nvarchar(10)
AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
	declare @MenuID nvarchar(10) = 'DOFAPEER';
	declare @result bit = 0;

	IF EXISTS (select top  1 1 from @DofaPeerInfo)
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION;

				UPDATE t1
				SET 
				 t1.DataUser		= d1.DataUser
				,t1.DataUpdatedOn	= GETDATE()
				,t1.DataStatus		= d1.DataStatus
				,t1.DataStatusLog	= d1.DataStatusLog	
				,t1.DataValid		= d1.DataValid		
				,t1.DataLocked		= d1.DataLocked
				,t1.empNo			= d1.empNo
				,t1.PeerNo			= d1.PeerNo
				,t1.PeerType		= d1.PeerType
				,t1.PeerTitle		= d1.PeerTitle
				,t1.PeerFName		= d1.PeerFName
				,t1.PeerLName		= d1.PeerLName
				,t1.PeerJob			= d1.PeerJob
				,t1.PeerDept		= d1.PeerDept
				,t1.PeerInst		= d1.PeerInst
				,t1.PeerCountry		= d1.PeerCountry
				,t1.PeerEmail		= d1.PeerEmail
				,t1.PeerMob			= d1.PeerMob
				,t1.PeerDetails		= d1.PeerDetails	
				,t1.PeerRemarks		= d1.PeerRemarks				
				FROM DofaPeer t1
				INNER JOIN @DofaPeerInfo d1 on d1.DataCaptYM=t1.DataCaptYM and d1.DeptID=t1.DeptID and d1.MenuID=t1.MenuID 
				AND d1.IDNo=t1.IDNo;
		
			INSERT INTO DofaPeer
			(
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
				,PeerNo
				,PeerType
				,PeerTitle
				,PeerFName
				,PeerLName
				,PeerJob
				,PeerDept
				,PeerInst
				,PeerCountry
				,PeerEmail
				,PeerMob
				,PeerDetails
				,PeerRemarks
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
				,PeerNo
				,PeerType
				,PeerTitle
				,PeerFName
				,PeerLName
				,PeerJob
				,PeerDept
				,PeerInst
				,PeerCountry
				,PeerEmail
				,PeerMob
				,PeerDetails
				,PeerRemarks
			FROM @DofaPeerInfo
			WHERE IDNo = 0 and DataCaptYM = @DataCaptYM AND DeptID = @DeptID AND MenuID = @MenuID;

			IF (@@TRANCOUNT > 0)
			BEGIN
				set @result = 1;          
			END 

			COMMIT TRANSACTION;		

		END TRY
		BEGIN CATCH
			print 1
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

	SELECT @result;

END
GO
