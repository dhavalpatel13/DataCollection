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
    public class InfraViewModel : BaseViewModel
    {
        public List<InfraDept> InfraDeptData { get; set; }
        public List<InfraInfo> InfraInfoData { get; set; }

        public int DataCaptYM { get; set; }
        public int DataStatus { get; set; }
        public string DataStatusName { get; set; }

        public void GetInfraData(int _dataCaptYM)
        {
            FormsRepository formsRepository = new FormsRepository();
            DataCaptYM = SessionManager.DataCaptYR > 0 ? SessionManager.DataCaptYR : (_dataCaptYM > 0 ? _dataCaptYM : 0);

            var data = formsRepository.GetInfraFormDataByID(DataCaptYM);

            InfraDeptData = data.Item1;
            InfraInfoData = data.Item2;

            if (InfraDeptData == null || InfraInfoData == null || InfraDeptData.Count == 0 || InfraInfoData.Count == 0)
            {
                throw new Exception("Invalid Data");
            }
            else
            {
                DataStatus = InfraDeptData.First().DataStatus;
                DataStatusName = InfraDeptData.First().DataStatusName;

                if (DataStatus == 0)
                {
                    DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
                    DataStatusName = "Data Entry Started by Operator";
                }
            }
        }

        public bool SaveInfraData(string action, out string msg)
        {
            msg = string.Empty;
            bool success = false;
            if (InfraDeptData == null || InfraDeptData.Count == 0)
            {
                return success;
            }

            foreach (var item in InfraDeptData)
            {
                item.MenuID = DataAccess.Enum.Menu.INFRA.ToString();
                item.DataUser = SessionManager.UserName;
                item.DataUpdatedOn = DateTime.Now;
                item.DataCaptYM = SessionManager.DataCaptYR;
                item.DataStatus = FormCommonMethods.GetStatusByAction(action);
                item.DataValid = "Y";
                item.DataLocked = "N";
                item.DataStatusLog = SessionManager.UserName + " " + DateTime.Now.ToString("ddd, dd MMM yyyy HH:mm:ss");
            }

            foreach (var item in InfraInfoData)
            {
                item.MenuID = DataAccess.Enum.Menu.INFRA.ToString();
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
                DataTable dtInfraDept = ToDataTable(InfraDeptData);
                DataTable dtInfraInfo = ToDataTable(InfraInfoData);
                success = formsRepository.UpdateBulkInfraFormData(dtInfraDept, dtInfraInfo, SessionManager.DataCaptYR);
            }
            catch (Exception ex)
            {

            }
            return success;
        }
    }

    public class InfraRequestViewModel
    {
        public InfraViewModel formData { get; set; }
        public string action { get; set; }
        public string menu { get; set; }
        public string needModificationMSG { get; set; }
    }
}