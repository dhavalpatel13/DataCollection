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
using DataAccess.Enum;
using CaptchaMvc.HtmlHelpers;

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

            RegisterViewModel registerViewModel = new RegisterViewModel();
            registerViewModel = LoadRegister();

            return View(registerViewModel);
        }
        //Registration POST action 
        [HttpPost]
        [ValidateAntiForgeryToken]        
        public ActionResult Registration(RegisterViewModel user)
        {
            bool Status = true;
            string message = "";

            // Model Validation 
            if (!this.IsCaptchaValid("Captcha is not valid"))
            {
                Status = false;
                message = "Captcha is not valid";
            }

            if (Status && ModelState.IsValid)
            {
                DataAccess.Entity.RankUser rankUser = new DataAccess.Entity.RankUser();

                #region  Password Hashing
                rankUser.UserPassword = FormCommonMethods.Encryptdata(user.UserPassword);
                #endregion
                rankUser.UserID = user.UserId;
                rankUser.UserEmail = user.UserEmail;
                rankUser.UserEmpNo = user.UserEmpNo;
                rankUser.UserName = user.UserName;
                rankUser.UserMob = user.MobileNo;
                rankUser.DeptID = user.DeptID;
                rankUser.UserWork = user.UserWork;
                rankUser.UserRemarks = user.UserRemarks;
                rankUser.UserValid = "N";
                rankUser.UserRole = UserRoles.User.ToString();
                rankUser.IsEmailVerified = false;
                rankUser.ActivationCode = Guid.NewGuid();

                #region //Email is already Exist
                int isExist = IsEmailExist(rankUser);
                if (isExist == 1)
                {
                    ModelState.AddModelError("EmailExist", "Email already exist");
                    message = "Email already exist";                    
                    Status = false;
                    //return View(user);
                }
                else if (isExist == 2)
                {
                    ModelState.AddModelError("EmpNo Exist", "EmpNo already exist");
                    message = "EmpNo already exist";                    
                    Status = false;                    
                    //return View(user);
                }
                else if (isExist == 3)
                {
                    ModelState.AddModelError("UserId Exist", "UserId is taken");
                    message = "UserId is taken";                    
                    Status = false;
                    //return View(user);
                }
                else if (isExist == 4)
                {
                    ModelState.AddModelError("Mobile Exist", "Mobile already exist");
                    message = "Mobile already exist";                    
                    Status = false;
                    //return View(user);
                }

                #endregion

                if (Status)
                {
                    #region Save to Database
                    RankUserRepository rankUserRepository = new RankUserRepository();
                    Status = rankUserRepository.AddRankUser(rankUser);
                    if (Status)
                    {
                        //Send Email to User
                        SendVerificationLinkEmail(user.UserEmail, rankUser.ActivationCode.ToString());                        

                        user = new RegisterViewModel();
                        user = LoadRegister();
                        ModelState.Clear();
                        message = "Your account has been registered. An Email has been sent to confirm user registration." +
                                  "Kindly check & click on the link given in Email to register your details.";
                    }
                    else
                    {
                        message = "Your registration failed.";
                    }
                    #endregion
                }
            }
            else
            {
                if (string.IsNullOrWhiteSpace(message))
                    message = "Invalid Request";
            }

            ViewBag.Message = message;
            ViewBag.Status = Status;
            if (!Status)
            {
                RegisterViewModel RegisterVM = new RegisterViewModel();
                RegisterVM = LoadRegister();
                user.UserWorkDDLList = RegisterVM.UserWorkDDLList;
                user.DeptDDLList = RegisterVM.DeptDDLList;
            }
            return View(user);
        }

        public RegisterViewModel LoadRegister()
        {
            RegisterViewModel registerViewModel = new RegisterViewModel();
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();

            registerViewModel.UserWorkDDLList = db.UserWorks.Where(a => a.UserWork1.ToLower().Trim() != "admin").Select(i => new SelectListItem() { Text = i.UserWorkDetails, Value = i.UserWork1 }).AsEnumerable();
            registerViewModel.DeptDDLList = db.Depts.Select(i => new SelectListItem() { Text = i.DeptName, Value = i.DeptID }).AsEnumerable();

            return registerViewModel;
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
            ViewBag.Message = Convert.ToString(TempData["Message"]);
            ViewBag.Status = Convert.ToBoolean(TempData["Status"]);
            return View();
        }

        //Login POST
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginViewModel loginViewModel, string ReturnUrl = "")
        {
            string message = "";
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
                                ViewBag.Status = false;
                            }
                            else if (Convert.ToString(RankUser.UserValid).ToUpper().Trim() == "N" && (!RankUser.IsEmailVerified ?? !false))
                            {
                                ViewBag.Message = "Email link sent. kindly click on the link to complete registration";
                                ViewBag.Status = false;
                            }
                            else if (Convert.ToString(RankUser.UserValid).ToUpper().Trim() == "N" && (RankUser.IsEmailVerified ?? false))
                            {
                                string href = Url.Action("Index", "Contact", null);
                                var link = Request.Url.AbsoluteUri.Replace(Request.Url.PathAndQuery, href);
                                 ViewBag.Message = "Activation pending from Admin , IRD-SRIC. Kindly wait for some more time or Contact through <a href='" + link + "'> Contact Us </a>";
                                 ViewBag.Status = false;
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
                        ViewBag.Status = true;
                        return Redirect(SessionManager.MenuList.FirstOrDefault().MenuUrl);
                    }
                    else
                    {
                        message = "Invalid credential provided";
                        ViewBag.Status = false;
                    }
                }
                else
                {
                    message = "Invalid credential provided";
                    ViewBag.Status = false;
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

        [NonAction]
        public void SendVerificationLinkEmail(string emailID, string activationCode, string emailFor = "VerifyAccount")
        {
            var verifyUrl = "/User/" + emailFor + "/" + activationCode;
            var link = Request.Url.AbsoluteUri.Replace(Request.Url.PathAndQuery, verifyUrl);

            string body = string.Empty, subject = string.Empty;
            if (emailFor == "VerifyAccount")
            {      
               subject = "Your account is successfully created! Verify Account";
               body = "Dear " + SessionManager.UserName + ",<br/><br/>We are excited to tell you that your account is" +
                    " successfully created. Please click on the below link to verify your account" +
                    " <br/><br/><a href='" + link + "'>" + link + "</a> " + "<br/><br/> From:<br/> Admin, IRD-SRIC, IITR";
            }
            else if (emailFor == "ResetPassword")
            {
                subject = "Reset Password";
                body = "Dear " + SessionManager.UserName + ", <br/>br/>We got request for reset your account password. Please click on the below link to reset your password" +
                    "<br/><br/><a href=" + link + ">Reset Password link</a>" + "<br/><br/> From:<br/> Admin, IRD-SRIC, IITR"; 
            }


            FormServices formServices = new FormServices();
            formServices.SendEmail(emailID, "", subject, body);
        }

        [HttpGet]
        [AllowAnonymous]
        public ActionResult VerifyAccount(string id)
        {
            bool Status = false, IsLoginLinkVisible = false;
            
            if (string.IsNullOrEmpty(id))
            {
                return RedirectToAction("Login", "User", null);
            }

            using (DataCollectionModelDataContext db = new DataCollectionModelDataContext())
            {
                Guid guidResult;
                bool isValid = Guid.TryParse(id, out guidResult);
                if (!isValid)
                {
                    return RedirectToAction("Login", "User", null);
                }

                var v = db.RankUsers.Where(a => a.ActivationCode == new Guid(id)).FirstOrDefault();
                if (v != null)
                {
                    if (!v.IsEmailVerified ?? false)
                    {
                        v.IsEmailVerified = true;
                        db.SubmitChanges();
                        Status = true;
                        ViewBag.Message = "Your registered details has been verified successfully. Your account will be activated after authorisation by administrator(IRD-SRIC).";                        
                    }
                    else if (v.UserValid.ToString().ToUpper() == "N" && v.UserDisabledOn == null)
                    {
                        Status = true;
                        ViewBag.Message = "Your registered details have been already verified. Please wait for authorisation by administrator(IRD-SRIC)";                        
                    }
                    else if (v.UserValid.ToString().ToUpper() == "Y")
                    {
                        ViewBag.Message = "Your registered details have been already verified. Please wait for authorisation by administrator(IRD-SRIC)";
                        IsLoginLinkVisible = true;
                    }
                }
                else
                {
                    ViewBag.Message = "Invalid Request";
                }
            }
            ViewBag.Status = Status;
            ViewBag.IsLoginLinkVisible = IsLoginLinkVisible;
            return View();
        }

        [HttpGet]
        [AllowAnonymous]
        public ActionResult ForgotPassword()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ForgotPassword(string EmailID)
        {
            //Verify Email ID
            //Generate Reset password link 
            //Send Email 
            string message = "";
            bool status = false;

            using (DataCollectionModelDataContext db = new DataCollectionModelDataContext())
            {
                var account = db.RankUsers.Where(a => a.UserEmail == EmailID).FirstOrDefault();
                if (account != null)
                {
                    //Send email for reset password
                    string resetCode = Guid.NewGuid().ToString();
                    SendVerificationLinkEmail(account.UserEmail, resetCode, "ResetPassword");
                    account.ResetPasswordCode = resetCode;
                    //This line I have added here to avoid confirm password not match issue , as we had added a confirm password property 
                    //in our model class in part 1
                    
                    db.SubmitChanges();
                    ModelState.Clear();
                    message = "Reset password link has been sent to your email id.";
                    status = true;
                }
                else
                {
                    message = "Account not found";
                }
            }
            ViewBag.Message = message;
            ViewBag.Status = status;
            return View();
        }

        public ActionResult ResetPassword(string id)
        {
            //Verify the reset password link
            //Find account associated with this link
            //redirect to reset password page
            if (string.IsNullOrWhiteSpace(id))
            {
                return HttpNotFound();
            }

            using (DataCollectionModelDataContext db = new DataCollectionModelDataContext())
            {
                var user = db.RankUsers.Where(a => a.ResetPasswordCode == id).FirstOrDefault();
                if (user != null)
                {
                    ResetPasswordModel model = new ResetPasswordModel();
                    model.ResetCode = id;
                    return View(model);
                }
                else
                {
                    return RedirectToAction("Login", "User", null);
                }
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ResetPassword(ResetPasswordModel model)
        {
            var message = "";
            if (ModelState.IsValid)
            {
                using (DataCollectionModelDataContext db = new DataCollectionModelDataContext())
                {
                    var user = db.RankUsers.Where(a => a.ResetPasswordCode == model.ResetCode).FirstOrDefault();
                    if (user != null)
                    {                        
                        user.UserPassword = FormCommonMethods.Encryptdata(model.NewPassword);
                        user.ResetPasswordCode = "";
                        db.SubmitChanges();
                        message = "New password updated successfully";
                        //ViewBag.Status = true;
                        //ViewBag.Message = message;
                        TempData["Message"] = message;
                        TempData["Status"] = true;
                        return RedirectToAction("Login", "User", null);
                    }
                }
            }
            else
            {
                message = "invalid details. Contact System Administrator.";
                ViewBag.Status = false;
            }
            ViewBag.Message = message;
            return View(model);
        }

        [Authorize]
        public ActionResult ChangePassword()
        {
            if (!User.Identity.IsAuthenticated && !SessionManager.IsUserLogin)
            {
                return RedirectToAction("Login", "User", null);
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ChangePassword(ManageUserViewModel model)
        {
            var message = "";
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();
            var RankUser = db.RankUsers.Where(a => a.UserID == SessionManager.UserId.Trim()).FirstOrDefault();
            if (RankUser != null)
            {
                if (string.Compare(FormCommonMethods.Encryptdata(model.OldPassword), RankUser.UserPassword) == 0)
                {
                    RankUser.UserPassword = FormCommonMethods.Encryptdata(model.NewPassword);                    
                    db.SubmitChanges();
                    message = "Password updated successfully";
                    //ViewBag.Status = true;
                    //ViewBag.Message = message;
                    TempData["Message"] = message;
                    TempData["Status"] = true;
                    return Redirect(SessionManager.MenuList.FirstOrDefault().MenuUrl);
                }
                else
                {
                    message = "Invalid Old Password";
                    ViewBag.Status = false;
                }
            }
            ViewBag.Message = message;
            return View(model);
        }
    }
}