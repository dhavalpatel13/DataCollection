using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace DataAccess.Entity
{
    public class SricFA
    {
        public int IDNo { get; set; }
        public int DataCaptYM { get; set; }
        public string DeptID { get; set; }
        public string DeptName { get; set; }
        public string MenuID { get; set; }
        public string DataUser { get; set; }
        public DateTime DataUpdatedOn { get; set; }
        public int DataStatus { get; set; }
        public string DataStatusName { get; set; }
        public string DataStatusLog { get; set; }
        public string DataValid { get; set; }
        public string DataLocked { get; set; }
        public string FAName { get; set; }
        public int? FASRProjQty { get; set; }
        public decimal? FASRProjOutlay { get; set; }
        public decimal? FASRProjRcp { get; set; }
        public int? FAICProjQty { get; set; }
        public decimal? FAICProjOutlay { get; set; }
        public decimal? FAICProjRcp { get; set; }
        public int? ResStaffNPDF { get; set; }
        public int? ResStaffPC { get; set; }
        public int? ResStaffPF { get; set; }
        public int? ResStaffRFSR { get; set; }
        public int? ResStaffRA { get; set; }
    }
}
