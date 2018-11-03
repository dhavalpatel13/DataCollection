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
    public class DofaPeerViewModel : BaseViewModel
    {
        public List<DofaPeer> DofaPeerData { get; set; }

        public int DataCaptYM { get; set; }
        public int DataStatus { get; set; }
        public string DataStatusName { get; set; }

        public void GetDofaPeerData(int _dataCaptYM)
        {
            DataCaptYM = SessionManager.DataCaptYR > 0 ? SessionManager.DataCaptYR : (_dataCaptYM > 0 ? _dataCaptYM : 0);
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();
            if (DataCaptYM > 0)
            {
                DofaPeerData = db.DofaPeers.Where(a => a.DataCaptYM == DataCaptYM && a.DeptID == SessionManager.DeptID && a.MenuID == DataAccess.Enum.Menu.DOFAPEER.ToString()).ToList();                
            }

            if (DofaPeerData == null || DofaPeerData.Count == 0)
            {
                DofaPeerData = new List<DofaPeer>();
                DofaPeerData.Add(new DofaPeer());
                DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
                DataStatusName = "Data Entry Started by Operator";
            }
            else
            {
                DataStatus = (int)DofaPeerData.First().DataStatus;
                DataStatusName = ((DataAccess.Enum.DataStatus)DataStatus).ToString();
            }
        }

        public bool SaveDofaPeerData(string action, out string msg)
        {
            msg = string.Empty;
            bool success = false;
            if (DofaPeerData == null || DofaPeerData.Count == 0)
            {
                return success;
            }

            if (DofaPeerData.Any(n => n.empNo <= 0))
            {
                msg = "Employee Required";
                return success;
            }

            DataCollectionModelDataContext db = new DataCollectionModelDataContext();
            string empNotExist = string.Empty;
            foreach (var item in DofaPeerData)
            {
                var emp = db.dofaInfos.Where(a => a.empNo == item.empNo).FirstOrDefault();
                if (emp != null)
                {
                    item.empNo = item.empNo;
                    item.MenuID = DataAccess.Enum.Menu.DOFAPEER.ToString();
                    item.DeptID = SessionManager.DeptID;
                    item.DataUser = SessionManager.UserName;
                    item.DataUpdatedOn = DateTime.Now;
                    item.DataCaptYM = SessionManager.DataCaptYR;
                    item.DataStatus = (short)FormCommonMethods.GetStatusByAction(action);
                    item.DataValid = Convert.ToChar("Y");
                    item.DataLocked = Convert.ToChar("N");
                    item.DataStatusLog = SessionManager.UserName + " " + DateTime.Now.ToString("ddd, dd MMM yyyy HH:mm:ss");
                    item.PeerDept = emp.empDEPT;
                }
                else
                {
                    if (string.IsNullOrEmpty(empNotExist))
                        empNotExist = Convert.ToString(emp.empNo);
                    else
                        empNotExist = empNotExist + " ," + emp.empNo;
                }
            }

            if (!string.IsNullOrEmpty(empNotExist))
            {
                msg = empNotExist + "Employee Not Exist.";
                return success;
            }

            try
            {
                //List<DofaPeer> DofaPeerDataInsert = DofaPeerData.Where(a => a.IDNo <= 0).ToList();
                //db.DofaPeers.InsertAllOnSubmit(DofaPeerDataInsert);
                //db.SubmitChanges();

                //List<DofaPeer> DofaPeerDataUpdate = DofaPeerData.Where(a => a.IDNo > 0).ToList();
                //foreach (DofaPeer item in DofaPeerDataUpdate)
                //{
                //    using (DataCollectionModelDataContext db1 = new DataCollectionModelDataContext())
                //    {
                //        DofaPeer DofaPeer = db1.DofaPeers.Where(a => a.IDNo == item.IDNo).FirstOrDefault();
                //        if (DofaPeer != null)
                //        {
                //            DofaPeer = item;
                //            db1.SubmitChanges();
                //        }
                //    }
                //}
                FormsRepository formsRepository = new FormsRepository();
                DataTable dt = ToDataTable(DofaPeerData);
                success = formsRepository.UpdateBulkDofaPeerFormData(dt, SessionManager.DataCaptYR, SessionManager.DeptID);
            }
            catch (Exception ex)
            {

            }
            return success;
        }
    }

    public class DofaPeerRequestViewModel
    {
        public DofaPeerViewModel formData { get; set; }
        public string action { get; set; }
        public string menu { get; set; }
        public string needModificationMSG { get; set; }
    }
}