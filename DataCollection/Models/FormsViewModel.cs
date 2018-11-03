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
using System.Web.Mvc;

namespace DataCollection.Models
{
    public class FormsViewModel
    {
        public stInfo info { get; set; }
        public stInfo2 info2 { get; set; }
        public LibInfo libInfo { get; set; }

        public DofaViewModel dofaViewModel { get; set; }
        public SricFAViewModel sricFAViewModel { get; set; }
        public DofaPeerViewModel dofaPeerViewModel { get; set; }

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
                dofaViewModel.GetDOFAData(DataCaptYM);
            }
            else if (MenuID == DataAccess.Enum.Menu.SRICFA.ToString())
            {
                sricFAViewModel = new SricFAViewModel();
                sricFAViewModel.GetSRICFAData(DataCaptYM);
            }
            else if (MenuID == DataAccess.Enum.Menu.SRIC.ToString())
            {
                sricDeptViewModel = new SricDeptViewModel();
                sricDeptViewModel.GetSRICData(DataCaptYM);
            }
            else if (MenuID == DataAccess.Enum.Menu.DOFAPEER.ToString())
            {
                dofaPeerViewModel = new DofaPeerViewModel();
                dofaPeerViewModel.GetDofaPeerData(DataCaptYM);
            }

            RankMesg rankmesg = FormCommonMethods.GetCurrentRankMesg();
            this.rankmsg = rankmesg.Message;
        }

        public void GetMultiDataByMenuID(int dataCaptYM, string MenuID, string empDept = "")
        {
            FormsRepository formsRepository = new FormsRepository();
            dataCaptYM = SessionManager.DataCaptYR > 0 ? SessionManager.DataCaptYR : (dataCaptYM > 0 ? dataCaptYM : 0);
            if (MenuID == DataAccess.Enum.Menu.DOFA.ToString())
            {
                dofaViewModel = new DofaViewModel();
                dofaViewModel.GetDOFAData(dataCaptYM, empDept);
            }
            else if(MenuID == DataAccess.Enum.Menu.SRICFA.ToString())
            {
                sricFAViewModel = new SricFAViewModel();
                sricFAViewModel.GetSRICFAData(dataCaptYM);
            }
            else if (MenuID == DataAccess.Enum.Menu.SRIC.ToString())
            {
                sricDeptViewModel = new SricDeptViewModel();
                sricDeptViewModel.GetSRICData(dataCaptYM);
            }
            else if (MenuID == DataAccess.Enum.Menu.DOFAPEER.ToString())
            {
                dofaPeerViewModel = new DofaPeerViewModel();
                dofaPeerViewModel.GetDofaPeerData(dataCaptYM);
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
        
        public Tuple<bool, bool> SaveUpdateFormData(object objectData, string action, string menu, string needModificationMSG, out string msg)
        {
            msg = string.Empty;
            FormsViewModel formsViewModel = new FormsViewModel();
            int DataCaptYM = 0; 
            string DeptID = string.Empty;
            bool IsEmailSent = false;

            if (menu == DataAccess.Enum.Menu.DOSW.ToString() || menu == DataAccess.Enum.Menu.ADIR.ToString())
            {
                stInfo2 info2 = new stInfo2();
                info2 = JsonConvert.DeserializeObject<stInfo2>(objectData.ToString());

                info2.DataUpdatedOn = DateTime.Now;
                info2.DataStatus = FormCommonMethods.GetStatusByAction(action);
                info2.DataUser = SessionManager.UserName;
                info2.DeptID = SessionManager.DeptID;
                info2.DataValid = "Y";
                info2.DataLocked = "N";
                info2.DataStatusLog = SessionManager.UserName + " " + DateTime.Now.ToString("ddd, dd MMM yyyy HH:mm:ss"); //DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt");
                DeptID = info2.DeptID;
                DataCaptYM = info2.DataCaptYM;
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
                info.DataStatus = FormCommonMethods.GetStatusByAction(action);
                info.DataUser = SessionManager.UserName;
                info.DeptID = SessionManager.DeptID;
                info.DataValid = "Y";
                info.DataLocked = "N";
                info.DataStatusLog = SessionManager.UserName + " " + DateTime.Now.ToString("ddd, dd MMM yyyy HH:mm:ss");
                info.MenuID = DataAccess.Enum.Menu.DOAA.ToString();
                DataCaptYM = info.DataCaptYM;
                DeptID = info.DeptID;

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
                libInfo.DataStatus = FormCommonMethods.GetStatusByAction(action);
                libInfo.DataUser = SessionManager.UserName;
                libInfo.DeptID = SessionManager.DeptID;
                libInfo.DataValid = "Y";
                libInfo.DataLocked = "N";
                libInfo.DataStatusLog = SessionManager.UserName + " " + DateTime.Now.ToString("ddd, dd MMM yyyy HH:mm:ss");
                libInfo.MenuID = DataAccess.Enum.Menu.LIBFORM.ToString();
                DataCaptYM = libInfo.DataCaptYM;
                DeptID = libInfo.DeptID;

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
                    DataCaptYM = dvm.DataCaptYM;
                    DeptID = "DOFA";
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
                    DataCaptYM = sfvm.DataCaptYM;
                    DeptID = "SRIC Agency";
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
                    DataCaptYM = sdvm.DataCaptYM;
                    DeptID = "SRIC";
                    formsViewModel.isSaveSuccessfully = sdvm.SaveSricDeptData(action, out msg);
                }
                else
                {
                    formsViewModel.isSaveSuccessfully = false;
                }
            }
            else if (menu == DataAccess.Enum.Menu.DOFAPEER.ToString())
            {
                if (objectData != null && typeof(DofaPeerViewModel) == objectData.GetType())
                {
                    DofaPeerViewModel sdvm = (DofaPeerViewModel)objectData;
                    DataCaptYM = sdvm.DataCaptYM;
                    DeptID = "DOFA";
                    formsViewModel.isSaveSuccessfully = sdvm.SaveDofaPeerData(action, out msg);
                }
                else
                {
                    formsViewModel.isSaveSuccessfully = false;
                }
            }
            if (formsViewModel.isSaveSuccessfully)
            {
                IsEmailSent = FormCommonMethods.SendFinallizeEmail(action, DataCaptYM, DeptID, needModificationMSG);
            }

            return new Tuple<bool, bool>(formsViewModel.isSaveSuccessfully, IsEmailSent);
        }
    }
}