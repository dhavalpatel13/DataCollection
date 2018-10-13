using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace DataAccess.Entity
{
    public class SricDept
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
        public int? SRProjQty { get; set; }
        public int? SRFAQty { get; set; }
        public decimal? SRProjOutlay { get; set; }
        public decimal? SRProjRcp { get; set; }
        public int? ICProjQty { get; set; }
        public int? ICFAQty { get; set; }
        public decimal? ICProjOutlay { get; set; }
        public decimal? ICProjRcp { get; set; }
        public int? ConfSSNat { get; set; }
        public decimal? ConfSSNatExp { get; set; }
        public int? ConfSSInt { get; set; }
        public decimal? ConfSSIntExp { get; set; }
        public int? IPRFiled { get; set; }
        public int? IPRPub { get; set; }
        public int? IPRGranted { get; set; }
        public int? IPRLicensed { get; set; }
        public int? TechXferFiled { get; set; }
        public int? TechXferPub { get; set; }
        public int? TechXferGranted { get; set; }
        public int? TechXferLicensed { get; set; }
        public int? CopyRightsFiled { get; set; }
        public int? CopyRightsPub { get; set; }
        public int? CopyRightsGranted { get; set; }
        public int? CopyRightsLicensed { get; set; }
        public int? LogoDesignFiled { get; set; }
        public int? LogoDesignPub { get; set; }
        public int? LogoDesignGranted { get; set; }
        public int? LogoDesignLicensed { get; set; }
    }
}
