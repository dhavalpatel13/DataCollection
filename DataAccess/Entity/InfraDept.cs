using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace DataAccess.Entity
{
    public class InfraDept
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
        public int? ClassRooms { get; set; }
        public int? Labs { get; set; }
        public int? Auditoriums { get; set; }
        public int? ConfRooms { get; set; }
        public int? FaclCabins { get; set; }
        public int? CompLabs { get; set; }
        public int? SplLabs { get; set; }
        public int? OtherLabs { get; set; }

    }
}
