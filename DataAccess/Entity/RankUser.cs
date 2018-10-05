using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Entity
{    
    public class RankUser
    {
        public string UserID { get; set; }
        public string UserPassword { get; set; }
        public string ConfirmUserPassword { get; set; }
        public string UserEmpNo { get; set; }
        public string UserName { get; set; }
        public string MenuID { get; set; }
        public string DeptID { get; set; }
        public string UserRole { get; set; }
        public string UserWork { get; set; }
        public string UserMob { get; set; }        
        public string UserEmail { get; set; }
        public string UserValid { get; set; }
        public DateTime? UserCreatedOn { get; set; }
        public DateTime? UserDisabledOn { get; set; }
        public string UserRemarks { get; set; }
        public string RankMsg { get; set; }
        public bool IsEmailVerified { get; set; }
        public Guid ActivationCode { get; set; }
    }

    public class RankUserMenu
    {
        public string UserMenuID { get; set; }
        public string UserID { get; set; }
        public string MenuID { get; set; }        
    }

    public class RankMesg
    {
        public string Message { get; set; }
    }
}
