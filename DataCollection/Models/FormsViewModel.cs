using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DataAccess.Repository;
using DataCollection.ManageSession;
using DataCollection.FormService;
using Newtonsoft.Json;
using DataAccess.Enum;

namespace DataCollection.Models
{
    public class FormsViewModel
    {
        public stInfo info { get; set; }
        public stInfo2 info2 { get; set; }
        public LibInfo libInfo { get; set; }

        public DofaViewModel dofaViewModel { get; set; }
        public SricFAViewModel sricFAViewModel { get; set; }

        public SricDeptViewModel sricDeptViewModel { get; set; }

        public bool isSaveSuccessfully { get; set; }
        public string rankmsg { get; set; }

        public void GetDOAA1Data(int DataCaptYM, string MenuID)
        {
            FormsRepository formsRepository = new FormsRepository();            
            DataCaptYM = SessionManager.DataCaptYR > 0 ? SessionManager.DataCaptYR : (DataCaptYM > 0 ? DataCaptYM : 0);
            if (MenuID == DataAccess.Enum.Menu.DOAA.ToString())
            {
                this.info = formsRepository.GetDOAA1FormDataByID(DataCaptYM, SessionManager.DeptID, MenuID);
                if (info == null)
                {
                    info = new stInfo();
                    info.DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
                    info.DataStatusName = "Data Entry Started by Operator";
                    info.DataCaptYM = DataCaptYM;
                    info.DeptName = info.DeptID = SessionManager.DeptID;
                }
            }
            else if (MenuID == DataAccess.Enum.Menu.ADIR.ToString() || MenuID == DataAccess.Enum.Menu.DOSW.ToString())
            {
                this.info2 = formsRepository.GetADIRFormDataByID(DataCaptYM, SessionManager.DeptID, MenuID);
                if (info2 == null)
                {
                    info2 = new stInfo2();
                    info2.DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
                    info2.DataStatusName = "Data Entry Started by Operator";
                    info2.DataCaptYM = DataCaptYM;
                    info2.DeptName = info2.DeptID = SessionManager.DeptID;
                }
            }
            else if (MenuID == DataAccess.Enum.Menu.LIBFORM.ToString())
            {
                this.libInfo = formsRepository.GetLibFormDataByID(DataCaptYM, SessionManager.DeptID, MenuID);
                if (libInfo == null)
                {
                    libInfo = new LibInfo();
                    libInfo.DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
                    libInfo.DataStatusName = "Data Entry Started by Operator";
                    libInfo.DataCaptYM = DataCaptYM;
                    libInfo.DeptName = libInfo.DeptID = SessionManager.DeptID;
                }
            }
            else if (MenuID == DataAccess.Enum.Menu.DOFA.ToString())
            {
                dofaViewModel = new DofaViewModel();
                dofaViewModel.GetDOFAData(DataCaptYM, MenuID);
            }
            else if (MenuID == DataAccess.Enum.Menu.SRICFA.ToString())
            {
                sricFAViewModel = new SricFAViewModel();
                sricFAViewModel.GetSRICFAData(DataCaptYM, MenuID);
            }
            else if (MenuID == DataAccess.Enum.Menu.SRIC.ToString())
            {
                sricDeptViewModel = new SricDeptViewModel();
                sricDeptViewModel.GetSRICData(DataCaptYM);
            }

            RankMesg rankmesg = FormCommonMethods.GetCurrentRankMesg();
            this.rankmsg = rankmesg.Message;
        }

        public void GetMultiDataByMenuID(int dataCaptYM, string MenuID)
        {
            FormsRepository formsRepository = new FormsRepository();
            dataCaptYM = SessionManager.DataCaptYR > 0 ? SessionManager.DataCaptYR : (dataCaptYM > 0 ? dataCaptYM : 0);
            if (MenuID == DataAccess.Enum.Menu.DOFA.ToString())
            {
                dofaViewModel = new DofaViewModel();
                dofaViewModel.GetDOFAData(dataCaptYM, MenuID);
            }
            else if(MenuID == DataAccess.Enum.Menu.SRICFA.ToString())
            {
                sricFAViewModel = new SricFAViewModel();
                sricFAViewModel.GetSRICFAData(dataCaptYM, MenuID);
            }
            else if (MenuID == DataAccess.Enum.Menu.SRIC.ToString())
            {
                sricDeptViewModel = new SricDeptViewModel();
                sricDeptViewModel.GetSRICData(dataCaptYM);
            }

            RankMesg rankmesg = FormCommonMethods.GetCurrentRankMesg();
            this.rankmsg = rankmesg.Message;
        }

        #region  DOAA Form
        public bool SaveDOAA1Form(FormsViewModel dOAA1ViewModel)
        {
            FormsRepository formsRepository = new FormsRepository();
            int isSave = formsRepository.Insert(dOAA1ViewModel.info);
            GetDOAA1Data(dOAA1ViewModel.info.DataCaptYM, dOAA1ViewModel.info.MenuID);
            return isSave > 0;
        }

        public bool UdpateDOAA1Form(FormsViewModel dOAA1ViewModel)
        {
            FormsRepository formsRepository = new FormsRepository();
            bool isUpdate = formsRepository.Update(dOAA1ViewModel.info);
            GetDOAA1Data(dOAA1ViewModel.info.DataCaptYM, dOAA1ViewModel.info.MenuID);
            return isUpdate;
        }
        #endregion  DOAA Form

        #region  ADIR DOSW Form
        public bool SaveADIRAndDOSWForm(FormsViewModel formsViewModel)
        {
            FormsRepository formsRepository = new FormsRepository();
            bool isSave = formsRepository.InsertTostInfo2(formsViewModel.info2);
            GetDOAA1Data(formsViewModel.info2.DataCaptYM, formsViewModel.info2.MenuID);
            return isSave;
        }

        public bool UdpateADIRAndDOSWForm(FormsViewModel formsViewModel)
        {
            FormsRepository formsRepository = new FormsRepository();
            bool isUpdate = formsRepository.UpdateTostInfo2(formsViewModel.info2);
            GetDOAA1Data(formsViewModel.info2.DataCaptYM, formsViewModel.info2.MenuID);
            return isUpdate;
        }
        #endregion  ADIR DOSW Form

        #region LIB Form
        public bool SaveLIBForm(FormsViewModel formsViewModel)
        {
            FormsRepository formsRepository = new FormsRepository();
            bool isSave = formsRepository.InsertToLibInfo(formsViewModel.libInfo);
            GetDOAA1Data(formsViewModel.libInfo.DataCaptYM, formsViewModel.libInfo.MenuID);
            return isSave;
        }

        public bool UdpateLIBForm(FormsViewModel formsViewModel)
        {
            FormsRepository formsRepository = new FormsRepository();
            bool isUpdate = formsRepository.UpdateToLibInfo(formsViewModel.libInfo);
            GetDOAA1Data(formsViewModel.libInfo.DataCaptYM, formsViewModel.libInfo.MenuID);
            return isUpdate;
        }
        #endregion LIB Form
        
        public bool SaveUpdateFormData(object objectData, string action, string menu, out string msg)
        {
            msg = string.Empty;
            FormsViewModel formsViewModel = new FormsViewModel();
            
            if (menu == DataAccess.Enum.Menu.DOSW.ToString() || menu == DataAccess.Enum.Menu.ADIR.ToString())
            {
                stInfo2 info2 = new stInfo2();
                info2 = JsonConvert.DeserializeObject<stInfo2>(objectData.ToString());

                info2.DataUpdatedOn = DateTime.Now;
                info2.DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
                if (action == "Finalize")
                {
                    info2.DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryCompletedbyOperator;
                }
                else if (action == "FinalizedByHod")
                {
                    info2.DataStatus = (int)DataAccess.Enum.DataStatus.DataCheckingCompletedbyHOD;
                }

                info2.DataUser = SessionManager.UserName;
                info2.DeptID = SessionManager.DeptID;
                info2.DataValid = "Y";
                info2.DataLocked = "N";
                info2.DataStatusLog = SessionManager.UserName + " " + DateTime.Now.ToString("ddd, dd MMM yyyy HH:mm:ss"); //DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt");
                if (menu == DataAccess.Enum.Menu.ADIR.ToString())
                {
                    info2.MenuID = DataAccess.Enum.Menu.ADIR.ToString();
                }
                else
                {
                    info2.MenuID = DataAccess.Enum.Menu.DOSW.ToString();
                }
                
                formsViewModel.info2 = info2;

                if (formsViewModel.info2.IDNo > 0)
                {
                    formsViewModel.isSaveSuccessfully = formsViewModel.UdpateADIRAndDOSWForm(formsViewModel);
                }
                else
                {
                    formsViewModel.isSaveSuccessfully = formsViewModel.SaveADIRAndDOSWForm(formsViewModel);
                }              
            }
            else if (menu == DataAccess.Enum.Menu.DOAA.ToString())
            {
                stInfo info = new stInfo();
                info = JsonConvert.DeserializeObject<stInfo>(objectData.ToString());

                info.DataUpdatedOn = DateTime.Now;
                info.DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
                if (action == "Finalize")
                {
                    info.DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryCompletedbyOperator;
                }
                else if (action == "FinalizedByHod")
                {
                    info.DataStatus = (int)DataAccess.Enum.DataStatus.DataCheckingCompletedbyHOD;
                }

                info.DataUser = SessionManager.UserName;
                info.DeptID = SessionManager.DeptID;
                info.DataValid = "Y";
                info.DataLocked = "N";
                info.DataStatusLog = SessionManager.UserName + " " + DateTime.Now.ToString("ddd, dd MMM yyyy HH:mm:ss");
                info.MenuID = DataAccess.Enum.Menu.DOAA.ToString();


                formsViewModel.info = info;

                if (formsViewModel.info.IDNo > 0)
                {
                    formsViewModel.isSaveSuccessfully = formsViewModel.UdpateDOAA1Form(formsViewModel);
                }
                else
                {
                    formsViewModel.isSaveSuccessfully = formsViewModel.SaveDOAA1Form(formsViewModel);
                }
            }
            else if (menu == DataAccess.Enum.Menu.LIBFORM.ToString())
            {
                LibInfo libInfo = new LibInfo();
                libInfo = JsonConvert.DeserializeObject<LibInfo>(objectData.ToString());

                libInfo.DataUpdatedOn = DateTime.Now;
                libInfo.DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
                if (action == "Finalize")
                {
                    libInfo.DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryCompletedbyOperator;
                }
                else if (action == "FinalizedByHod")
                {
                    libInfo.DataStatus = (int)DataAccess.Enum.DataStatus.DataCheckingCompletedbyHOD;
                }

                libInfo.DataUser = SessionManager.UserName;
                libInfo.DeptID = SessionManager.DeptID;
                libInfo.DataValid = "Y";
                libInfo.DataLocked = "N";
                libInfo.DataStatusLog = SessionManager.UserName + " " + DateTime.Now.ToString("ddd, dd MMM yyyy HH:mm:ss");
                libInfo.MenuID = DataAccess.Enum.Menu.LIBFORM.ToString();

                formsViewModel.libInfo = libInfo;

                if (formsViewModel.libInfo.IDNo > 0)
                {
                    formsViewModel.isSaveSuccessfully = formsViewModel.UdpateLIBForm(formsViewModel);
                }
                else
                {
                    formsViewModel.isSaveSuccessfully = formsViewModel.SaveLIBForm(formsViewModel);
                }
            }
            else if(menu == DataAccess.Enum.Menu.DOFA.ToString())
            {
                if (objectData != null && typeof(DofaViewModel) == objectData.GetType())
                {
                    DofaViewModel dvm = (DofaViewModel)objectData;
                    formsViewModel.isSaveSuccessfully = dvm.SaveDOFAData(action, out msg);
                }
                else
                {
                    formsViewModel.isSaveSuccessfully = false;
                }
            }
            else if (menu == DataAccess.Enum.Menu.SRICFA.ToString())
            {
                if (objectData != null && typeof(SricFAViewModel) == objectData.GetType())
                {
                    SricFAViewModel sfvm = (SricFAViewModel)objectData;
                    formsViewModel.isSaveSuccessfully = sfvm.SaveSricFAData(action, out msg);
                }
                else
                {
                    formsViewModel.isSaveSuccessfully = false;
                }
            }
            else if (menu == DataAccess.Enum.Menu.SRIC.ToString())
            {
                if (objectData != null && typeof(SricDeptViewModel) == objectData.GetType())
                {
                    SricDeptViewModel sdvm = (SricDeptViewModel)objectData;
                    formsViewModel.isSaveSuccessfully = sdvm.SaveSricDeptData(action, out msg);
                }
                else
                {
                    formsViewModel.isSaveSuccessfully = false;
                }
            }
            if (formsViewModel.isSaveSuccessfully && action == "Finalize")
            {
                try
                {
                    string body = "The User: " + SessionManager.UserName + ", Dept: " + SessionManager.DeptID + " , DataCapt: " + info.DataCaptYM + ", IRD Data has been finalised & sent for your Authorization.  Kindly Check & Authorize/Approve the data."
                                 + "Time Stamp: DateTime Stamp: " + DateTime.Now
                                 + "This is a System generated Email.";

                    string subject = "IRD Data Entry updated by " + SessionManager.UserName;

                    DataCollectionModelDataContext db = new DataCollectionModelDataContext();
                    var hod = db.RankUsers.Where(a => a.DeptID.ToLower() == SessionManager.DeptID.ToLower() && a.UserRole.ToLower() == UserRoles.User.ToString().ToLower() && a.UserWork.ToLower() == DataAccess.Enum.UserWork.HOD.ToString().ToLower()).FirstOrDefault();
                    string tomail = "webtechrk@gmail.com";
                    if(hod != null)
                    {
                        tomail = hod.UserEmail;
                    }

                    FormServices formServices = new FormServices();
                    formServices.SendEmail(tomail, "", subject, body);
                }
                catch (Exception ex) { }
            } 

            return formsViewModel.isSaveSuccessfully;
        }
    }
}