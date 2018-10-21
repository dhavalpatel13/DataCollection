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
        private static StringBuilder DataTableToCSV(DataTable datatable, char seperator, StringBuilder sb)
        {
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
            sb.AppendLine();
            sb.AppendLine();
            return sb;
        }

        public static void GenerateExcelFromDataTable(string sheetName,DataSet dataSet, string filename, int fileType)
        {
            switch (fileType)
            {
                case 1:
                    {
                        using (XLWorkbook wb = new XLWorkbook())
                        {
                            for (int i = 0; i < dataSet.Tables.Count; i++)
                            {
                                var sName = (string.IsNullOrWhiteSpace(sheetName) ? "Sheet" : sheetName) + (dataSet.Tables.Count > 1 ? (i + 1).ToString() : "");
                                wb.Worksheets.Add(dataSet.Tables[i], sName);
                            }

                            MemoryStream stream = new MemoryStream();
                            wb.SaveAs(filename, false);
                        }
                    }
                    break;
                case 2:
                    {
                        StringBuilder sb = new StringBuilder();
                        for (int i = 0; i < dataSet.Tables.Count; i++)
                        {
                            sb = DataTableToCSV(dataSet.Tables[i], ',', sb);
                        }

                        using (FileStream fs = File.Create(filename))
                        {
                            byte[] info = new UTF8Encoding(true).GetBytes(sb.ToString());
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
                    if (data == null || data.Tables.Count == 0)
                    {
                        result.msg = "No Data Available for Selected Report.";
                    }
                    else
                    {
                        var fileName = (Guid.NewGuid()).ToString() + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + item.menuId + (result.reportType == 1 ? ".xlsx" : ".csv");
                        GenerateExcelFromDataTable(item.menuId, data, Path.Combine(dirPath, fileName), result.reportType);
                        result.fileName = fileName;
                        result.success = true;
                    }
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

        public DataSet GetReportData(ReportRequestData data)
        {
            FormsRepository formsRepository = new FormsRepository();
            DataSet dataSet = formsRepository.GetReportData(data.yearMonth, data.menuId, data.deptId);
            return dataSet;
        }
    }

    public class ReportRequestData
    {
        public int reportType { get; set; }
        public int yearMonth { get; set; }
        public string menuId { get; set; }
        public string deptId { get; set; }
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