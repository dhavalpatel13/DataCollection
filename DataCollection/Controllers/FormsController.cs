using DataAccess.Entity;
using DataAccess.Repository;
using DataCollection.ManageSession;
using DataCollection.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DataCollection.FormService;
using Newtonsoft.Json.Linq;
using DataCollection.Security;
using DataAccess.Enum;

namespace DataCollection.Controllers
{
    //Form Controller having all forms methods 
    [Authorize]
    public class FormsController : Controller
    {
        //
        // GET: /Forms/
        public ActionResult Index()
        {
            return View();
        }

        #region Common Methods
        public ActionResult OnDAtaCaptYMChange(int DataCaptYM, string Menu, string DeptId)
        {
            FormsViewModel dOAA1ViewModel = new FormsViewModel();
            SessionManager.DataCaptYR = DataCaptYM;
            SessionManager.DeptID = DeptId;
            dOAA1ViewModel.GetDOAA1Data(DataCaptYM, Menu);
            string MenuPartial = FormCommonMethods.GetMenuPartial(Menu);
            object DataObject = FormCommonMethods.GetDynamicViewModel(Menu, dOAA1ViewModel);
            return PartialView(MenuPartial, DataObject);
        }

        [HttpPost]
        public ActionResult SaveUpdateFormData(CommonSaveUpdateProp data)
        {
            FormsViewModel formsViewModel = new FormsViewModel();
            object objectData = data.formData;
            string action = data.action;
            string menu = data.menu;
            bool IsSuccess = formsViewModel.SaveUpdateFormData(objectData, action, menu);
            TempData["isSaveSuccessfully"] = IsSuccess;
            return Json(new { status = IsSuccess }, JsonRequestBehavior.AllowGet);
        }
        #endregion Common Methods

        #region  DOAA Form      
        [CustomAuthorize(EntityName = Menu.DOAA)]
        public ActionResult DOAAForm(string DataCaptYM)
        {
            FormsViewModel dOAA1ViewModel = new FormsViewModel();
            int dataCaptYM = 0;
            int.TryParse(DataCaptYM, out dataCaptYM);
            dOAA1ViewModel.GetDOAA1Data(dataCaptYM, DataAccess.Enum.Menu.DOAA.ToString());
            ViewBag.Message = Convert.ToString(TempData["Message"]);
            ViewBag.Status = Convert.ToBoolean(TempData["Status"]);
            return View(dOAA1ViewModel);
        }
        #endregion DOAA Form

        #region  Lib Form
        [CustomAuthorize(EntityName = Menu.LIBFORM)]
        public ActionResult LIBForm(string DataCaptYM)
        {
            FormsViewModel dOAA1ViewModel = new FormsViewModel();
            int dataCaptYM = 0;
            int.TryParse(DataCaptYM, out dataCaptYM);
            dOAA1ViewModel.GetDOAA1Data(dataCaptYM, DataAccess.Enum.Menu.LIBFORM.ToString());
            ViewBag.Message = Convert.ToString(TempData["Message"]);
            ViewBag.Status = Convert.ToBoolean(TempData["Status"]);
            return View(dOAA1ViewModel);
        }
        #endregion Lib Form

        #region ADIR Form
        [CustomAuthorize(EntityName = Menu.ADIR)]
        public ActionResult ADIRForm(string DataCaptYM)
        {
            FormsViewModel dOAA1ViewModel = new FormsViewModel();
            int dataCaptYM = 0;
            int.TryParse(DataCaptYM, out dataCaptYM);
            dOAA1ViewModel.GetDOAA1Data(dataCaptYM, DataAccess.Enum.Menu.ADIR.ToString());
            ViewBag.Message = Convert.ToString(TempData["Message"]);
            ViewBag.Status = Convert.ToBoolean(TempData["Status"]);
            return View(dOAA1ViewModel);
        }
        #endregion ADIR Form

        #region DOSW Form
        [CustomAuthorize(EntityName = Menu.DOSW)]
        public ActionResult DOSWForm(string DataCaptYM)
        {
            FormsViewModel dOAA1ViewModel = new FormsViewModel();
            int dataCaptYM = 0;
            int.TryParse(DataCaptYM, out dataCaptYM);
            dOAA1ViewModel.GetDOAA1Data(dataCaptYM, DataAccess.Enum.Menu.DOSW.ToString());
            ViewBag.Message = Convert.ToString(TempData["Message"]);
            ViewBag.Status = Convert.ToBoolean(TempData["Status"]);
            return View(dOAA1ViewModel);
        }

        [CustomAuthorize(EntityName = Menu.DOFA)]
        public ActionResult DOFAForm(string DataCaptYM)
        {
            return View();
        }

        [CustomAuthorize(EntityName = Menu.SRICFA)]
        public ActionResult SRICFAForm(string DataCaptYM)
        {
            return View();
        }

        [CustomAuthorize(EntityName = Menu.SRIC)]
        public ActionResult SRICForm(string DataCaptYM)
        {
            return View();
        }

        public JsonResult GetDepartmentList()
        {
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();
            var DeptDDLList = db.Depts.Select(i => new { Text = i.DeptName, Value = i.DeptID }).AsEnumerable();
            return Json(DeptDDLList, JsonRequestBehavior.AllowGet);
        }
        #endregion DOSW Form
    }
}