using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net.Mail;
using System.Net;
using System.Web.Security;
using DataAccess.Entity;
using DataCollection.FormService;
using DataAccess.Repository;
using DataCollection.Models;
using DataCollection.ManageSession;

namespace DataCollection.Controllers
{
    public class UserController : Controller
    {
        //Registration Action
        [HttpGet]
        [AllowAnonymous]
        public ActionResult Registration()
        {
            if (User.Identity.IsAuthenticated && SessionManager.IsUserLogin && (SessionManager.MenuList != null && SessionManager.MenuList.Count() > 0))
            {
                return Redirect(SessionManager.MenuList.FirstOrDefault().MenuUrl);
            }
            return View();
        }
        //Registration POST action 
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Registration(RegisterViewModel user)
        {
            bool Status = false;
            string message = "";
            DataAccess.Entity.RankUser rankUser = new DataAccess.Entity.RankUser();
            //
            // Model Validation 
            if (ModelState.IsValid)
            {
                #region  Password Hashing
                rankUser.UserPassword = FormCommonMethods.Encryptdata(user.UserPassword);
                #endregion
                rankUser.UserID = user.UserId;
                rankUser.UserEmail = user.UserEmail;
                rankUser.UserEmpNo = user.UserEmpNo;
                rankUser.UserName = user.UserName;
                rankUser.UserMob = user.MobileNo;                
                rankUser.UserValid = "N";

                #region //Email is already Exist
                int isExist = IsEmailExist(rankUser);
                if (isExist == 1)
                {
                    ModelState.AddModelError("EmailExist", "Email already exist");
                    ViewBag.Message = "Email already exist";
                    ViewBag.Status = false;
                    return View(user);
                }
                else if(isExist == 2)
                {
                    ModelState.AddModelError("EmpNo Exist", "EmpNo already exist");
                    ViewBag.Message = "EmpNo already exist";
                    ViewBag.Status = false;
                    return View(user);
                }
                else if (isExist == 3)
                {
                    ModelState.AddModelError("UserId Exist", "UserId is taken");
                    ViewBag.Message = "UserId is taken";
                    ViewBag.Status = false;
                    return View(user);
                }
                else if (isExist == 4)
                {
                    ModelState.AddModelError("Mobile Exist", "Mobile already exist");
                    ViewBag.Message = "Mobile already exist";
                    ViewBag.Status = false;
                    return View(user);
                }

                #endregion

                #region Save to Database
                RankUserRepository rankUserRepository = new RankUserRepository();
                Status = rankUserRepository.AddRankUser(rankUser);
                if (Status)
                {
                    user = new RegisterViewModel();
                    ModelState.Clear();
                    message = "You have successfully registered.";
                }
                else
                {
                    message = "Your registration failed.";
                }
                #endregion
            }
            else
            {
                message = "Invalid Request";
            }

            ViewBag.Message = message;
            ViewBag.Status = Status;
            return View(user);
        }

        //Login 
        [HttpGet]
        [AllowAnonymous]
        public ActionResult Login()
        {
            if (User.Identity.IsAuthenticated && SessionManager.IsUserLogin && (SessionManager.MenuList != null && SessionManager.MenuList.Count() > 0))
            {
                return Redirect(SessionManager.MenuList.FirstOrDefault().MenuUrl);
            }
            return View();
        }

        //Login POST
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginViewModel loginViewModel, string ReturnUrl = "")
        {
            string message = "";
            //RankUserViewModel rankUserViewModel = new RankUserViewModel();
            //rankUserViewModel.GetLoginUser(loginViewModel.UserName, FormCommonMethods.Encryptdata(loginViewModel.Password));
            using (DataCollectionModelDataContext db = new DataCollectionModelDataContext())
            {
                DataCollection.Models.RankUser RankUser = db.RankUsers.Where(a => a.UserID == loginViewModel.UserId.Trim()).FirstOrDefault();
                if (RankUser != null)
                {
                    if (string.Compare(FormCommonMethods.Encryptdata(loginViewModel.Password), RankUser.UserPassword) == 0)
                    {
                        if (string.IsNullOrWhiteSpace(Convert.ToString(RankUser.UserValid)) || Convert.ToString(RankUser.UserValid).ToUpper().Trim() == "N" || (string.IsNullOrWhiteSpace(RankUser.DeptID) || string.IsNullOrWhiteSpace(RankUser.UserRole) || string.IsNullOrWhiteSpace(RankUser.UserWork)))
                        {
                            if (Convert.ToString(RankUser.UserValid).ToUpper().Trim() == "N" && RankUser.UserDisabledOn != null)
                            {
                                ViewBag.Message = "Your account is blocked. Please Contact Admin";
                            }
                            else
                            {
                                ViewBag.Message = "Your registration is under process";
                            }
                            return View();
                        }

                        int timeout = loginViewModel.RememberMe ? 525600 : 20; // 525600 min = 1 year                        
                        FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1, RankUser.UserName, DateTime.Now, DateTime.Now.AddMinutes(2880), loginViewModel.RememberMe, RankUser.UserRole, FormsAuthentication.FormsCookiePath);
                        string encrypted = FormsAuthentication.Encrypt(ticket);
                        var cookie = new HttpCookie(FormsAuthentication.FormsCookieName, encrypted);
                        cookie.Expires = DateTime.Now.AddMinutes(timeout);
                        cookie.HttpOnly = true;
                        Response.Cookies.Add(cookie);
                        SetUserSession(RankUser);

                        return Redirect(SessionManager.MenuList.FirstOrDefault().MenuUrl);
                    }
                    else
                    {
                        message = "Invalid credential provided";
                    }
                }
                else
                {
                    message = "Invalid credential provided";
                }
            }

            ViewBag.Message = message;
            return View();
        }

        //Logout
        [Authorize]       
        public ActionResult Logout()
        {
            Session.Abandon();
            FormsAuthentication.SignOut();
            return RedirectToAction("Login", "User");
        }

        [NonAction]
        public int IsEmailExist(DataAccess.Entity.RankUser rankUser)
        {
            RankUserRepository rankUserRepository = new RankUserRepository();            
            return rankUserRepository.CheckUserExistByEmailEmpNo(rankUser);      
        }

        public void SetUserSession(DataCollection.Models.RankUser RankUser)
        {
            SessionManager.IsUserLogin = true;
            SessionManager.UserName = RankUser.UserName;
            SessionManager.UserWork = RankUser.UserWork;
            SessionManager.UserRole = RankUser.UserRole;
            SessionManager.DeptID = RankUser.DeptID;
            SessionManager.UserId = RankUser.UserID;
            SessionManager.MenuList = FormCommonMethods.GetCurrentUserMenu(RankUser.UserID, RankUser.UserRole);
        }
    }
}