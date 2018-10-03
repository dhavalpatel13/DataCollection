using DataAccess.Entity;
using DataAccess.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DataCollection.Models
{
    public class RankUserViewModel
    {
        public DataAccess.Entity.RankUser RankUser { get; set; }
        public IEnumerable<SelectListItem> DeptDDLList { get; set; }
        public IEnumerable<SelectListItem> MenuDDLList { get; set; }
        public string[] MenuList { get; set; }
        public IEnumerable<SelectListItem> UserRoleDDLList { get; set; }
        public IEnumerable<SelectListItem> UserWorkDDLList { get; set; }
        public List<RankUserMenu> CurrentUserMenu { get; set; }

        public void GetLoginUser(string UserName, string Password)
        {
            RankUserRepository rankUserRepository = new RankUserRepository();
            this.RankUser = rankUserRepository.GetLoginUser(UserName, Password);
            if (RankUser != null)
            {
                this.CurrentUserMenu = rankUserRepository.GetCurrentUserMenuByUserId(RankUser.UserID);
            }
        }

        public List<RankUserMenu> GetCurrentUserMenu(string UserID)
        {
            RankUserRepository rankUserRepository = new RankUserRepository();
            return rankUserRepository.GetCurrentUserMenuByUserId(RankUser.UserID);
        }
    }


}