using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace DataAccess.Entity
{
    public class DofaInfo
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
        public int empNo { get; set; }
        public string empName { get; set; }
        public DateTime? empDOB { get; set; }
        public DateTime? empDOJ { get; set; }
        public DateTime? empDOL { get; set; }
        public string empGender { get; set; }
        public string empDESG { get; set; }
        public string empDEPT { get; set; }
        public string empPAN { get; set; }
        public string empType { get; set; }
        public string empCat { get; set; }
        public string empNation { get; set; }
        public int? QualHighYear { get; set; }
        public string QualHighCourse { get; set; }
        public string QualHighInst { get; set; }
        public int? ExpAcadMon { get; set; }
        public int? ExpIndMon { get; set; }
        public string FacExcgIn { get; set; }
        public string FacExcgOut { get; set; }
        public int? ConfSymSemNat { get; set; }
        public int? ConfSymSemInt { get; set; }
        public string AwardHonors { get; set; }

    }
}
