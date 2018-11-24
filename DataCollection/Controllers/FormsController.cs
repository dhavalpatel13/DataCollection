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

        public ActionResult OnDofaDeptChange(int DataCaptYM, string EmpDept, string DeptId)
        {
            FormsViewModel viewModel = new FormsViewModel();
            SessionManager.DataCaptYR = DataCaptYM;
            SessionManager.DeptID = DeptId;
            viewModel.GetMultiDataByMenuID(DataCaptYM, "DOFA", EmpDept);
            return PartialView("DOFAFormPartial", viewModel.dofaViewModel);
        }

        [HttpPost]
        public ActionResult SaveUpdateFormData(CommonSaveUpdateProp data)
        {
            string msg = string.Empty;
            FormsViewModel formsViewModel = new FormsViewModel();
            object objectData = data.formData;
            string action = data.action;
            string menu = data.menu;
            string needModificationMSG = data.needModificationMSG;
            Tuple<bool, bool> IsSuccess = formsViewModel.SaveUpdateFormData(objectData, action, menu, needModificationMSG, out msg);
            TempData["isSaveSuccessfully"] = IsSuccess.Item1;
            TempData["isFailedToSentEmail"] = !IsSuccess.Item2;
            return Json(new { status = IsSuccess.Item1, msg = msg }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult SaveDOFAFormData(DofaRequestViewModel data)
        {
            string msg = string.Empty;
            FormsViewModel formsViewModel = new FormsViewModel();
            string action = data.action;
            string menu = data.menu;
            string needModificationMSG = data.needModificationMSG;
            Tuple<bool, bool> IsSuccess = formsViewModel.SaveUpdateFormData(data.formData, action, menu, needModificationMSG, out msg);
            TempData["isSaveSuccessfully"] = IsSuccess.Item1;
            TempData["isFailedToSentEmail"] = !IsSuccess.Item2;
            return Json(new { status = IsSuccess.Item1, msg = msg }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult SaveSricFAFormData(SricFaRequestViewModel data)
        {
            string msg = string.Empty;
            FormsViewModel formsViewModel = new FormsViewModel();
            string action = data.action;
            string menu = data.menu;
            string needModificationMSG = data.needModificationMSG;
            Tuple<bool, bool> IsSuccess = formsViewModel.SaveUpdateFormData(data.formData, action, menu, needModificationMSG, out msg);
            TempData["isSaveSuccessfully"] = IsSuccess.Item1;
            TempData["isFailedToSentEmail"] = !IsSuccess.Item2;
            return Json(new { status = IsSuccess.Item1, msg = msg }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult SaveSricDeptFormData(SricDeptRequestViewModel data)
        {
            string msg = string.Empty;
            FormsViewModel formsViewModel = new FormsViewModel();
            string action = data.action;
            string menu = data.menu;
            string needModificationMSG = data.needModificationMSG;
            Tuple<bool, bool> IsSuccess = formsViewModel.SaveUpdateFormData(data.formData, action, menu, needModificationMSG, out msg);
            TempData["isSaveSuccessfully"] = IsSuccess.Item1;
            TempData["isFailedToSentEmail"] = !IsSuccess.Item2;
            return Json(new { status = IsSuccess.Item1, msg = msg }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult SaveDofaPeerFormData(DofaPeerRequestViewModel data)
        {
            string msg = string.Empty;
            FormsViewModel formsViewModel = new FormsViewModel();
            string action = data.action;
            string menu = data.menu;
            string needModificationMSG = data.needModificationMSG;
            Tuple<bool, bool> IsSuccess = formsViewModel.SaveUpdateFormData(data.formData, action, menu, needModificationMSG, out msg);
            TempData["isSaveSuccessfully"] = IsSuccess.Item1;
            TempData["isFailedToSentEmail"] = !IsSuccess.Item2;            
            return Json(new { status = IsSuccess.Item1, msg = msg }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult SaveTPDEPTFormData(TPDeptRequestViewModel data)
        {
            string msg = string.Empty;
            FormsViewModel formsViewModel = new FormsViewModel();
            string action = data.action;
            string menu = data.menu;
            string needModificationMSG = data.needModificationMSG;
            Tuple<bool, bool> IsSuccess = formsViewModel.SaveUpdateFormData(data.formData, action, menu, needModificationMSG, out msg);
            TempData["isSaveSuccessfully"] = IsSuccess.Item1;
            TempData["isFailedToSentEmail"] = !IsSuccess.Item2;
            return Json(new { status = IsSuccess.Item1, msg = msg }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult SaveInfraFormData(InfraRequestViewModel data)
        {
            string msg = string.Empty;
            FormsViewModel formsViewModel = new FormsViewModel();
            string action = data.action;
            string menu = data.menu;
            string needModificationMSG = data.needModificationMSG;
            Tuple<bool, bool> IsSuccess = formsViewModel.SaveUpdateFormData(data.formData, action, menu, needModificationMSG, out msg);
            TempData["isSaveSuccessfully"] = IsSuccess.Item1;
            TempData["isFailedToSentEmail"] = !IsSuccess.Item2;
            return Json(new { status = IsSuccess.Item1, msg = msg }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult SaveDFNPFormData(DFNPRequestViewModel data)
        {
            string msg = string.Empty;
            FormsViewModel formsViewModel = new FormsViewModel();
            string action = data.action;
            string menu = data.menu;
            string needModificationMSG = data.needModificationMSG;
            Tuple<bool, bool> IsSuccess = formsViewModel.SaveUpdateFormData(data.formData, action, menu, needModificationMSG, out msg);
            TempData["isSaveSuccessfully"] = IsSuccess.Item1;
            TempData["isFailedToSentEmail"] = !IsSuccess.Item2;
            return Json(new { status = IsSuccess.Item1, msg = msg }, JsonRequestBehavior.AllowGet);
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
            FormsViewModel dofaViewModel = new FormsViewModel();
            int dataCaptYM = 0;
            int.TryParse(DataCaptYM, out dataCaptYM);
            dofaViewModel.GetMultiDataByMenuID(dataCaptYM, Menu.DOFA.ToString());
            ViewBag.Message = Convert.ToString(TempData["Message"]);
            ViewBag.Status = Convert.ToBoolean(TempData["Status"]);
            return View(dofaViewModel);
        }

        [CustomAuthorize(EntityName = Menu.SRICFA)]
        public ActionResult SRICFAForm(string DataCaptYM)
        {
            FormsViewModel viewModel = new FormsViewModel();
            int dataCaptYM = 0;
            int.TryParse(DataCaptYM, out dataCaptYM);
            viewModel.GetMultiDataByMenuID(dataCaptYM, Menu.SRICFA.ToString());
            ViewBag.Message = Convert.ToString(TempData["Message"]);
            ViewBag.Status = Convert.ToBoolean(TempData["Status"]);
            return View(viewModel);
        }

        [CustomAuthorize(EntityName = Menu.SRIC)]
        public ActionResult SRICForm(string DataCaptYM)
        {
            FormsViewModel viewModel = new FormsViewModel();
            int dataCaptYM = 0;
            int.TryParse(DataCaptYM, out dataCaptYM);
            viewModel.GetMultiDataByMenuID(dataCaptYM, Menu.SRIC.ToString());
            ViewBag.Message = Convert.ToString(TempData["Message"]);
            ViewBag.Status = Convert.ToBoolean(TempData["Status"]);
            return View(viewModel);
        }

        [CustomAuthorize(EntityName = Menu.DOFAPEER)]
        public ActionResult DOFAPEERForm(string DataCaptYM)
        {
            FormsViewModel dofaViewModel = new FormsViewModel();
            int dataCaptYM = 0;
            int.TryParse(DataCaptYM, out dataCaptYM);
            dofaViewModel.GetMultiDataByMenuID(dataCaptYM, Menu.DOFAPEER.ToString());
            ViewBag.Message = Convert.ToString(TempData["Message"]);
            ViewBag.Status = Convert.ToBoolean(TempData["Status"]);
            return View(dofaViewModel);
        }

        public JsonResult GetDepartmentList()
        {
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();
            var DeptDDLList = db.Depts.Select(i => new { Text = i.DeptName, Value = i.DeptID }).AsEnumerable();
            return Json(DeptDDLList, JsonRequestBehavior.AllowGet);
        }
        #endregion DOSW Form

        [HttpPost]
        public JsonResult DofaPeerAutoComplete(string EmpNo) //, string DataCaptYM
        {
            DataCollectionModelDataContext db = new DataCollectionModelDataContext();            
            //int dataCaptYM = 0;
            //int.TryParse(DataCaptYM, out dataCaptYM);

            var dofaInfos = (from dofa in db.dofaInfos
                             where
                             dofa.empNo.ToString().ToLower().Trim().Equals(EmpNo.ToLower().Trim())
                             //&& dofa.DataCaptYM == dataCaptYM 
                             && dofa.DeptID == SessionManager.DeptID 
                             && dofa.MenuID == DataAccess.Enum.Menu.DOFA.ToString()
                             select new
                             {
                                 empNo = dofa.empNo,
                                 empDEPT = dofa.empDEPT,
                                 empName = dofa.empName,
                                 dataCaptYM = dofa.DataCaptYM

                             }).FirstOrDefault();

            object dofaa = new object();
            if (dofaInfos != null)
            {
                dofaa = new { dataCaptYM = dofaInfos.dataCaptYM,  empNo = dofaInfos.empNo, empDEPT = dofaInfos.empDEPT, empName = dofaInfos.empName, isEmpFound= true };
            }
            else
            {
                dofaa = new { isEmpFound = false };
            }

            return Json(dofaa, JsonRequestBehavior.AllowGet);            
        }

        public ActionResult LoadEmpData(string EmpNo, string DataCaptYM, bool isFromSave)
        {
            SessionManager.DataCaptYR = Convert.ToInt32(DataCaptYM);
            FormsViewModel dOAA1ViewModel = new FormsViewModel();
            dOAA1ViewModel.GetDOAA1Data(Convert.ToInt32(DataCaptYM), Menu.DOFAPEER.ToString());            
            string MenuPartial = FormCommonMethods.GetMenuPartial(Menu.DOFAPEER.ToString());
            if (!string.IsNullOrEmpty(EmpNo))
            {
                dOAA1ViewModel.dofaPeerViewModel.DofaPeerData = dOAA1ViewModel.dofaPeerViewModel.DofaPeerData.Where(a => a.empNo.Equals(Convert.ToInt32(EmpNo))).ToList();
                dOAA1ViewModel.dofaPeerViewModel.EmpNo = Convert.ToInt32(EmpNo);
            }
            
            if (dOAA1ViewModel.dofaPeerViewModel.DofaPeerData.Count() <= 0)
            {
                DofaPeer dofaPeer = new DofaPeer();
                dofaPeer.empNo = Convert.ToInt32(EmpNo);
                dofaPeer.PeerNo = 1;
                dOAA1ViewModel.dofaPeerViewModel.DofaPeerData.Add(dofaPeer);
            }
            object DataObject = FormCommonMethods.GetDynamicViewModel(Menu.DOFAPEER.ToString(), dOAA1ViewModel);
            if(isFromSave)
            {
                TempData["isSaveSuccessfully"] = true;
                TempData["isFailedToSentEmail"] = false;
            }
            return PartialView(MenuPartial, DataObject);
        }

        [CustomAuthorize(EntityName = Menu.TPDEPT)]
        public ActionResult TPDEPTForm(string DataCaptYM)
        {
            FormsViewModel viewModel = new FormsViewModel();
            int dataCaptYM = 0;
            int.TryParse(DataCaptYM, out dataCaptYM);
            viewModel.GetMultiDataByMenuID(dataCaptYM, Menu.TPDEPT.ToString());
            ViewBag.Message = Convert.ToString(TempData["Message"]);
            ViewBag.Status = Convert.ToBoolean(TempData["Status"]);
            return View(viewModel);
        }

        [CustomAuthorize(EntityName = Menu.INFRA)]
        public ActionResult INFRAForm(string DataCaptYM)
        {
            FormsViewModel viewModel = new FormsViewModel();
            int dataCaptYM = 0;
            int.TryParse(DataCaptYM, out dataCaptYM);
            viewModel.GetMultiDataByMenuID(dataCaptYM, Menu.INFRA.ToString());
            ViewBag.Message = Convert.ToString(TempData["Message"]);
            ViewBag.Status = Convert.ToBoolean(TempData["Status"]);
            return View(viewModel);
        }

        [CustomAuthorize(EntityName = Menu.DFNP)]
        public ActionResult DFNPForm(string DataCaptYM)
        {
            FormsViewModel viewModel = new FormsViewModel();
            int dataCaptYM = 0;
            int.TryParse(DataCaptYM, out dataCaptYM);
            viewModel.GetMultiDataByMenuID(dataCaptYM, Menu.DFNP.ToString());
            ViewBag.Message = Convert.ToString(TempData["Message"]);
            ViewBag.Status = Convert.ToBoolean(TempData["Status"]);
            return View(viewModel);
        }
    }
}