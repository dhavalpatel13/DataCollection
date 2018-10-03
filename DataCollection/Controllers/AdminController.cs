using DataCollection.FormService;
using DataCollection.Models;
using System;
using System.Collections.Generic;
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
            IEnumerable<DataCollection.Models.RankUser> RankUser = db.RankUsers.Where(a => (a.DeptID.ToLower().Trim() != "admin" || a.DeptID == null)).ToList();
            return View(RankUser);
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

            rankUserViewModel.MenuDDLList = db.MenuIDs.Select(i => new SelectListItem() { Text = i.MenuDetails, Value = i.MenuID1, Selected = rankUserViewModel.MenuList.Contains(i.MenuID1) }).AsEnumerable();
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

                        UserMenu userMenu = db.UserMenus.Where(a => a.UserID == rankUserViewModel.RankUser.UserID).FirstOrDefault();
                        if (userMenu != null)
                        {
                            db.UserMenus.DeleteOnSubmit(userMenu);                            
                        }

                        List<UserMenu> userMenuList = new List<UserMenu>();
                        foreach (string item in MenuList)
                        {
                            UserMenu menu = new UserMenu();
                            menu.MenuID = item;
                            menu.UserID = rankUserViewModel.RankUser.UserID;
                            userMenuList.Add(menu);
                        }

                        db.UserMenus.InsertAllOnSubmit(userMenuList);

                        db.SubmitChanges();
                        db.Transaction.Commit();
                        Status = true;
                        ViewBag.Message = "User Updated Successfully.";
                        ViewBag.Status = true;
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
    }
}
