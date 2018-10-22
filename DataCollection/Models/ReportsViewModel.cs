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

        public static void GenerateExcelFromDataTable(string sheetName,DataSet dataSet, string filename, int fileType, string headerName)
        {
            switch (fileType)
            {
                case 1:
                    {
                        using (XLWorkbook wb = new XLWorkbook())
                        {
                            for (int i = 0; i < dataSet.Tables.Count; i++)
                            {
                                var dt = dataSet.Tables[i];
                                var sName = (string.IsNullOrWhiteSpace(sheetName) ? "Sheet" : sheetName) + (dataSet.Tables.Count > 1 ? (i + 1).ToString() : "");
                                var ws = wb.Worksheets.Add(sName);

                                ws.Cell(1, 1).Value = headerName;
                                var rng = ws.Range(1, 1, 1, dt.Columns.Count > 3 ? dt.Columns.Count : 3).Merge();
                                rng.Style.Font.SetBold(true);
                                ws.Cell(3, 1).InsertTable(dt);
                                ws.Columns().AdjustToContents();
                            }

                            MemoryStream stream = new MemoryStream();
                            wb.SaveAs(filename, false);
                        }
                    }
                    break;
                case 2:
                    {
                        StringBuilder sb = new StringBuilder();
                        sb.AppendLine(headerName);
                        sb.AppendLine();
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
                        var fileName = item.menuId + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + (result.reportType == 1 ? ".xlsx" : ".csv");
                        GenerateExcelFromDataTable(item.menuId, data, Path.Combine(dirPath, fileName), result.reportType, GetHeaderName(item.menuId));
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

        private string GetHeaderName(string menuId)
        {
            string title = string.Empty;
            switch (menuId)
            {
                case "ADIR":
                    title = "ADIR DATA PROFORMA FOR RANKING";
                    break;
                case "DOAA":
                    title = "DOAA DATA PROFORMA FOR RANKING";
                    break;
                case "DOFA":
                    title = "DOFA DATA PROFORMA FOR RANKING";
                    break;
                case "DOSW":
                    title = "DOSW DATA PROFORMA FOR RANKING";
                    break;
                case "LIBFORM":
                    title = "LIBRARY DATA PROFORMA FOR RANKING";
                    break;
                case "SRICFA":
                    title = "SRICFA (Funding Agency wise)";
                    break;
                case "SRIC":
                    title = "SRIC DATA PROFORMA FOR RANKING";
                    break;
            }
            return title;
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