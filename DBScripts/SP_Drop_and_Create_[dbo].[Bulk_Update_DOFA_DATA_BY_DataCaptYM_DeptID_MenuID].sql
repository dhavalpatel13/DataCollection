USE [RANK]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.Bulk_Update_DOFA_DATA_BY_DataCaptYM_DeptID_MenuID','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[Bulk_Update_DOFA_DATA_BY_DataCaptYM_DeptID_MenuID];
END
GO

CREATE PROCEDURE [dbo].[Bulk_Update_DOFA_DATA_BY_DataCaptYM_DeptID_MenuID]
	@dofaData DofaData readonly,
	@DataCaptYM int,
	@DeptID nvarchar(10),
	@empDept nvarchar(10) = ''
AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
	declare @MenuID nvarchar(10) = 'DOFA';
	declare @result bit = 0;

	IF EXISTS (select top  1 1 from @dofaData)
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
				,t1.empNo			= d1.empNo
				,t1.empName			= d1.empName			
				,t1.empDOB			= d1.empDOB				
				,t1.empDOJ			= d1.empDOJ			
				,t1.empDOL			= d1.empDOL			
				,t1.empGender		= d1.empGender		
				,t1.empDESG			= d1.empDESG			
				,t1.empPAN			= d1.empPAN			
				,t1.empType			= d1.empType		
				,t1.empCat		    = d1.empCat			
				,t1.empNation		= d1.empNation		
				,t1.QualHighYear	= d1.QualHighYear	
				,t1.QualHighCourse	= d1.QualHighCourse	
				,t1.QualHighInst	= d1.QualHighInst	
				,t1.ExpAcadMon		= d1.ExpAcadMon		
				,t1.ExpIndMon		= d1.ExpIndMon		
				,t1.FacExcgIn		= d1.FacExcgIn		
				,t1.FacExcgOut		= d1.FacExcgOut		
				,t1.ConfSymSemNat	= d1.ConfSymSemNat	
				,t1.ConfSymSemInt	= d1.ConfSymSemInt	
				,t1.AwardHonors		= d1.AwardHonors 
			from dofaInfo t1
			inner join @dofaData d1 on d1.DataCaptYM=t1.DataCaptYM and d1.DeptID=t1.DeptID and d1.MenuID=t1.MenuID 
			and d1.IDNo=t1.IDNo and d1.empDEPT = t1.empDEPT and d1.IDNo > 0;
		
			insert into dofaInfo(
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
				,empName
				,empDOB
				,empDOJ
				,empDOL
				,empGender
				,empDESG
				,empDEPT
				,empPAN
				,empType
				,empCat
				,empNation
				,QualHighYear
				,QualHighCourse
				,QualHighInst
				,ExpAcadMon
				,ExpIndMon
				,FacExcgIn
				,FacExcgOut
				,ConfSymSemNat
				,ConfSymSemInt
				,AwardHonors
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
				,empName
				,empDOB
				,empDOJ
				,empDOL
				,empGender
				,empDESG
				,empDEPT
				,empPAN
				,empType
				,empCat
				,empNation
				,QualHighYear
				,QualHighCourse
				,QualHighInst
				,ExpAcadMon
				,ExpIndMon
				,FacExcgIn
				,FacExcgOut
				,ConfSymSemNat
				,ConfSymSemInt
				,AwardHonors
			FROM @dofaData
			WHERE IDNo = 0 and DataCaptYM = @DataCaptYM AND empDEPT = @empDept AND DeptID = @DeptID AND MenuID = @MenuID;

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
