using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DataAccess.Entity;
using DataAccess.Repository;
using DataCollection.ManageSession;
using System.Data;

namespace DataCollection.Models
{
    public class SricDeptViewModel : BaseViewModel
    {
        public List<SricDept> SricDeptData { get; set; }

        public int DataCaptYM { get; set; }
        public int DataStatus { get; set; }
        public string DataStatusName { get; set; }

        public void GetSRICData(int _dataCaptYM)
        {
            FormsRepository formsRepository = new FormsRepository();
            DataCaptYM = SessionManager.DataCaptYR > 0 ? SessionManager.DataCaptYR : (_dataCaptYM > 0 ? _dataCaptYM : 0);

            SricDeptData = formsRepository.GetSricDeptFormDataByID(DataCaptYM);

            if (SricDeptData == null || SricDeptData.Count == 0)
            {
                throw new Exception("Invalid Data");
            }
            else
            {
                DataStatus = SricDeptData.First().DataStatus;
                DataStatusName = SricDeptData.First().DataStatusName;

                if (DataStatus == 0)
                {
                    DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
                    DataStatusName = "Data Entry Started by Operator";
                }
            }
        }

        public bool SaveSricDeptData(string action, out string msg)
        {
            msg = string.Empty;
            bool success = false;
            if (SricDeptData == null || SricDeptData.Count == 0)
            {
                return success;
            }

            foreach (var item in SricDeptData)
            {
                item.MenuID = DataAccess.Enum.Menu.SRIC.ToString();
                item.DataUser = SessionManager.UserName;
                item.DataUpdatedOn = DateTime.Now;
                item.DataCaptYM = SessionManager.DataCaptYR;
                item.DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
                if (action == "Finalize")
                {
                    item.DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryCompletedbyOperator;
                }
                else if (action == "FinalizedByHod")
                {
                    item.DataStatus = (int)DataAccess.Enum.DataStatus.DataCheckingCompletedbyHOD;
                }
                item.DataValid = "Y";
                item.DataLocked = "N";
                item.DataStatusLog = SessionManager.UserName + " " + DateTime.Now.ToString("ddd, dd MMM yyyy HH:mm:ss");
            }

            try
            {
                FormsRepository formsRepository = new FormsRepository();
                DataTable dt = ToDataTable(SricDeptData);
                success = formsRepository.UpdateBulkSricDeptFormData(dt, SessionManager.DataCaptYR);
            }
            catch (Exception ex)
            {

            }
            return success;
        }
    }

    public class SricDeptRequestViewModel
    {
        public SricDeptViewModel formData { get; set; }
        public string action { get; set; }
        public string menu { get; set; }
    }
}