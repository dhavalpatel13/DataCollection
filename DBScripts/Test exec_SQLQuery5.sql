
DECLARE @dofaData DofaData
DECLARE @dataCaptYM int = 201801
DECLARE @deptID nvarchar(10) = 'DOFA'

-- TODO: Set parameter values here.

--0,201801,'DOFA','DOFA','Krishna1','10/13/2018 2:07:55 AM',1,'Krishna1 Sat, 13 Oct 2018 02:07:55','Y','N',1,	'aa','10/8/2018 12:00:00 AM','10/9/2018 12:00:00 AM','10/16/2018 12:00:00 AM','M','desg','DOFA','121212a','R','ind','11','aaa','sdsd',1,11,'aa','bb',1,1,'test'
insert into @dofaData ([IDNo],
	[DataCaptYM],
	[DeptID],
	[DeptName],
	[MenuID],
	[DataUser],
	[DataUpdatedOn],
	[DataStatus],
	[DataStatusName],
	[DataStatusLog],
	[DataValid],
	[DataLocked],
	[empNo],
	[empName],
	[empDOB],
	[empDOJ],
	[empDOL],
	[empGender],
	[empDESG],
	[empDEPT],
	[empPAN],
	[empType],
	[empCat],
	[empNation],
	[QualHighYear],
	[QualHighCourse],
	[QualHighInst],
	[ExpAcadMon],
	[ExpIndMon],
	[FacExcgIn],
	[FacExcgOut],
	[ConfSymSemNat],
	[ConfSymSemInt],
	[AwardHonors]) 
 values (0,
 201801,
 'DOFA',
 '',
 'DOFA',
 'Krishna1',
 '10/13/2018 2:07:55 AM',
 1,
 '',
 'Krishna1 Sat, 13 Oct 2018 02:07:55',
 'Y',
 'N',
 1,
 'aa',
 '10/8/2018 12:00:00 AM',
 '10/9/2018 12:00:00 AM',
 '10/16/2018 12:00:00 AM',
 'M',
 'desg',
 'DOFA',
 '121212a',
 'R',
 '',
 'ind',
 '11',
 'aaa',
 'sdsd',
 1,
 11,
 'aa',
 'bb',
 1,
 1,
 'test'
 );

exec [dbo].[Bulk_Update_DOFA_DATA_BY_DataCaptYM_DeptID_MenuID] 
   @dofaData
  ,@dataCaptYM
  ,@deptID
GO


