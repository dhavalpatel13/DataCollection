USE [RANK]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.Rpt_SELECT_BY_DataCaptYM_DeptID','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[Rpt_SELECT_BY_DataCaptYM_DeptID];
END
GO

CREATE PROCEDURE [dbo].[Rpt_SELECT_BY_DataCaptYM_DeptID]
	@DataCaptYM int,
	@MenuID nvarchar(10),
	@DeptID nvarchar(10) = ''
AS
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SET @DeptID = ISNULL(@DeptID,'');

	IF(@MenuID='DOFA')
	BEGIN
		SELECT 
		 info.IDNo as 'IDNo'
		,info.empNo as 'EmpNo'
		,info.empName as 'Name of Faculty Members (FC)'
		,(CASE WHEN info.empDOB is NULL then '' ELSE REPLACE(CONVERT(NVARCHAR,CAST(info.empDOB AS DATETIME), 106), ' ', '-') END) as 'DOB'
		,info.empDESG as 'Designation'
		,info.empGender as 'Gender'
		,info.empNation as 'Nationality'
		,info.QualHighCourse as 'Highest Qualification - Course'
		,info.QualHighYear as 'Highest Qualification - Year'
		,info.QualHighInst as 'Highest Qualification - Institute'
		,info.empPAN as 'PAN No.'
		,info.ExpIndMon as 'Industry Experience (in Years)'
		,info.ExpAcadMon as 'Academic Experience(in Months)'
		,dp.DeptName as 'Department'
		,(CASE WHEN info.empDOJ is NULL then '' ELSE REPLACE(CONVERT(NVARCHAR,CAST(info.empDOJ AS DATETIME), 106), ' ', '-') END) as 'Institute Joining Date'
		,(CASE WHEN info.empDOL is NULL then '' ELSE REPLACE(CONVERT(NVARCHAR,CAST(info.empDOL AS DATETIME), 106), ' ', '-') END) as 'Leaving Date (as on date)'
		,info.empType as 'Association Type'
		,info.FacExcgIn as 'Faculty Exchange Inbound'
		,info.FacExcgOut as 'Faculty Exchange Outbound'
		,info.ConfSymSemNat as 'No. of Conference / Symposia / Seminars National'
		,info.ConfSymSemInt as 'No. of Conference / Symposia / Seminars International'
		,info.AwardHonors as 'Awards and Honors'
		FROM dofaInfo as info
		INNER JOIN Depts as dp on info.empDEPT = dp.DeptID
		WHERE DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID
		AND (@DeptID = '' OR info.empDEPT = @DeptID);

	END
	ELSE IF(@MenuID='SRICFA')
	BEGIN
		SELECT 
		 info.IDNo as 'IDNo'
		,info.FAName as 'Organization / Agency Name'
		,info.FASRProjQty as 'No. of Projects (SR)'
		,info.FASRProjOutlay as 'Outlay (SR)'
		,info.FASRProjRcp as 'Receipt (SR)'
		,info.FAICProjQty as 'No. of Projects (IC)'
		,info.FAICProjOutlay as 'Outlay (IC)'
		,info.FAICProjRcp as 'Receipt (IC)'
		,info.ResStaffNPDF as 'N-PDF'
		,info.ResStaffPC as 'Project Consultant'
		,info.ResStaffPF as 'Project Fellow'
		,info.ResStaffRA as 'Research Associate'
		,info.ResStaffRFSR as 'JRF/SRF/Fellow (SR)'
		FROM sricFA as info
		WHERE DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID

	END
	ELSE IF(@MenuID='LIBFORM')
	BEGIN

		SELECT 
		 info.IDNo as 'IDNo'
		,dp.DeptName as 'Place'
		,info.SubscJourDB as 'No. Subscription of Journals & Databases'
		,info.PrintedBooks as 'No. of Printed Books'
		,info.TotalCollection as 'Total Collection'
		,info.FYAddition as 'Additions in Financial Year'
		,info.LibMembers as 'No. of Library Membership'
		,info.LibSeatCap as 'Seating Capacity'
		,info.SemWSOrg as 'No. of Seminars/ Workshops organized by MGCL'
		,info.BooksChMono as 'Books/ Chapters in books/ monograph'
		,info.JourPapers as 'Papers in Journals'
		,info.ConfSympWSPapers as 'Papers in Conferences/ Symposia/ Seminar/ Workshop'
		,info.SciTechReports as 'Scientific & Technical Reports'
		FROM LibInfo as info
		inner join Depts as dp on info.DeptID = dp.DeptID
		WHERE DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND (@DeptID = '' OR info.DeptID = @DeptID); 

	END
END

GO
