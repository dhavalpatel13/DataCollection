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
		WHERE DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID;

	END

	ELSE IF(@MenuID='SRIC')
	BEGIN
		SELECT d.DeptName as [Department - Sponsored Research Projects (Deptt.-wise)]
		,sr.SRProjQty as [No. of Project]
		,sr.SRFAQty as [Total No. of Funding Agencies]
		,sr.SRProjOutlay as [Total Outlay]
		,sr.SRProjRcp as [Total Receipt] -- block 1
		FROM Depts d
		LEFT JOIN sricDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
		WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
		ORDER BY DeptName;

		SELECT d.DeptName as [Department - Consultancy Projects (Deptt.-wise)]
		,sr.ICProjQty as [No. of Project]
		,sr.ICFAQty as [Total No. of Sponsors]
		,sr.ICProjOutlay as [Contracted Amount]
		,sr.ICProjRcp as [Actual Receipt] -- block 2
		FROM Depts d
		LEFT JOIN sricDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
		WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
		ORDER BY DeptName;

		SELECT d.DeptName as [Department - Conference / Symposia / Seminars]
		,sr.ConfSSNat as [National]
		,sr.ConfSSNatExp as [Expenditure]
		,sr.ConfSSInt as [International]
		,sr.ConfSSIntExp as [Total Expenditure] -- block 3
		FROM Depts d
		LEFT JOIN sricDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
		WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
		ORDER BY DeptName;

		SELECT d.DeptName as [Details of Intellectual Property]
		,sr.IPRFiled as [Patents Filed]
		,sr.IPRPub as [Patent Published]
		,sr.IPRGranted as [Patent Granted]
		,sr.IPRLicensed as [Patent Licensed] -- block 4
		FROM Depts d
		LEFT JOIN sricDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
		WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
		ORDER BY DeptName;

		SELECT d.DeptName as [Details of Technology Transfer]
		,sr.TechXferFiled as [Filed]
		,sr.TechXferPub as [Published]
		,sr.TechXferGranted as [Granted]
		,sr.TechXferLicensed as [Licensed] -- block 5
		FROM Depts d
		LEFT JOIN sricDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
		WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
		ORDER BY DeptName;

		SELECT d.DeptName as [Details of Logo/Design Copy Rights]
		,sr.CopyRightsFiled as [Filed]
		,sr.CopyRightsPub as [Published]
		,sr.CopyRightsGranted as [Granted]
		,sr.CopyRightsLicensed as [Licensed] -- block 6
		FROM Depts d
		LEFT JOIN sricDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
		WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
		ORDER BY DeptName;

		SELECT d.DeptName as [Details of Copy Rights]
		,sr.LogoDesignFiled as [Filed]
		,sr.LogoDesignPub as [Published]
		,sr.LogoDesignGranted as [Granted]
		,sr.LogoDesignLicensed as [Licensed] -- block 7
		FROM Depts d
		LEFT JOIN sricDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
		WHERE d.DeptCAT = 'S' AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
		ORDER BY DeptName;

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

	ELSE IF(@MenuID='ADIR')
	BEGIN

		create table #adir1
		(
			[Tuition Fees] nvarchar(max),
			[International] money
		);

		insert into #adir1 
		select top 1 'Undergraduate Fees (US $)' as [Tuition Fees],
		stFeeUGInt as [International]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID; 

		insert into #adir1 
		select top 1 'Postgraduate Fees (US $)' as [Tuition Fees],
		stFeePGInt as [International]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID; 

		insert into #adir1 
		select top 1 'Ph.D (US $)' as [Tuition Fees],
		stFeePHDInt as [International]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID;

		create table #adir2
		(
			[Regional Rankings Indicator] nvarchar(max),
			[Full Time] int,
			[Part Time] int
		);

		insert into #adir2
		select top 1 'Undergraduate Exchange Students - Inbound' as [Regional Rankings Indicator],
		stExchUGInFT as [Full Time],
		stExchUGInPT as [Part Time]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID; 

		insert into #adir2
		select top 1 'Undergraduate Exchange Students - Outbound' as [Regional Rankings Indicator],
		stExchUGOutFT as [Full Time],
		stExchUGOutPT as [Part Time]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID; 

		insert into #adir2
		select top 1 'Postgraduate Exchange Students - Inbound' as [Regional Rankings Indicator],
		stExchPGInFT as [Full Time],
		stExchPGInPT as [Part Time]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID; 

		insert into #adir2
		select top 1 'Postgraduate Exchange Students - Outbound' as [Regional Rankings Indicator],
		stExchPGOutFT as [Full Time],
		stExchPGOutPT as [Part Time]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID; 

		select * from #adir1;
		select * from #adir2;

	END

	ELSE IF(@MenuID='DOSW')
	BEGIN

		create table #dosw
		(
			[Tuition Fees] nvarchar(max),
			[Domestic] money
		);

		insert into #dosw 
		select top 1 'Undergraduate Fees (INR)' as [Tuition Fees],
		stFeeUGNat as [Domestic]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID; 

		insert into #dosw 
		select top 1 'Postgraduate Fees (INR)' as [Tuition Fees],
		stFeePGNat as [Domestic]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID; 

		insert into #dosw 
		select top 1 'Ph.D (INR)' as [Tuition Fees],
		stFeePHDNat as [Domestic]
		from stInfo2 as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = @DeptID;

		select * from #dosw;

	END

	ELSE IF(@MenuID='DOAA')
	BEGIN

		create table #doaa1
		(
			[Details of Students] nvarchar(max),
			[UG] int,
			[UG-5YRS] int,
			[PG-FT] int,
			[PG-PT] int
		);

		insert into #doaa1
		select top 1 'No. of Male Students' as [Details of Students],
		stMaleUGFT as [UG],
		stMaleUG5FT as [UG-5YRS],
		stMalePGFT as [PG-FT],
		stMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of Female Students' as [Details of Students],
		stFemaleUGFT as [UG],
		stFemaleUG5FT as [UG-5YRS],
		stFemalePGFT as [PG-FT],
		stFemalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Total Students Within State (Including male & female)' as [Details of Students],
		stTotalWithinStateUGFT as [UG],
		stTotalWithinStateUG5FT as [UG-5YRS],
		stTotalWithinStatePGFT as [PG-FT],
		stTotalWithinStatePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Outside State (Including male & female)' as [Details of Students],
		stTotalOutsideStateUGFT as [UG],
		stTotalOutsideStateUG5FT as [UG-5YRS],
		stTotalOutsideStatePGFT as [PG-FT],
		stTotalOutsideStatePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Outside Country (Including male & female)' as [Details of Students],
		stTotalForeignUGFT as [UG],
		stTotalForeignUG5FT as [UG-5YRS],
		stTotalForeignPGFT as [PG-FT],
		stTotalForeignPGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Economically Backward (Including male & female)' as [Details of Students],
		stEcoBackMaleUGFT as [UG],
		stEcoBackMaleUG5FT as [UG-5YRS],
		stEcoBackMalePGFT as [PG-FT],
		stEcoBackMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Socially Challenged (SC+ST+OBC Female)' as [Details of Students],
		stSocChaFemaleUGFT as [UG],
		stSocChaFemaleUG5FT as [UG-5YRS],
		stSocChaFemalePGFT as [PG-FT],
		stSocChaFemalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Socially Challenged (SC+ST+OBC Male)' as [Details of Students],
		stSocChaFemaleUGFT as [UG],
		stSocChaFemaleUG5FT as [UG-5YRS],
		stSocChaFemalePGFT as [PG-FT],
		stSocChaFemalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Physically Challenged (SC+ST+OBC Female)' as [Details of Students],
		stPHFemaleUGFT as [UG],
		stPHFemaleUG5FT as [UG-5YRS],
		stPHFemalePGFT as [PG-FT],
		stPHFemalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Physically Challenged (SC+ST+OBC Male)' as [Details of Students],
		stPHMaleUGFT as [UG],
		stPHMaleUG5FT as [UG-5YRS],
		stPHMalePGFT as [PG-FT],
		stPHMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of students receiving Freeships /Scholarships from the State and Central Government (Female)' as [Details of Students],
		stScholarGovFemaleUGFT as [UG],
		stScholarGovFemaleUG5FT as [UG-5YRS],
		stScholarGovFemalePGFT as [PG-FT],
		stScholarGovFemalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of students receiving Freeships /Scholarships from the State and Central Government (Male)' as [Details of Students],
		stScholarGovMaleUGFT as [UG],
		stScholarGovMaleUG5FT as [UG-5YRS],
		stScholarGovMalePGFT as [PG-FT],
		stScholarGovMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of students receiving Freeships /Scholarships from Institution (Female)' as [Details of Students],
		stScholorInstFemaleUGFT as [UG],
		stScholorInstFemaleUG5FT as [UG-5YRS],
		stScholorInstFemalePGFT as [PG-FT],
		stScholorInstFemalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of students receiving Freeships /Scholarships from Institution (Male)' as [Details of Students],
		stScholorInstMaleUGFT as [UG],
		stScholorInstMaleUG5FT as [UG-5YRS],
		stScholorInstMalePGFT as [PG-FT],
		stScholorInstMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Funds No. of students receiving Freeships /Scholarships from the Private Bodies (Female)' as [Details of Students],
		stScholorPvtFemaleUGFT as [UG],
		stScholorPvtFemaleUG5FT as [UG-5YRS],
		stScholorPvtFemalePGFT as [PG-FT],
		stScholorPvtFemalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'Funds No. of students receiving Freeships /Scholarships from the Private Bodies (Male)' as [Details of Students],
		stScholorPvtMaleUGFT as [UG],
		stScholorPvtMaleUG5FT as [UG-5YRS],
		stScholorPvtMalePGFT as [PG-FT],
		stScholorPvtMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of Students who are not receiving any Freeships /Scholarships' as [Details of Students],
		stNoScholorMaleUGFT as [UG],
		stNoScholorMaleUG5FT as [UG-5YRS],
		stNoScholorMalePGFT as [PG-FT],
		stNoScholorMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of first year students intake in the year' as [Details of Students],
		stIntakeMaleUGFT as [UG],
		stIntakeMaleUG5FT as [UG-5YRS],
		stIntakeMalePGFT as [PG-FT],
		stIntakeMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of first year students admitted in the year' as [Details of Students],
		stAdmitMaleUGFT as [UG],
		stAdmitMaleUG5FT as [UG-5YRS],
		stAdmitMalePGFT as [PG-FT],
		stAdmitMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';
		
		insert into #doaa1
		select top 1 'No. of students admitted through Lateral entry' as [Details of Students],
		stLateralMaleUGFT as [UG],
		stLateralMaleUG5FT as [UG-5YRS],
		stLateralMalePGFT as [PG-FT],
		stLateralMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';
		
		insert into #doaa1
		select top 1 'No. of students graduating in minimum stipulated time' as [Details of Students],
		stMinGradMaleUGFT as [UG],
		stMinGradMaleUG5FT as [UG-5YRS],
		stMinGradMalePGFT as [PG-FT],
		stMinGradMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of students placed Median salary of placed graduates per annum (Amount in Rs.)' as [Details of Students],
		stPlaceMedSalMaleUGFT as [UG],
		stPlaceMedSalMaleUG5FT as [UG-5YRS],
		stPlaceMedSalMalePGFT as [PG-FT],
		stPlaceMedSalMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa1
		select top 1 'No. of students selected for Higher Studies' as [Details of Students],
		stHigherMaleUGFT as [UG],
		stHigherMaleUG5FT as [UG-5YRS],
		stHigherMalePGFT as [PG-FT],
		stHigherMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';
		
		insert into #doaa1
		select top 1 'No. of National Conference (Student)' as [Details of Students],
		stConfNatMaleUGFT as [UG],
		stConfNatMaleUG5FT as [UG-5YRS],
		stConfNatMalePGFT as [PG-FT],
		stConfNatMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';
		
		insert into #doaa1
		select top 1 'No. of International Conference (Student)' as [Details of Students],
		stConfIntMaleUGFT as [UG],
		stConfIntMaleUG5FT as [UG-5YRS],
		stConfIntMalePGFT as [PG-FT],
		stConfIntMalePGPT as [PG-PT]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';
		
		insert into #doaa1
		select top 1 'Total' as [Details of Students],
		 sum([UG]) as [UG],
		 sum([UG-5YRS]) as [UG-5YRS],
		 sum([PG-FT]) as [PG-FT],
		 sum([PG-PT]) as [PG-PT]
		from #doaa1;
		
		create table #doaa2
		(
			[Ph.D Student Details] nvarchar(max),
			[FullTime(FT)] int,
			[PartTime(PT)] int
		);

		insert into #doaa2
		select top 1 'Total Students in Financial Year (Sample Data)' as [Ph.D Student Details],
		stPhDFT as [FullTime(FT)],
		stPhDPT as [PartTime(PT)]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		insert into #doaa2
		select top 1 'No. of Ph.D students graduated in Financial Year (including Integrated Ph.D)' as [Ph.D Student Details],
		stGradPhDFT as [FullTime(FT)],
		stGradPhDPT as [PartTime(PT)]
		from stInfo as info 
		where DataCaptYM = @DataCaptYM AND info.MenuID = @MenuID AND info.DeptID = 'DOAA';

		select * from #doaa1;
		select * from #doaa2;
	END
END

GO
