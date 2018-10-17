using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DataAccess.Entity;
using DataAccess.Repository;
using DataCollection.ManageSession;
using System.Data;
using System.Reflection;
using System.Web.Mvc;

namespace DataCollection.Models
{
    public class BaseViewModel
    {
        public DataTable ToDataTable<T>(List<T> items)
        {
            DataTable dataTable = new DataTable(typeof(T).Name);

            //Get all the properties
            PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (PropertyInfo prop in Props)
            {
                //Defining type of data column gives proper data table 
                var type = (prop.PropertyType.IsGenericType && prop.PropertyType.GetGenericTypeDefinition() == typeof(Nullable<>) ? Nullable.GetUnderlyingType(prop.PropertyType) : prop.PropertyType);
                //Setting column names as Property names
                dataTable.Columns.Add(prop.Name, type);
            }
            foreach (T item in items)
            {
                var values = new object[Props.Length];
                for (int i = 0; i < Props.Length; i++)
                {
                    //inserting property values to datatable rows
                    values[i] = Props[i].GetValue(item, null);
                }
                dataTable.Rows.Add(values);
            }
            //put a breakpoint here and check datatable
            return dataTable;
        }

        public List<SelectListItem> GetDOFADeptDropdownData()
        {
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();
            List<SelectListItem> DeptDDLList = new List<SelectListItem>()
            { new SelectListItem() { Text = "-- Select --", Value = "" } };

            DeptDDLList.AddRange(db.Depts.Where(w => w.DeptType == 'A').Select(i => new SelectListItem { Text = i.DeptName, Value = i.DeptID }));

            return DeptDDLList;
        }
    }

    public class DofaViewModel : BaseViewModel
    {
        public List<DofaInfo> DofaData { get; set; }
        public int DataCaptYM { get; set; }
        public int DataStatus { get; set; }
        public string DataStatusName { get; set; }

        public string EmpDept { get; set; }

        public void GetDOFAData(int _dataCaptYM, string empDept = "")
        {
            EmpDept = empDept;
            FormsRepository formsRepository = new FormsRepository();
            DataCaptYM = SessionManager.DataCaptYR > 0 ? SessionManager.DataCaptYR : (_dataCaptYM > 0 ? _dataCaptYM : 0);

            this.DofaData = formsRepository.GetDOFAFormDataByID(DataCaptYM, SessionManager.DeptID ,empDept);

            

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

            if (!string.IsNullOrWhiteSpace(EmpDept))
            {
                DofaData.ForEach(f => f.empDEPT = EmpDept);
            }
        }

        public bool SaveDOFAData(string action, out string msg)
        {
            msg = string.Empty;
            bool success = false;
            if (DofaData==null || DofaData.Count ==0)
            {
                return success;
            }

            if (DofaData.Any(n => n.empNo <= 0 || string.IsNullOrWhiteSpace(n.empName) || string.IsNullOrWhiteSpace(n.empDEPT)))
            {
                msg = "Minimum EmpNo, Name, Dept should not be blank";
                return success;
            }

            if (DofaData.GroupBy(n => n.empNo).Any(c => c.Count() > 1))
            {
                msg = "Duplicate EmpNo Exist.! Data saving aborted.";
                return success;
            }
            

            foreach (var item in DofaData)
            {
                item.MenuID = DataAccess.Enum.Menu.DOFA.ToString();
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
                DataTable dt = ToDataTable(DofaData);
                success = formsRepository.UpdateBulkDOFAFormData(dt, SessionManager.DataCaptYR, SessionManager.DeptID, EmpDept);
            }
            catch (Exception ex)
            {
                
            }
            return success;
        }
    }

    public class DofaRequestViewModel
    {
        public DofaViewModel formData { get; set; }
        public string action { get; set; }
        public string menu { get; set; }
    }
}