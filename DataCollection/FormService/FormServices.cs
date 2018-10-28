using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Configuration;

namespace DataCollection.FormService
{
    public class FormServices
    {
        //public void SendEmail(string FromEmailAddress, string FromName, string ToAddress, string Subject, string MailBody, string CcAddress = "")
        public bool SendEmail(string ToAddress, string CcAddress, string Subject, string MailBody)
        {
            bool isEmailSucc = true;
            string ServerName;
            int PortNumber;
            string UserName;
            String Password;
            bool ssltype;
            // for IITR Email Server
            // Initialize Values
            //ServerName = "103.37.200.156";  // for Public IP
            ServerName = WebConfigurationManager.AppSettings["ServerName"];    // for Local IP
            PortNumber = Convert.ToInt32(WebConfigurationManager.AppSettings["PortNumber"]);
            UserName = WebConfigurationManager.AppSettings["UserName"];
            Password = WebConfigurationManager.AppSettings["Password"];
            ssltype = false;
            string FromEmailAddress = WebConfigurationManager.AppSettings["FromEmailAddress"];
            string FromName = WebConfigurationManager.AppSettings["FromName"];

            SmtpClient client = new SmtpClient();
            client.Host = ServerName;
            client.Port = PortNumber;
            client.EnableSsl = ssltype;

            NetworkCredential credential = new NetworkCredential(UserName, Password);
            client.Credentials = credential;

            //Step 3- Configure From
            MailAddress FromAddress = new MailAddress(FromEmailAddress, FromName);

            MailBody = MailBody.Replace("\r\n", "<br />");

            //Step 4 - Create Message to be sent
            MailMessage message = new MailMessage();
            message.From = FromAddress;
            message.To.Add(ToAddress);
            if (!string.IsNullOrWhiteSpace(CcAddress)) message.CC.Add(CcAddress);
            message.Bcc.Add("sric@iitr.ac.in");
            message.Subject = Subject;
            message.IsBodyHtml = true;
            message.Body = MailBody;

            try
            {
                //Step 5 - Send Email
                client.Send(message);
            }
            catch
            {
                isEmailSucc = false;
            }

            return isEmailSucc;
        }
    }
}