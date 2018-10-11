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

        public void GetDOFAData(int DataCaptYM, string MenuID)
        {
            FormsRepository formsRepository = new FormsRepository();
            DataCaptYM = SessionManager.DataCaptYR > 0 ? SessionManager.DataCaptYR : (DataCaptYM > 0 ? DataCaptYM : 0);
            if (MenuID == DataAccess.Enum.Menu.DOFA.ToString())
            {
                this.DofaData = formsRepository.GetDOFAFormDataByID(DataCaptYM, SessionManager.DeptID, MenuID);
                if (DofaData == null)
                {
                    DofaData = new List<DofaInfo>();
                    DofaData.Add(new DofaInfo {
                        DataStatus = (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator,
                        DataStatusName = "Data Entry Started by Operator",
                        DataCaptYM = DataCaptYM,
                        DeptName = SessionManager.DeptID,
                        DeptID = SessionManager.DeptID
                    });
                }
            }
        }
    }
}