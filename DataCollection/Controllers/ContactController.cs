using DataCollection.FormService;
using DataCollection.ManageSession;
using DataCollection.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace DataCollection.Controllers
{
    public class ContactController : Controller
    {
        //
        // GET: /Contact/
        public ActionResult Index()
        {
            return View("Contact");
        }

        public ActionResult SendEnquiry(ContactUsViewModels ContactUsViewModels)
        {
            string body = ("Message Body" +
                          "<br/> Name:" + ContactUsViewModels.Name +
                          "<br/> EmpNo:" + ContactUsViewModels.EmpNo +
                          "<br/> Mobile No:" + ContactUsViewModels.MobileNo +
                          "<br/> Email:" + ContactUsViewModels.Email);

            FormServices formServices = new FormServices();
            formServices.SendEmail("noReply@email.com", "scir", "sric@iitr.ac.in", "Equiry", WebUtility.HtmlEncode(body), ContactUsViewModels.Email);
            ViewBag.Status = true;
            ViewBag.Message = "Email has been sent successfully. We will contact you soon.";
            ModelState.Clear();
            return View("Contact", new ContactUsViewModels());
        }
	}
}