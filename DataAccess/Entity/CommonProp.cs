using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Entity
{
    public class IdProp
    {
        public int IDNo { get; set; }
    }

    public class BaseProp : IdProp
    {
        public int DataCaptYM { get; set; }
        public string DeptID { get; set; }
        public string DeptName { get; set; }
        public string MenuID { get; set; }
    }

    public class CommonProp : BaseProp
    {   
        public string DataUser { get; set; }
        public DateTime DataUpdatedOn { get; set; }
        public int DataStatus { get; set; }
        public string DataStatusName { get; set; }
        public string DataStatusLog { get; set; }
        public string DataValid { get; set; }
        public string DataLocked { get; set; }
    }

    public class CommonSaveUpdateProp
    {
        public string action { get; set; }
        public object formData { get; set; }
        public string menu { get; set; }
    }
}
