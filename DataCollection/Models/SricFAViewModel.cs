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
    public class SricFAViewModel : BaseViewModel
    {
        public List<SricFA> SricFAData { get; set; }

        public int DataCaptYM { get; set; }
        public int DataStatus { get; set; }
        public string DataStatusName { get; set; }

        public void GetSRICFAData(int _dataCaptYM, string MenuID)
        {
            FormsRepository formsRepository = new FormsRepository();
            DataCaptYM = SessionManager.DataCaptYR > 0 ? SessionManager.DataCaptYR : (_dataCaptYM > 0 ? _dataCaptYM : 0);

            SricFAData = formsRepository.GetSricFAFormDataByID(DataCaptYM, SessionManager.DeptID);


            if (SricFAData == null || SricFAData.Count == 0)
            {
                SricFAData = new List<SricFA>();
                SricFAData.Add(new SricFA());
                DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
                DataStatusName = "Data Entry Started by Operator";
            }
            else
            {
                DataStatus = SricFAData.First().DataStatus;
                DataStatusName = SricFAData.First().DataStatusName;
            }
        }

        public bool SaveSricFAData(string action, out string msg)
        {
            msg = string.Empty;
            bool success = false;
            if (SricFAData == null || SricFAData.Count == 0)
            {
                return success;
            }

            if (SricFAData.Any(n => string.IsNullOrWhiteSpace(n.FAName)))
            {
                msg = "At least Agency Name / Sponsor Name Required.";
                return success;
            }

            if (SricFAData.GroupBy(n => n.FAName.Trim().ToLower()).Any(c => c.Count() > 1))
            {
                msg = "Duplicate Organization / Agency Name Exist.! Data saving aborted.";
                return success;
            }

            foreach (var item in SricFAData)
            {
                item.FAName = item.FAName.Trim();
                item.MenuID = DataAccess.Enum.Menu.SRICFA.ToString();
                item.DeptID = SessionManager.DeptID;
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
                DataTable dt = ToDataTable(SricFAData);
                success = formsRepository.UpdateBulkSricFAFormData(dt, SessionManager.DataCaptYR, SessionManager.DeptID);
            }
            catch (Exception ex)
            {

            }
            return success;
        }
    }

    public class SricFaRequestViewModel
    {
        public SricFAViewModel formData { get; set; }
        public string action { get; set; }
        public string menu { get; set; }
    }
}