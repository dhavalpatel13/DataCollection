using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Entity
{
    public class stInfo2 : CommonProp
    { 
        public decimal stFeeUGInt { get; set; }
        public decimal stFeePGInt { get; set; }
        public decimal stFeePHDInt { get; set; }
        public decimal stFeeUGNat { get; set; }
        public decimal stFeePGNat { get; set; }
        public decimal stFeePHDNat { get; set; }
        public int stExchUGInFT { get; set; }
        public int stExchUGInPT { get; set; }
        public int stExchUGOutFT { get; set; }
        public int stExchUGOutPT { get; set; }
        public int stExchPGInFT { get; set; }
        public int stExchPGInPT { get; set; }
        public int stExchPGOutFT { get; set; }
        public int stExchPGOutPT { get; set; }     
    }
}
