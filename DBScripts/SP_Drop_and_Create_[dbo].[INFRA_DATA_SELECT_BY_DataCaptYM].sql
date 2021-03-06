USE [RANK]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.INFRA_DATA_SELECT_BY_DataCaptYM','P') IS NOT NULL
BEGIN
	DROP PROCEDURE [dbo].[INFRA_DATA_SELECT_BY_DataCaptYM];
END
GO

CREATE PROCEDURE [dbo].[INFRA_DATA_SELECT_BY_DataCaptYM]
	@DataCaptYM int,
	@DeptId nvarchar(100) = 'AHEC'
AS
BEGIN
	SELECT ISNULL(sr.IDNo, 0) as IDNo ,ISNULL(sr.DataCaptYM, @DataCaptYM) as DataCaptYM
	,d.DeptID, d.DeptName, ISNULL(sr.MenuID,'INFRA') as MenuID
	,sr.DataUser,sr.DataUpdatedOn, sr.DataStatus, ds.Details as DataStatusName
	,sr.DataStatusLog, sr.DataValid, sr.DataLocked
	,ClassRooms,Labs,Auditoriums,ConfRooms,FaclCabins,CompLabs,SplLabs,OtherLabs
	FROM Depts d
	LEFT JOIN InfraDEPT sr on sr.DeptID = d.DeptID and sr.DataCaptYM = @DataCaptYM 
	left JOIN DataStatus as ds on sr.DataStatus = ds.DataStatus
	WHERE (d.DeptCAT = 'S' OR  (d.DeptID = @DeptId AND d.DeptCAT = 'X')) AND (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
	AND d.DeptID = @DeptId
	ORDER BY DeptName;
	
	create table #tempInfo
	(
		[InfraNo] [int] NOT NULL,
		[InfraDescr] [nvarchar](50) NULL
	);

	insert into #tempInfo (InfraNo,InfraDescr) values (1,'Campus Area');
	insert into #tempInfo (InfraNo,InfraDescr) values (2,'Total Build Up Area');
	insert into #tempInfo (InfraNo,InfraDescr) values (3,'Sports & Amenities');
	insert into #tempInfo (InfraNo,InfraDescr) values (4,'Building with Elevator');
	insert into #tempInfo (InfraNo,InfraDescr) values (5,'Building with Disabled Facilities');
	insert into #tempInfo (InfraNo,InfraDescr) values (6,'Eco Friendly Buildings');
	insert into #tempInfo (InfraNo,InfraDescr) values (7,'Water Harvesting System');

	SELECT ISNULL(sr.IDNo, 0) as IDNo ,ISNULL(sr.DataCaptYM, @DataCaptYM) as DataCaptYM
	,ISNULL(sr.DeptID,'INFRA') as DeptID, ISNULL(sr.MenuID,'INFRA') as MenuID
	,sr.DataUser,sr.DataUpdatedOn, sr.DataStatus, ds.Details as DataStatusName
	,sr.DataStatusLog, sr.DataValid, sr.DataLocked
	,i.InfraNo,i.InfraDescr,sr.InfraDetails,sr.InfraRemarks
	FROM #tempInfo i
	LEFT JOIN InfraInfo sr on sr.InfraNo = i.InfraNo and sr.DataCaptYM = @DataCaptYM 
	left JOIN DataStatus as ds on sr.DataStatus = ds.DataStatus
	WHERE (sr.DataCaptYM = @DataCaptYM or sr.DataCaptYM is null) 
	ORDER BY InfraNo asc;
END

GO
