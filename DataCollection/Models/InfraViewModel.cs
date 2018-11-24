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
        public bool IsInfraInfoVisible { get; set; }
        public int DataCaptYM { get; set; }
        public int DataStatus { get; set; }
        public string DataStatusName { get; set; }

        public void GetInfraData(int _dataCaptYM)
        {
            FormsRepository formsRepository = new FormsRepository();
            DataCaptYM = SessionManager.DataCaptYR > 0 ? SessionManager.DataCaptYR : (_dataCaptYM > 0 ? _dataCaptYM : 0);

            var data = formsRepository.GetInfraFormDataByID(DataCaptYM, SessionManager.DeptID);

            InfraDeptData = data.Item1;
            InfraInfoData = data.Item2;

            if (SessionManager.DeptID == "EW")
            {
                IsInfraInfoVisible = true;
            }

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
                    DataStatusName = (DataAccess.Enum.DataStatus.DataEntryStartedbyOperator).GetStringValue();
                }
            }
        }

        public bool SaveInfraData(string action, out string msg)
        {
            msg = string.Empty;
            bool success = false, IsInfraInfoVisible = false;

            if (InfraDeptData == null || InfraDeptData.Count == 0)
            {
                return success;
            }

            foreach (var item in InfraDeptData)
            {
                item.MenuID = DataAccess.Enum.Menu.INFRA.ToString();
                item.DeptID = SessionManager.DeptID;
                item.DataUser = SessionManager.UserName;
                item.DataUpdatedOn = DateTime.Now;
                item.DataCaptYM = SessionManager.DataCaptYR;
                item.DataStatus = FormCommonMethods.GetStatusByAction(action);
                item.DataValid = "Y";
                item.DataLocked = "N";
                item.DataStatusLog = SessionManager.UserName + " " + DateTime.Now.ToString("ddd, dd MMM yyyy HH:mm:ss");
            }

            if (SessionManager.DeptID == "EW")
            {
                IsInfraInfoVisible = true;
                foreach (var item in InfraInfoData)
                {
                    item.MenuID = DataAccess.Enum.Menu.INFRA.ToString();
                    item.DataUser = SessionManager.UserName;
                    item.DeptID = SessionManager.DeptID;
                    item.DataUpdatedOn = DateTime.Now;
                    item.DataCaptYM = SessionManager.DataCaptYR;
                    item.DataStatus = FormCommonMethods.GetStatusByAction(action);
                    item.DataValid = "Y";
                    item.DataLocked = "N";
                    item.DataStatusLog = SessionManager.UserName + " " + DateTime.Now.ToString("ddd, dd MMM yyyy HH:mm:ss");
                }
            }
            else
            {
                IsInfraInfoVisible = false;
                InfraInfoData = new List<InfraInfo>();
                InfraInfo item = new InfraInfo();
                item.DeptID = SessionManager.DeptID;
                item.MenuID = DataAccess.Enum.Menu.INFRA.ToString();
                item.DataUser = SessionManager.UserName;
                item.DataUpdatedOn = DateTime.Now;
                item.DataCaptYM = SessionManager.DataCaptYR;
                item.DataStatus = FormCommonMethods.GetStatusByAction(action);
                item.DataValid = "Y";
                item.DataLocked = "N";
                item.DataStatusLog = SessionManager.UserName + " " + DateTime.Now.ToString("ddd, dd MMM yyyy HH:mm:ss");
                InfraInfoData.Add(item);

            }

            try
            {
                FormsRepository formsRepository = new FormsRepository();
                DataTable dtInfraInfo = null;
                DataTable dtInfraDept = ToDataTable(InfraDeptData);
                dtInfraInfo = ToDataTable(InfraInfoData);
                success = formsRepository.UpdateBulkInfraFormData(dtInfraDept, dtInfraInfo, SessionManager.DataCaptYR, IsInfraInfoVisible);
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