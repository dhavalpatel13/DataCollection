using DataCollection.ManageSession;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DataCollection.Security
{
    public class CustomAuthorize : AuthorizeAttribute
    {

        public DataAccess.Enum.Menu EntityName { set; get; }

        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            //filterContext.Result = new HttpUnauthorizedResult(); // Try this but i'm not sure
            filterContext.Result = new RedirectResult("~/Error/Unauthorized");
        }

        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            if (this.AuthorizeCore(filterContext.HttpContext))
            {
                base.OnAuthorization(filterContext);

                if (EntityName != null && HttpContext.Current.User.Identity.IsAuthenticated && SessionManager.IsUserLogin && (SessionManager.MenuList != null && SessionManager.MenuList.Count() > 0))
                {
                    if (SessionManager.MenuList.Where(a => a.MenuID1.ToLower().Equals(EntityName.ToString().ToLower())).FirstOrDefault() == null)
                    {
                        filterContext.Result = new RedirectResult("~/Error/Unauthorized");
                    }
                }
            }
            else
            {
                this.HandleUnauthorizedRequest(filterContext);
            }
        }

    }
}