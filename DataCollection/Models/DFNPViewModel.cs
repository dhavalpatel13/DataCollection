using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DataAccess.Entity;
using DataAccess.Repository;
using DataCollection.ManageSession;
using System.Data;
using DataCollection.FormService;

namespace DataCollection.Models
{
    public class DFNPViewModel : BaseViewModel
    {
        public FinInfo finInfo { get; set; }        

        public void GetDFNPData(int _dataCaptYM)
        {
            FormsRepository formsRepository = new FormsRepository();
            var DataCaptYM = SessionManager.DataCaptYR > 0 ? SessionManager.DataCaptYR : (_dataCaptYM > 0 ? _dataCaptYM : 0);
            string deptID = string.IsNullOrEmpty(SessionManager.EmpDeptID) ? SessionManager.DeptID : SessionManager.EmpDeptID;
            finInfo = formsRepository.GetDFNPDataByID(DataCaptYM, deptID);

            if (finInfo == null)
            {
                finInfo = new FinInfo();
            }

            if (finInfo.DataStatus == 0)
            {
                finInfo.DataCaptYM = DataCaptYM;
                finInfo.DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
                finInfo.DataStatusName = (DataAccess.Enum.DataStatus.DataEntryStartedbyOperator).GetStringValue();
            }
        }

        public bool SaveDFNPData(string action, out string msg)
        {
            msg = string.Empty;
            bool success = false;
            if (finInfo == null)
            {
                return success;
            }

            finInfo.MenuID = DataAccess.Enum.Menu.DFNP.ToString();
            finInfo.DeptID = string.IsNullOrEmpty(finInfo.EmpDept) ? SessionManager.DeptID : finInfo.EmpDept;
            finInfo.DeptName = SessionManager.DeptID;
            finInfo.DataUser = SessionManager.UserName;
            finInfo.DataUpdatedOn = DateTime.Now;
            finInfo.DataCaptYM = SessionManager.DataCaptYR;
            finInfo.DataStatus = FormCommonMethods.GetStatusByAction(action);
            finInfo.DataValid = "Y";
            finInfo.DataLocked = "N";
            finInfo.DataStatusLog = SessionManager.UserName + " " + DateTime.Now.ToString("ddd, dd MMM yyyy HH:mm:ss");

            try
            {
                FormsRepository formsRepository = new FormsRepository();
                DataTable dt = ToDataTable(new List<FinInfo> { finInfo });
                success = formsRepository.UpdateBulkDFNPData(dt, SessionManager.DataCaptYR);
            }
            catch (Exception ex)
            {

            }
            return success;
        }
    }

    public class DFNPRequestViewModel
    {
        public DFNPViewModel formData { get; set; }
        public string action { get; set; }
        public string menu { get; set; }
        public string needModificationMSG { get; set; }
    }
}