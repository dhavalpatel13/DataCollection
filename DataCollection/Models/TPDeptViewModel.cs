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
    public class TPDeptViewModel : BaseViewModel
    {
        public List<TPDept> TPDeptData { get; set; }

        public int DataCaptYM { get; set; }
        public int DataStatus { get; set; }
        public string DataStatusName { get; set; }

        public void GetTPDeptData(int _dataCaptYM)
        {
            FormsRepository formsRepository = new FormsRepository();
            DataCaptYM = SessionManager.DataCaptYR > 0 ? SessionManager.DataCaptYR : (_dataCaptYM > 0 ? _dataCaptYM : 0);

            TPDeptData = formsRepository.GetTPDeptFormDataByID(DataCaptYM);

            if (TPDeptData == null || TPDeptData.Count == 0)
            {
                throw new Exception("Invalid Data");
            }
            else
            {
                DataStatus = TPDeptData.First().DataStatus;
                DataStatusName = TPDeptData.First().DataStatusName;

                if (DataStatus == 0)
                {
                    DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
                    DataStatusName = (DataAccess.Enum.DataStatus.DataEntryStartedbyOperator).GetStringValue();
                }
            }
        }

        public bool SaveTPDeptData(string action, out string msg)
        {
            msg = string.Empty;
            bool success = false;
            if (TPDeptData == null || TPDeptData.Count == 0)
            {
                return success;
            }

            foreach (var item in TPDeptData)
            {
                item.MenuID = DataAccess.Enum.Menu.TPDEPT.ToString();
                item.DataUser = SessionManager.UserName;
                item.DataUpdatedOn = DateTime.Now;
                item.DataCaptYM = SessionManager.DataCaptYR;
                item.DataStatus = FormCommonMethods.GetStatusByAction(action);
                item.DataValid = "Y";
                item.DataLocked = "N";
                item.DataStatusLog = SessionManager.UserName + " " + DateTime.Now.ToString("ddd, dd MMM yyyy HH:mm:ss");
            }

            try
            {
                FormsRepository formsRepository = new FormsRepository();
                DataTable dt = ToDataTable(TPDeptData);
                success = formsRepository.UpdateBulkTPDeptFormData(dt, SessionManager.DataCaptYR);
            }
            catch (Exception ex)
            {

            }
            return success;
        }
    }

    public class TPDeptRequestViewModel
    {
        public TPDeptViewModel formData { get; set; }
        public string action { get; set; }
        public string menu { get; set; }
        public string needModificationMSG { get; set; }
    }
}