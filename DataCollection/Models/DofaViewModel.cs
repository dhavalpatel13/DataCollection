using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DataAccess.Entity;
using DataAccess.Repository;
using DataCollection.ManageSession;
using DataCollection.FormService;
using Newtonsoft.Json;

namespace DataCollection.Models
{
    public class DofaViewModel
    {
        public List<DofaInfo> DofaData { get; set; }
        public int DataCaptYM { get; set; }
        public int DataStatus { get; set; }
        public string DataStatusName { get; set; }

        public void GetDOFAData(int dataCaptYM, string MenuID)
        {
            FormsRepository formsRepository = new FormsRepository();
            dataCaptYM = SessionManager.DataCaptYR > 0 ? SessionManager.DataCaptYR : (dataCaptYM > 0 ? dataCaptYM : 0);
            if (MenuID == DataAccess.Enum.Menu.DOFA.ToString())
            {
                this.DofaData = formsRepository.GetDOFAFormDataByID(DataCaptYM, SessionManager.DeptID, MenuID);

                DataCaptYM = dataCaptYM;

                if (DofaData == null || DofaData.Count == 0)
                {
                    DofaData = new List<DofaInfo>();
                    DofaData.Add(new DofaInfo());
                    DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
                    DataStatusName = "Data Entry Started by Operator";
                }
                else
                {
                    DataStatus = DofaData.First().DataStatus;
                    DataStatusName = DofaData.First().DataStatusName;
                }
            }
        }

        public bool SaveDOFAData(string action)
        {
            if(DofaData==null || DofaData.Count ==0)
            {
                return false;
            }

            if (DofaData.GroupBy(n => n.empNo).Any(c => c.Count() > 1))
            {
                return false;
            }

            foreach (var item in DofaData)
            {
                item.DataUpdatedOn = DateTime.Now;
                item.DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
                if (action == "Finalize")
                {
                    item.DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryCompletedbyOperator;
                }
                else if (action == "FinalizedByHod")
                {
                    item.DataStatus = (int)DataAccess.Enum.DataStatus.DataCheckingCompletedbyHOD;
                }

                item.DataUser = SessionManager.UserName;
                item.DeptID = SessionManager.DeptID;
                item.DataValid = "Y";
                item.DataLocked = "N";
                item.DataStatusLog = SessionManager.UserName + " " + DateTime.Now.ToString("ddd, dd MMM yyyy HH:mm:ss");
                item.MenuID = DataAccess.Enum.Menu.DOFA.ToString();

            }
            return true;
        }
    }

    public class DOfaRequestViewModel
    {
        public DofaViewModel formData { get; set; }
        public string action { get; set; }
        public string menu { get; set; }
    }
}