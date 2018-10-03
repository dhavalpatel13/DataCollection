using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DataAccess.Entity;
using DataCollection.Models;

namespace DataCollection.ManageSession
{
    public static class SessionManager
    {
        const string USERID = "UserId";
        const string USERNAME = "UserName";
        const string USERROLE = "UserRole";
        const string ISUSERLOGIN = "IsUserLogin";
        const string DEPTID = "DeptID";
        const string MENUID = "MENUID";
        const string RANKUSERMENU = "RANKUSERMENU";
        const string MENULIST = "MENULIST";
        const string DATACAPTYR = "DATACAPTYR";
        const string USERWORK = "UserWork";

        public static string UserId
        {
            get
            {
                string UserId = string.Empty; 
                if (HttpContext.Current.Session[USERID] != null && HttpContext.Current.Session[USERID].ToString().Trim().Length > 0)
                {
                    UserId = Convert.ToString(HttpContext.Current.Session[USERID]);                    
                }
                return UserId;
            }
            set
            {
                HttpContext.Current.Session[USERID] = value;
            }
        }

        public static string UserName
        {
            get
            {
                string _UserName = string.Empty;
                if (HttpContext.Current.Session[USERNAME] != null && HttpContext.Current.Session[USERNAME].ToString().Trim().Length > 0)
                {
                    _UserName = Convert.ToString(HttpContext.Current.Session[USERNAME]);
                }
                return _UserName;
            }
            set
            {
                HttpContext.Current.Session[USERNAME] = value;
            }
        }

        public static string UserRole
        {
            get
            {   
                string _UserRole = string.Empty;
                if (HttpContext.Current.Session[USERROLE] != null && HttpContext.Current.Session[USERROLE].ToString().Trim().Length > 0)
                {
                    _UserRole = Convert.ToString(HttpContext.Current.Session[USERROLE].ToString());
                }
                return _UserRole;
            }
            set
            {
                HttpContext.Current.Session[USERROLE] = value;
            }
        }

        public static string UserWork
        {
            get
            {
                string _UserWork = string.Empty;
                if (HttpContext.Current.Session[USERWORK] != null && HttpContext.Current.Session[USERWORK].ToString().Trim().Length > 0)
                {
                    _UserWork = Convert.ToString(HttpContext.Current.Session[USERWORK].ToString());
                }
                return _UserWork;
            }
            set
            {
                HttpContext.Current.Session[USERWORK] = value;
            }
        }

        public static bool IsUserLogin
        {
            get
            {
                bool _IsUserLogin = false;
                if (HttpContext.Current.Session[ISUSERLOGIN] != null && HttpContext.Current.Session[ISUSERLOGIN].ToString().Trim().Length > 0)
                {
                    _IsUserLogin = Convert.ToBoolean(HttpContext.Current.Session[ISUSERLOGIN].ToString());
                }
                return _IsUserLogin;
            }
            set
            {
                HttpContext.Current.Session[ISUSERLOGIN] = value;
            }
        }

        public static string DeptID
        {
            get
            {
                string _DeptID = string.Empty;
                if (HttpContext.Current.Session[DEPTID] != null && HttpContext.Current.Session[DEPTID].ToString().Trim().Length > 0)
                {
                    _DeptID = Convert.ToString(HttpContext.Current.Session[DEPTID].ToString());
                }
                return _DeptID;
            }
            set
            {
                HttpContext.Current.Session[DEPTID] = value;
            }
        }

        public static string MenuID
        {
            get
            {
                string _MenuID = string.Empty;
                if (HttpContext.Current.Session[MENUID] != null && HttpContext.Current.Session[MENUID].ToString().Trim().Length > 0)
                {
                    _MenuID = Convert.ToString(HttpContext.Current.Session[MENUID].ToString());
                }
                return _MenuID;
            }
            set
            {
                HttpContext.Current.Session[MENUID] = value;
            }
        }

        public static List<RankUserMenu> RankUserMenu
        {
            get
            {
                List<RankUserMenu> _RankUserMenu = null;
                if (HttpContext.Current.Session[RANKUSERMENU] != null && HttpContext.Current.Session[RANKUSERMENU].ToString().Trim().Length > 0)
                {
                    _RankUserMenu = (List<RankUserMenu>)HttpContext.Current.Session[RANKUSERMENU];
                }
                return _RankUserMenu;
            }
            set
            {
                HttpContext.Current.Session[RANKUSERMENU] = value;
            }
        }

        public static List<MenuID> MenuList
        {
            get
            {
                List<MenuID> _MenuList = null;
                if (HttpContext.Current.Session[MENULIST] != null && HttpContext.Current.Session[MENULIST].ToString().Trim().Length > 0)
                {
                    _MenuList = (List<MenuID>)HttpContext.Current.Session[MENULIST];
                }
                return _MenuList;
            }
            set
            {
                HttpContext.Current.Session[MENULIST] = value;
            }
        }

        public static int DataCaptYR
        {
            get
            {
                int _DataCaptYR;
                if (HttpContext.Current.Session[DATACAPTYR] != null && HttpContext.Current.Session[DATACAPTYR].ToString().Trim().Length > 0)
                {
                    int.TryParse(HttpContext.Current.Session[DATACAPTYR].ToString(), out _DataCaptYR);
                    return _DataCaptYR;
                }
                return 0;
            }
            set
            {
                HttpContext.Current.Session[DATACAPTYR] = value;
            }
        }
    }
}