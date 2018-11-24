using DataAccess.Repository;
using DataCollection.FormService;
using DataCollection.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DataCollection.Controllers
{
    [Authorize(Roles = "Admin")]
    public class AdminController : Controller
    {
        //
        // GET: /Admin/
        public ActionResult Index()
        {
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();
            IEnumerable<DataCollection.Models.RankUser> RankUser = db.RankUsers.Where(a => (a.DeptID.ToLower().Trim() != "admin" || a.DeptID == null) && a.IsEmailVerified == true).ToList();
            return View(RankUser);
        }

        public ActionResult Table()
        {
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();
            var AllTables = db.Get_All_Table().ToList();

            TableViewModel TableViewModel = new TableViewModel();
            TableViewModel.Tables = AllTables.Select(i => new SelectListItem() { Text = i.Name, Value = i.Name }).AsEnumerable();
            return View(TableViewModel);
        }

        public string GetTableDetail(string TableName)
        {
            RankUserRepository rankUser = new RankUserRepository();
            DataTable TableDetail = rankUser.GetTableDetail(TableName);
            return FormCommonMethods.ConvertDataTableToHTML(TableDetail);
        }

        public ActionResult RankMessage()
        {
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();
            RankMessageViewModel rankMessageViewModel = new RankMessageViewModel();
            var RankMesgs = db.RankMesgs.FirstOrDefault();
            if (RankMesgs != null)
            {
                rankMessageViewModel.RankMessageId = RankMesgs.Id;
                rankMessageViewModel.RankMessage = RankMesgs.Message;
            }
            return View(rankMessageViewModel);
        }

        public bool SaveRankMessage(string RankMessageId, string RankMessage)
        {
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();
            try
            {
                if (Convert.ToInt32(RankMessageId) > 0)
                {
                    var RankMesgs = db.RankMesgs.Where(a => a.Id == Convert.ToInt32(RankMessageId)).FirstOrDefault();
                    if (RankMesgs != null)
                    {
                        RankMesgs.Message = RankMessage;
                    }
                    db.SubmitChanges();
                }
                else
                {
                    RankMesg rankMesgs = new RankMesg();
                    rankMesgs.Message = RankMessage;
                    db.RankMesgs.InsertOnSubmit(rankMesgs);
                    db.SubmitChanges();
                }
                return true;
            }
            catch
            {
                return false;
            }
        }

        public ActionResult EditUserDetail(string UserId)
        {
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();
            RankUserViewModel rankUserViewModel = new RankUserViewModel();

            RankUser RankUser = db.RankUsers.Where(a => a.UserID == UserId).FirstOrDefault();
            rankUserViewModel.RankUser = FormCommonMethods.ToEntityRankUserMap(RankUser);

            rankUserViewModel.MenuList = (from post in db.UserMenus
                                          join menu in db.MenuIDs on post.MenuID equals menu.MenuID1
                                          where post.UserID == UserId
                                          select menu.MenuID1).ToArray();

            rankUserViewModel.MenuDDLList = db.MenuIDs.Where(a => !(a.IsAdminMenu ?? false)).Select(i => new SelectListItem() { Text = i.MenuDetails, Value = i.MenuID1, Selected = rankUserViewModel.MenuList.Contains(i.MenuID1) }).AsEnumerable();
            rankUserViewModel.UserRoleDDLList = db.UserRoles.Select(i => new SelectListItem() { Text = i.UserRoleDetails, Value = i.UserRole1 }).AsEnumerable();            
            rankUserViewModel.UserWorkDDLList = db.UserWorks.Select(i => new SelectListItem() { Text = i.UserWorkDetails, Value = i.UserWork1 }).AsEnumerable();
            rankUserViewModel.DeptDDLList = db.Depts.Select(i => new SelectListItem() { Text = i.DeptName, Value = i.DeptID }).AsEnumerable();

            return PartialView("EditUserPartial", rankUserViewModel);

        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateUserDetail(RankUserViewModel rankUserViewModel, string[] MenuList)
        {
            bool Status = false;
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();
            RankUser rankUser = db.RankUsers.Where(a => a.UserID == rankUserViewModel.RankUser.UserID).FirstOrDefault();

            if (rankUser != null)
            {
                rankUser.DeptID = rankUserViewModel.RankUser.DeptID;
                rankUser.UserDisabledOn = Convert.ToString(rankUserViewModel.RankUser.UserValid) == "N" ? DateTime.Now : (DateTime?)null;
                rankUser.UserEmail = rankUserViewModel.RankUser.UserEmail;
                rankUser.UserEmpNo = rankUserViewModel.RankUser.UserEmpNo;
                rankUser.UserMob = rankUserViewModel.RankUser.UserMob;
                rankUser.UserName = rankUserViewModel.RankUser.UserName;
                rankUser.UserRole = rankUserViewModel.RankUser.UserRole;
                rankUser.UserValid = Convert.ToChar(rankUserViewModel.RankUser.UserValid ?? null);
                rankUser.UserWork = rankUserViewModel.RankUser.UserWork;

                db.Connection.Open();
                using (db.Transaction = db.Connection.BeginTransaction())
                {
                    try
                    {                      

                        IEnumerable<UserMenu> userMenu = db.UserMenus.Where(a => a.UserID == rankUserViewModel.RankUser.UserID).ToList();
                        if (userMenu != null)
                        {
                            var sa = userMenu.Where(a => !MenuList.Contains(a.MenuID)).ToList();
                            if (sa.Any())
                            {
                                db.UserMenus.DeleteAllOnSubmit(sa);
                            }
                        }

                        List<UserMenu> userMenuList = new List<UserMenu>();
                        foreach (string item in MenuList)
                        {
                            var sa = userMenu.Where(a => a.MenuID == item).FirstOrDefault();
                            if (sa == null)
                            {
                                UserMenu menu = new UserMenu();
                                menu.MenuID = item;
                                menu.UserID = rankUserViewModel.RankUser.UserID;
                                userMenuList.Add(menu);
                            }
                        }

                        if (userMenuList.Any()) {
                            db.UserMenus.InsertAllOnSubmit(userMenuList);
                        }

                        db.SubmitChanges();
                        db.Transaction.Commit();
                        Status = true;
                        ViewBag.Message = "User Updated Successfully.";
                        ViewBag.Status = true;

                        try
                        {
                            if (rankUserViewModel.RankUser.UserValid == "Y")
                            {
                                string body = "Dear " + rankUserViewModel.RankUser.UserName + ",<br /> You have been authorised by admin now. You can access the system by logging in. <br /><br /> Admin <br /> IRD SRIC";

                                FormServices formServices = new FormServices();
                                body = body.Replace("\r\n", "<br />");
                                string subject = "User Authorised by Admin, IRD-SRIC, IITR";
                                formServices.SendEmail(rankUserViewModel.RankUser.UserEmail, "", subject, body);
                            }
                        }
                        catch (Exception ex) { }
                    }
                    catch (Exception ex)
                    {
                        db.Transaction.Rollback();
                        ViewBag.Message = "Failed To Updated User. Error: " + ex.Message;
                        ViewBag.Status = false;
                    }
                }
            }

            return Json(new { success = Status });
        }

        public ActionResult ReportsForm(string DataCaptYM)
        {
            FormsViewModel vm = new FormsViewModel();
            return View(vm);
        }

        public JsonResult GenerateReport(ReportRequestData model)
        {
            var dirPath = System.Web.Configuration.WebConfigurationManager.AppSettings["ReportPath"].ToString();
            ReportsViewModel vm = new ReportsViewModel();
            var data = vm.GenerateReport(model, dirPath);
            return Json(data);
        }

        [HttpPost]
        public ActionResult DownloadFile(string fileName)
        {
            string fullPath = Path.Combine(System.Web.Configuration.WebConfigurationManager.AppSettings["ReportPath"].ToString(), fileName);
            if (System.IO.File.Exists(fullPath))
            {
                if (fileName.ToLower().EndsWith(".xlsx"))
                {
                    return File(fullPath, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);

                }
                else if (fileName.ToLower().EndsWith(".csv"))
                {
                    return File(fullPath, "application/csv", fileName);
                }
            }
            return HttpNotFound();
        }
    }
}
