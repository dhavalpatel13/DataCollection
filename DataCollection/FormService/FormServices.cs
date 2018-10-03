using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace DataCollection.FormService
{
    public class FormServices
    {
        public void SendEmail(string FromEmailAddress, string FromName, string ToAddress, string Subject, string MailBody)
        {
            string ServerName;
            int PortNumber;
            string UserName;
            String Password;
            bool ssltype;
            // for IITR Email Server
            // Initialize Values
            ServerName = "103.37.200.156";  //ServerName = "192.168.180.11";  Local IP
            PortNumber = 587;
            UserName = "sric";
            Password = "xxxxx";
            ssltype = false;
            SmtpClient client = new SmtpClient();
            client.Host = ServerName;
            client.Port = PortNumber;
            client.EnableSsl = ssltype;

            NetworkCredential credential = new NetworkCredential(UserName, Password);
            client.Credentials = credential;

            //Step 3- Configure From
            MailAddress FromAddress = new MailAddress(FromEmailAddress, FromName);

            //Step 4 - Create Message to be sent
            MailMessage message = new MailMessage();
            message.From = FromAddress;
            message.To.Add(ToAddress);
            message.Subject = Subject;
            message.IsBodyHtml = true;
            message.Body = MailBody;

            //Step 5 - Send Email
            client.Send(message);

        }
    }
}