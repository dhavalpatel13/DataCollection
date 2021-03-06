USE [RANK]
GO

-------------------------------------- DataStatus -----------------------------------------------------

INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (1, N'Data Entry Started by Operator')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (2, N'Data Entry Completed by Operator')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (3, N'Data Checking by HOD')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (4, N'Data Checking Completed by HOD')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (5, N'Data Sent to Asso.DEAN')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (6, N'Data Checked by Asso.DEAN')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (7, N'Data Verified by DEAN')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (8, N'Reserved')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (9, N'Reserved')
GO
INSERT [dbo].[DataStatus] ([DataStatus], [Details]) VALUES (10, N'Data Locked')
GO

-------------------------------------- Depts -----------------------------------------------------


INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (1, N'AHEC', N'Alternate Hydro Energy Center', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (2, N'ARCH', N'Architecture & Planning', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (3, N'ASE', N'Applied Science & Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (4, N'BIO', N'Biotechnology', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (5, N'CCE', N'Centre for Continuing Education', N'C', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (6, N'CED', N'CIVIL ENGG', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (7, N'CHED', N'Chemical Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (8, N'CHY', N'Chemistry', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (9, N'COEDMM', N'Centre of Exc. in Disaster Mitigation & Management', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (10, N'CSE', N'Computer Science & Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (11, N'CTS', N'Center for Transportation Systems', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (12, N'DOAA', N'DOAA', N'C', N'X')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (13, N'DOFA', N'DOFA', N'C', N'X')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (14, N'DOMS', N'Management Studies', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (15, N'DORA', N'DORA', N'C', N'X')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (16, N'DOSW', N'DOSW', N'C', N'X')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (17, N'ECE', N'Electronics & Communication Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (18, N'EED', N'Electrical Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (19, N'EQD', N'Earthquake Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (20, N'ESC', N'Earth Sciences', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (21, N'FAO', N'FAO', N'C', N'X')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (22, N'HSS', N'Humanities and Social Sciences', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (23, N'HYD', N'Hydrology', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (24, N'ICC', N'Institute Computer Center', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (25, N'IIC', N'Institute Instrumentation Centre', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (26, N'LIB', N'MGCL', N'A', N'X')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (27, N'MAT', N'Mathematics', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (28, N'MET', N'Metallurgical & Materials Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (29, N'MIED', N'Mechanical & Industrial Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (30, N'NANO', N'Centre of Nanotechnology', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (31, N'PHY', N'Physics', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (32, N'PPE', N'Polymar & Process Engineering', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (33, N'PPT', N'Pulp & Paper Technology', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (34, N'QIP', N'QIP', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (35, N'SRIC', N'SRIC', N'C', N'X')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (36, N'WRDM', N'Water Resources Development & Management', N'A', N'S')
GO
INSERT [dbo].[Depts] ([SNo], [DeptID], [DeptName], [DeptType], [DeptCAT]) VALUES (37, N'ADIR', N'ADIR', N'C', N'X')
GO

-------------------------------------- MenuIDs -----------------------------------------------------

INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl]) VALUES (N'ADIR', N'ADIR FORM', N'/Forms/ADIRForm')
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl]) VALUES (N'DOAA', N'DOAA FORM', N'/Forms/DOAAForm')
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl]) VALUES (N'DOFA', N'DOFA FORM', N'/Forms/DOFAForm')
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl]) VALUES (N'DOSW', N'DOSW FORM', N'/Forms/DOSWForm')
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl]) VALUES (N'LIBFORM', N'LIB FORM', N'/Forms/LIBForm')
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl]) VALUES (N'SRIC', N'SRIC FORM', N'/Forms/SRICForm')
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl]) VALUES (N'SRICFA', N'SRICFA FORM', N'/Forms/SRICFAForm')
GO
INSERT [dbo].[MenuIDs] ([MenuID], [MenuDetails], [MenuUrl]) VALUES (N'USERS', N'REGISTER USERS ', N'/Admin/Index')
GO

-------------------------------------- UserMenu -----------------------------------------------------

SET IDENTITY_INSERT [dbo].[UserMenu] ON 
GO

INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (1, N'admin', N'ALL')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (2, N'dodoaa', N'DOAA')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (3, N'hoddoaa', N'DOAA')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (4, N'doahec', N'LIBFORM')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (5, N'hodahec', N'LIBFORM')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (1005, N'doahec', N'ADIR')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (1006, N'hodahec', N'ADIR')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (1007, N'doahec', N'DOSW')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (1008, N'hodahec', N'DOSW')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (1020, N'w134', N'DOAA')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (2009, N'W135', N'SRIC')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (2010, N'W135', N'SRICFA')
GO
INSERT [dbo].[UserMenu] ([UserMenuID], [UserID], [MenuID]) VALUES (2011, N'w136', N'DOFA')
GO

SET IDENTITY_INSERT [dbo].[UserMenu] OFF
GO

-------------------------------------- UserRole -----------------------------------------------------

INSERT [dbo].[UserRole] ([UserRole], [UserRoleDetails]) VALUES (N'Admin', N'admin')
GO
INSERT [dbo].[UserRole] ([UserRole], [UserRoleDetails]) VALUES (N'User', N'user')
GO
INSERT [dbo].[UserWork] ([UserWork], [UserWorkDetails]) VALUES (N'Admin', N'Admin')
GO
INSERT [dbo].[UserWork] ([UserWork], [UserWorkDetails]) VALUES (N'DO', N'Dataentry Operator')
GO
INSERT [dbo].[UserWork] ([UserWork], [UserWorkDetails]) VALUES (N'HOD', N'Head of the dept Operator')
GO

-------------------------------------- RankUsers -----------------------------------------------------

INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'admin', N'MTIzNDU2', N'403', N'Administrator', N'admin', N'admin', N'Admin', N'1234567890', N'noreplay@Email.com', N'Y', CAST(0x0000A96400BCEBC7 AS DateTime), NULL, NULL,  1, null, NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'w101', N'MTIzNDU2', N'401403', N'Praveen', N'AHEC', N'User', N'DO', N'1234567890', N'noreplay@Email.com', N'Y', CAST(0x0000A96400BCEBC7 AS DateTime), NULL, NULL,  1, null, NULL) 
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'w102', N'MTIzNDU2', N'404', N'Praveen1', N'DOAA', N'User', N'DO', N'1234567890', N'noreplay@Email.com', N'Y', CAST(0x0000A9660096751C AS DateTime), NULL, NULL,  1, null, NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'w103', N'MTIzNDU2', N'123456', N'Bhavin 1', N'ADIR', N'User', N'DO', N'1234567890', N'bhavin@Teting.co', N'Y', CAST(0x0000A96400BCEBC7 AS DateTime), NULL, NULL, 1, null, NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'W104', N'MTIzNDU2', N'459986', N'Krishna', N'SRIC', N'User', N'DO', N'9537574215', N'test@test.css', N'Y', CAST(0x0000A96400BCEBC7 AS DateTime), NULL, NULL, 1, null, NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'W105', N'MTIzNDU2', N'788456', N'Krishna1', N'DOFA', N'User', N'DO', N'4561523789', N'testing@testing.ss', N'Y', CAST(0x0000A96400BCEBC7 AS DateTime), NULL, NULL, 1, null, NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'W106', N'MTIzNDU2', N'402', N'HOD', N'AHEC', N'User', N'HOD', N'1234567890', N'noreplay@Email.com', N'Y', CAST(0x0000A96400BCEBC7 AS DateTime), NULL, NULL,  1, null, NULL)
GO
INSERT [dbo].[RankUsers] ([UserID], [UserPassword], [UserEmpNo], [UserName], [DeptID], [UserRole], [UserWork], [UserMob], [UserEmail], [UserValid], [UserCreatedOn], [UserDisabledOn], [UserRemarks], [IsEmailVerified], [ActivationCode], [ResetPasswordCode]) VALUES (N'W107', N'MTIzNDU2', N'405', N'HOD1', N'DOAA', N'User', N'HOD', N'1234567890', N'noreplay@Email.com', N'Y', CAST(0x0000A9660096751C AS DateTime), NULL, NULL,  1, null, NULL)
GO

-------------------------------------- RankMesg -----------------------------------------------------

INSERT [dbo].[RankMesg] ([Message]) VALUES (N'Testing ')
GO

