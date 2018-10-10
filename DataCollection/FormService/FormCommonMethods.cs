using DataAccess.Entity;
using DataAccess.Enum;
using DataAccess.Repository;
using DataCollection.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace DataCollection.FormService
{
    public static class FormCommonMethods
    {
        public static string GetMenuPartial(string Menu)
        {
            string MenuPartial = "DOAAFormPartial";
            switch (Menu)
            {
                case "DOAA":
                    MenuPartial = "DOAAFormPartial";
                    break;
                case "ADIR":
                    MenuPartial = "ADIRFormPartial";
                    break;
                case "DOSW":
                    MenuPartial = "DOSWFormPartial";
                    break;
                case "LIBFORM":
                    MenuPartial = "LIBFormPartial";
                    break;
                default:
                    break;
            }

            return MenuPartial;
        }

        public static bool IsUserLogin(string url)
        {
            return (DataCollection.ManageSession.SessionManager.IsUserLogin == null || DataCollection.ManageSession.SessionManager.IsUserLogin == false) 
                    && (!url.Equals("/User/Login") && !url.Equals("/User/Registration")
                    && !url.StartsWith("/User/VerifyAccount") && !url.Equals("/User/ForgotPassword") && !url.StartsWith("/User/ResetPassword") && !url.StartsWith("/AboutUs") && !url.StartsWith("/Contact"));
        }

        public static object GetDynamicViewModel(string Menu, FormsViewModel FormsViewModel)
        {
            object FormsDataViewModel = FormsViewModel.info;
            switch (Menu)
            {
                case "DOAA":
                    FormsDataViewModel = FormsViewModel.info;
                    break;
                case "ADIR":
                case "DOSW":
                    FormsDataViewModel = FormsViewModel.info2;
                    break;
                case "LIBFORM":
                    FormsDataViewModel = FormsViewModel.libInfo;
                    break;
                default:
                    break;
            }

            return FormsDataViewModel;
        }
        

        public static string Hash(string value)
        {
            return Convert.ToBase64String(
                System.Security.Cryptography.SHA256.Create()
                .ComputeHash(Encoding.UTF8.GetBytes(value))
                );
        }

        public static string Encryptdata(string password)
        {
            string strmsg = string.Empty;
            byte[] encode = new byte[password.Length];
            encode = Encoding.UTF8.GetBytes(password);
            strmsg = Convert.ToBase64String(encode);
            return strmsg;
        }
        public static string Decryptdata(string encryptpwd)
        {
            string decryptpwd = string.Empty;
            UTF8Encoding encodepwd = new UTF8Encoding();
            Decoder Decode = encodepwd.GetDecoder();
            byte[] todecode_byte = Convert.FromBase64String(encryptpwd);
            int charCount = Decode.GetCharCount(todecode_byte, 0, todecode_byte.Length);
            char[] decoded_char = new char[charCount];
            Decode.GetChars(todecode_byte, 0, todecode_byte.Length, decoded_char, 0);
            decryptpwd = new String(decoded_char);
            return decryptpwd;
        }

        public static List<RankUserMenu> GetCurrentUserMenu(string UserID)
        {
            RankUserRepository rankUserRepository = new RankUserRepository();
            return rankUserRepository.GetCurrentUserMenuByUserId(UserID);
        }

        public static List<MenuID> GetCurrentUserMenu(string UserID, string UserRole)
        {
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();
            if (UserRole.ToLower().Trim() == UserRoles.Admin.ToString().ToLower())
                return db.MenuIDs.ToList();
            else
                return (from menu in db.MenuIDs
                        join um in db.UserMenus on menu.MenuID1 equals um.MenuID
                        where um.UserID == UserID
                        select menu).ToList();
        }

        public static DataCollection.Models.RankMesg GetCurrentRankMesg()
        {
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();
            return db.RankMesgs.FirstOrDefault();
        }

        public static DataAccess.Entity.RankUser ToEntityRankUserMap(DataCollection.Models.RankUser rankUser)
        {
            DataAccess.Entity.RankUser eRankUser = new DataAccess.Entity.RankUser();
            eRankUser.DeptID = rankUser.DeptID;
            eRankUser.UserCreatedOn = rankUser.UserCreatedOn;
            eRankUser.UserDisabledOn = rankUser.UserDisabledOn;
            eRankUser.UserEmail = rankUser.UserEmail;
            eRankUser.UserEmpNo = rankUser.UserEmpNo;
            eRankUser.UserID = rankUser.UserID;
            eRankUser.UserMob = rankUser.UserMob;
            eRankUser.UserName = rankUser.UserName;
            eRankUser.UserPassword = FormCommonMethods.Decryptdata(rankUser.UserPassword);
            eRankUser.UserRemarks = rankUser.UserRemarks;
            eRankUser.UserRole = rankUser.UserRole;
            eRankUser.UserValid = Convert.ToString(rankUser.UserValid);
            eRankUser.UserWork = rankUser.UserWork;

            return eRankUser;
        }
    }
}