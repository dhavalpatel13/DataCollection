using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using ClosedXML.Excel;
using DataAccess.Repository;

namespace DataCollection.Models
{
    public class ReportsViewModel
    {
        public static string DataTableToCSV(DataTable datatable, char seperator)
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < datatable.Columns.Count; i++)
            {
                sb.Append(datatable.Columns[i]);
                if (i < datatable.Columns.Count - 1)
                    sb.Append(seperator);
            }
            sb.AppendLine();
            foreach (DataRow dr in datatable.Rows)
            {
                for (int i = 0; i < datatable.Columns.Count; i++)
                {
                    sb.Append(dr[i].ToString());

                    if (i < datatable.Columns.Count - 1)
                        sb.Append(seperator);
                }
                sb.AppendLine();
            }
            return sb.ToString();
        }

        public static void GenerateExcelFromDataTable(string sheetName,DataTable dt, string filename, int fileType)
        {
            switch (fileType)
            {
                case 1:
                    {
                        using (XLWorkbook wb = new XLWorkbook())
                        {
                            wb.Worksheets.Add(dt, string.IsNullOrWhiteSpace(sheetName) ? "Sheet1" : sheetName);
                            MemoryStream stream = new MemoryStream();
                            wb.SaveAs(filename, false);
                        }
                    }
                    break;
                case 2:
                    {
                        string csvData = DataTableToCSV(dt, ',');
                        using (FileStream fs = File.Create(filename))
                        {
                            byte[] info = new UTF8Encoding(true).GetBytes(csvData);
                            fs.Write(info, 0, info.Length);
                        }
                    }
                    break;
            }            
        }

        public ReportResponseData GenerateReport(ReportRequestData item, string dirPath)
        {
            ReportResponseData result = new ReportResponseData();
            if (item == null) return result;

            result.reportType = item.reportType;
            if (result.reportType == 1 || result.reportType == 2)
            {
                try
                {
                    var data = GetReportData(item);
                    if (data == null || data.Columns.Count == 0)
                    {
                        result.msg = "No result";
                    }
                    var fileName = (Guid.NewGuid()).ToString() + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + item.deptId + (result.reportType == 1 ? ".xlsx" : ".csv");
                    GenerateExcelFromDataTable(item.deptId,data, Path.Combine(dirPath, fileName), result.reportType);
                    result.fileName = fileName;
                    result.success = true;
                }
                catch (Exception ex)
                {
                    result.success = false;
                    result.msg = ex.GetBaseException().Message;
                }
            }
            else
            {
                result.msg = "Invalid report type file format. Please select proper report type file format";
            }

            return result;

        }

        public DataTable GetReportData(ReportRequestData data)
        {
            FormsRepository formsRepository = new FormsRepository();
            DataTable dt = formsRepository.GetReportData(data.yearMonth, data.deptId, data.otherData);
            return dt;
        }
    }

    public class ReportRequestData
    {
        public int reportType { get; set; }
        public int yearMonth { get; set; }
        public string deptId { get; set; }
        public string otherData { get; set; }
    }

    public class ReportResponseData
    {
        public ReportResponseData()
        {
            msg = string.Empty;
            fileName = string.Empty;
        }
        public int reportType { get; set; }
        public bool success { get; set; }
        public string msg { get; set; }
        public string fileName { get; set; }
    }
}