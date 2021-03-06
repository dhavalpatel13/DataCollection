USE [RANK]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.Bulk_Update_SRIC_DEPT_BY_DataCaptYM','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[Bulk_Update_SRIC_DEPT_BY_DataCaptYM];
END
GO

CREATE PROCEDURE [dbo].[Bulk_Update_SRIC_DEPT_BY_DataCaptYM]
	@sricDeptData SricDeptData readonly,
	@DataCaptYM int
AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
	declare @MenuID nvarchar(10) = 'SRIC';
	declare @result bit = 0;

	IF EXISTS (select top 1 1 from @sricDeptData)
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
				,t1.SRProjQty		   = d1.SRProjQty		  
				,t1.SRFAQty			   = d1.SRFAQty			  
				,t1.SRProjOutlay	   = d1.SRProjOutlay	  
				,t1.SRProjRcp		   = d1.SRProjRcp		  
				,t1.ICProjQty		   = d1.ICProjQty		  
				,t1.ICFAQty			   = d1.ICFAQty			  
				,t1.ICProjOutlay	   = d1.ICProjOutlay	  
				,t1.ICProjRcp		   = d1.ICProjRcp		  
				,t1.ConfSSNat		   = d1.ConfSSNat		  
				,t1.ConfSSNatExp	   = d1.ConfSSNatExp	  
				,t1.ConfSSInt		   = d1.ConfSSInt		  
				,t1.ConfSSIntExp	   = d1.ConfSSIntExp	  
				,t1.IPRFiled		   = d1.IPRFiled		  
				,t1.IPRPub			   = d1.IPRPub			  
				,t1.IPRGranted		   = d1.IPRGranted		  
				,t1.IPRLicensed		   = d1.IPRLicensed		  
				,t1.TechXferFiled	   = d1.TechXferFiled	  
				,t1.TechXferPub		   = d1.TechXferPub		  
				,t1.TechXferGranted	   = d1.TechXferGranted	  
				,t1.TechXferLicensed   = d1.TechXferLicensed  
				,t1.CopyRightsFiled	   = d1.CopyRightsFiled	  
				,t1.CopyRightsPub	   = d1.CopyRightsPub	  
				,t1.CopyRightsGranted  = d1.CopyRightsGranted 
				,t1.CopyRightsLicensed = d1.CopyRightsLicensed
				,t1.LogoDesignFiled	   = d1.LogoDesignFiled	  
				,t1.LogoDesignPub	   = d1.LogoDesignPub	  
				,t1.LogoDesignGranted  = d1.LogoDesignGranted 
				,t1.LogoDesignLicensed = d1.LogoDesignLicensed
			from sricDEPT t1
			inner join @sricDeptData d1 on d1.DataCaptYM=t1.DataCaptYM and d1.MenuID=t1.MenuID and d1.IDNo=t1.IDNo;
		
			insert into sricDEPT (
				DataCaptYM
				,DeptID
				,MenuID
				,DataUser
				,DataUpdatedOn
				,DataStatus
				,DataStatusLog
				,DataValid
				,DataLocked
				,SRProjQty
				,SRFAQty
				,SRProjOutlay
				,SRProjRcp
				,ICProjQty
				,ICFAQty
				,ICProjOutlay
				,ICProjRcp
				,ConfSSNat
				,ConfSSNatExp
				,ConfSSInt
				,ConfSSIntExp
				,IPRFiled
				,IPRPub
				,IPRGranted
				,IPRLicensed
				,TechXferFiled
				,TechXferPub
				,TechXferGranted
				,TechXferLicensed
				,CopyRightsFiled
				,CopyRightsPub
				,CopyRightsGranted
				,CopyRightsLicensed
				,LogoDesignFiled
				,LogoDesignPub
				,LogoDesignGranted
				,LogoDesignLicensed
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
				,SRProjQty
				,SRFAQty
				,SRProjOutlay
				,SRProjRcp
				,ICProjQty
				,ICFAQty
				,ICProjOutlay
				,ICProjRcp
				,ConfSSNat
				,ConfSSNatExp
				,ConfSSInt
				,ConfSSIntExp
				,IPRFiled
				,IPRPub
				,IPRGranted
				,IPRLicensed
				,TechXferFiled
				,TechXferPub
				,TechXferGranted
				,TechXferLicensed
				,CopyRightsFiled
				,CopyRightsPub
				,CopyRightsGranted
				,CopyRightsLicensed
				,LogoDesignFiled
				,LogoDesignPub
				,LogoDesignGranted
				,LogoDesignLicensed
			FROM @sricDeptData
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
