using DataAccess.Entity;
using DataAccess.Enum;
using DataAccess.Repository;
using DataCollection.ManageSession;
using DataCollection.Models;
using System;
using System.Collections.Generic;
using System.Data;
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
                case "DOFA":
                    MenuPartial = "DOFAFormPartial";
                    break;
                case "SRICFA":
                    MenuPartial = "SRICFAFormPartial";
                    break;
                case "SRIC":
                    MenuPartial = "SRICFormPartial";
                    break;
                default:
                    break;
            }

            return MenuPartial;
        }

        public static bool IsUserLogin(string url)
        {
            return (ManageSession.SessionManager.IsUserLogin == false) 
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
                case "DOFA":
                    FormsDataViewModel = FormsViewModel.dofaViewModel;
                    break;
                case "SRICFA":
                    FormsDataViewModel = FormsViewModel.sricFAViewModel;
                    break;
                case "SRIC":
                    FormsDataViewModel = FormsViewModel.sricDeptViewModel;
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
            var UserMenu = db.UserMenus.Where(UID => UID.UserID.ToLower().Equals(UserID.ToLower()) && UID.MenuID.ToLower().Equals("all")).ToList();
            if (UserMenu.Count > 0)
            {
                if (UserID.ToLower().Equals(UserRoles.Admin.ToString().ToLower()))
                {
                    return db.MenuIDs.ToList();
                }
                else
                {
                    return db.MenuIDs.Where(a => a.MenuID1 != "USERS" && a.MenuID1 != "REPORTS").ToList();
                }
            }
            else
            {
                return (from menu in db.MenuIDs
                        join um in db.UserMenus on menu.MenuID1 equals um.MenuID
                        where um.UserID == UserID
                        select menu).ToList();
            }
        }

        public static DataCollection.Models.RankMesg GetCurrentRankMesg()
        {
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();
            return db.RankMesgs.FirstOrDefault();
        }

        public static int GetStatusByAction(string action)
        {
            if (action == "Finalize")
            {
                return (int)DataAccess.Enum.DataStatus.DataEntryCompletedbyOperator;
            }
            else if (action == "FinalizedByHod")
            {
                return (int)DataAccess.Enum.DataStatus.DataCheckingCompletedbyHOD;
            }
            else if (action == "FinalizedByAssoDean")
            {
                return (int)DataAccess.Enum.DataStatus.DataCheckedbyAssoDEAN;
            }
            else if (action == "FinalizedByDean")
            {
                return (int)DataAccess.Enum.DataStatus.DataLocked;
            }
            else if (action == "ModificationNeededHod") {
                return (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
            }
            else if (action == "ModificationNeededADean") {
                return (int)DataAccess.Enum.DataStatus.DataCheckingbyHOD;
            }
            else if (action == "ModificationNeededDean") {
                return (int)DataAccess.Enum.DataStatus.DataSenttoAssoDEAN;
            }

            return (int)DataAccess.Enum.DataStatus.DataEntryStartedbyOperator;
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

        public static bool SendFinallizeEmail(string Action, int DataCaptYM, string DeptId, string needModificationMSG)
        {
            string subject = "IRD Data Entry updated by " + SessionManager.UserName;
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();
            string tomail = "webtechrk@gmail.com";
            string body = string.Empty;

            if (Action == "Finalize" || Action == "FinalizedByHod" || Action == "FinalizedByAssoDean")
            {
                body = "The User: " + SessionManager.UserName + ", Dept: " + DeptId + " , DataCapt: " + DataCaptYM + ", IRD Data has been finalised & sent for your Authorization.  Kindly Check & Authorize/Approve the data."
                                    + "Time Stamp: DateTime Stamp: " + DateTime.Now
                                    + "This is a System generated Email.";
            }
            else if (Action == "ModificationNeededHod" || Action == "ModificationNeededADean" || Action == "ModificationNeededDean")
            {
                body = "The User: " + SessionManager.UserName + ", Dept: " + DeptId + " , DataCapt: " + DataCaptYM + ", IRD Data has been sent for Modification.  Kindly Check Modification Note for data changes. <br /> Modification Note: " + needModificationMSG
                                    + "Time Stamp: DateTime Stamp: " + DateTime.Now
                                    + "<br /> This is a System generated Email.";
            }

            if (Action == "Finalize")
            {
                var hod = db.RankUsers.Where(a => a.DeptID.ToLower() == SessionManager.DeptID.ToLower() &&
                                                  a.UserRole.ToLower() == UserRoles.User.ToString().ToLower() &&
                                                  a.UserWork.ToLower() == DataAccess.Enum.UserWork.HOD.ToString().ToLower()).FirstOrDefault();
                if (hod != null)
                {
                    tomail = hod.UserEmail;
                }
            }
            else if (Action == "FinalizedByHod")
            {
                var adsric = db.RankUsers.Where(a => a.UserRole.ToLower() == UserRoles.User.ToString().ToLower() &&
                                                  a.UserWork.ToLower() == DataAccess.Enum.UserWork.ADSRIC.ToString().ToLower()).FirstOrDefault();
                if (adsric != null)
                {
                    tomail = adsric.UserEmail;
                }
            }
            else if(Action == "FinalizedByAssoDean")
            {
                var dsric = db.RankUsers.Where(a => a.UserRole.ToLower() == UserRoles.User.ToString().ToLower() &&
                                                  a.UserWork.ToLower() == DataAccess.Enum.UserWork.DSRIC.ToString().ToLower()).FirstOrDefault();
                if (dsric != null)
                {
                    tomail = dsric.UserEmail;
                }
            }
            else if (Action == "ModificationNeededHod")
            {
                var doModification = db.RankUsers.Where(a => a.DeptID.ToLower() == SessionManager.DeptID.ToLower() &&
                                                             a.UserRole.ToLower() == UserRoles.User.ToString().ToLower() &&
                                                             a.UserWork.ToLower() == DataAccess.Enum.UserWork.DO.ToString().ToLower()).ToList();
                if (doModification != null && doModification.Count > 0)
                {
                    tomail = string.Join(",", doModification.Select(i => i.UserEmail));
                }
            }
            else if (Action == "ModificationNeededADean")
            {
                var hodModification = db.RankUsers.Where(a => a.DeptID.ToLower() == SessionManager.DeptID.ToLower() &&
                                                              a.UserRole.ToLower() == UserRoles.User.ToString().ToLower() &&
                                                              a.UserWork.ToLower() == DataAccess.Enum.UserWork.HOD.ToString().ToLower()).FirstOrDefault();
                if (hodModification != null)
                {
                    tomail = hodModification.UserEmail;
                }
            }
            else if (Action == "ModificationNeededDean")
            {
                var adeanModification = db.RankUsers.Where(a => a.UserRole.ToLower() == UserRoles.User.ToString().ToLower() &&
                                                                a.UserWork.ToLower() == DataAccess.Enum.UserWork.ADSRIC.ToString().ToLower()).FirstOrDefault();
                if (adeanModification != null)
                {
                    tomail = adeanModification.UserEmail;
                }
            }


            FormServices formServices = new FormServices();
            return formServices.SendEmail(tomail, "", subject, body);
        }

        public static string ConvertDataTableToHTML(DataTable dt)
        {
            string html = "<table class=\"table\">";
            //add header row
            html += "<thead><tr>";
            for (int i = 0; i < dt.Columns.Count; i++)
                html += "<th>" + dt.Columns[i].ColumnName + "</th>";
            html += "</tr></thead><tbody>";
            //add rows
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                html += "<tr>";
                for (int j = 0; j < dt.Columns.Count; j++)
                    html += "<td>" + dt.Rows[i][j].ToString() + "</td>";
                html += "</tr>";
            }
            html += "</tbody></table>";
            return html;
        }
    }
}