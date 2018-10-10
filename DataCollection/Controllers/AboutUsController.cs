using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DataCollection.Controllers
{
    public class AboutUsController : Controller
    {
        //
        // GET: /AboutUs/
        [HttpGet]
        [AllowAnonymous]
        public ActionResult Index()
        {
            return View("AboutUs");
        }
	}
}