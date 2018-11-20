using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace DataAccess.Entity
{
    public class FinInfo
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
        public string FinYear { get; set; }
        public decimal? ExpCapAAR { get; set; }
        public decimal? ExpLibOverall { get; set; }
        public decimal? ExpLibEngg { get; set; }
        public decimal? ExpLibMgmt { get; set; }
        public decimal? ExpLibArch { get; set; }
        public decimal? ExpNewEqpLabs { get; set; }
        public decimal? ExpEnggWS { get; set; }
        public decimal? ExpStudios { get; set; }
        public decimal? ExpOtherCapAssets { get; set; }
        public decimal? ExpOperational { get; set; }
        public decimal? ExpMaintRun { get; set; }
        public decimal? ExpSalT { get; set; }
        public decimal? ExpSalNT { get; set; }
        public decimal? ExpMisc1 { get; set; }
        public decimal? ExpMisc2 { get; set; }
        public decimal? ExpTotal { get; set; }
        public string ExpRemarks { get; set; }
        public decimal? SchFsUGFT { get; set; }
        public decimal? SchFsUG5FT { get; set; }
        public decimal? SchFsPGFT { get; set; }
        public decimal? SchFsPGPT { get; set; }
        public decimal? SchSSUGFT { get; set; }
        public decimal? SchSSUG5FT { get; set; }
        public decimal? SchSSPGFT { get; set; }
        public decimal? SchSSPGPT { get; set; }
        public decimal? SchTotal { get; set; }
        public string SchRemarks { get; set; }

    }
}
