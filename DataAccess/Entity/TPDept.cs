using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace DataAccess.Entity
{
    public class TPDept
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
        public int? StRegUGFT { get; set; }
        public int? StOfferUGFT { get; set; }
        public decimal? StHighSalUGFT { get; set; }
        public decimal? StMedianSalUGFT { get; set; }
        public decimal? StLowestSalUGFT { get; set; }
        public int? StRegUG5FT { get; set; }
        public int? StOfferUG5FT { get; set; }
        public decimal? StHighSalUG5FT { get; set; }
        public decimal? StMedianSalUG5FT { get; set; }
        public decimal? StLowestSalUG5FT { get; set; }
        public int? StRegPGFT { get; set; }
        public int? StOfferPGFT { get; set; }
        public decimal? StHighSalPGFT { get; set; }
        public decimal? StMedianSalPGFT { get; set; }
        public decimal? StLowestSalPGFT { get; set; }
        public int? StRegPGPT { get; set; }
        public int? StOfferPGPT { get; set; }
        public decimal? StHighSalPGPT { get; set; }
        public decimal? StMedianSalPGPT { get; set; }
        public decimal? StLowestSalPGPT { get; set; }

    }
}
