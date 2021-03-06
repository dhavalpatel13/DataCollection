﻿using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccess.SQLParamFinder;
using System.Data.SqlClient;
using DataAccess.DBConnetion;
using System.Data;

namespace DataAccess.Repository
{
    public class FormsRepository : RepositoryBase<stInfo>
    {        
        const string _SELECT_DOAA1_INFO = "DOAA1_INFO_SELECT_BY_DataCaptYM_DeptID_MenuID";
        const string _Insert_DOAA1_INFO = "DOAA1_INFO_INSERT";
        const string _Update_DOAA1_INFO = "DOAA1_INFO_UPDATE";
        const string _Insert_INFO2 = "stINFO2_INSERT";
        const string _Update_INFO2 = "stINFO2_UPDATE";
        const string _Insert_LIBINFO = "LIBINFO_INSERT";
        const string _Update_LIBINFO = "LIBINFO_UPDATE";
        const string _SELECT_DOFA_Data = "DOFA_DATA_SELECT_BY_DataCaptYM_DeptID_MenuID";
        const string _Bulk_Update_DOFA_Data = "Bulk_Update_DOFA_DATA_BY_DataCaptYM_DeptID_MenuID";
        const string _SELECT_SricFA_Data = "SricFA_DATA_SELECT_BY_DataCaptYM_DeptID";
        const string _Bulk_Update_SricFA_Data = "Bulk_Update_SricFA_DATA_BY_DataCaptYM_DeptID";
        const string _SELECT_SricDept_Data = "SRIC_DEPT_DATA_SELECT_BY_DataCaptYM";
        const string _Bulk_Update_SricDept_Data = "Bulk_Update_SRIC_DEPT_BY_DataCaptYM";
        const string _Rpt_SELECT_BY_DataCaptYM_DeptID = "Rpt_SELECT_BY_DataCaptYM_DeptID";
        const string _Bulk_Update_DofaPeer_Data = "Bulk_Update_DofaPeer_DATA_BY_DataCaptYM_DeptID";
        const string _SELECT_TPDept_Data = "TP_DEPT_DATA_SELECT_BY_DataCaptYM";
        const string _Bulk_Update_TPDept_Data = "Bulk_Update_TP_DEPT_BY_DataCaptYM";
        const string _SELECT_INFRA_Data = "INFRA_DATA_SELECT_BY_DataCaptYM";
        const string _Bulk_Update_INFRA_Data = "Bulk_Update_INFRA_BY_DataCaptYM";
        const string _SELECT_DFNP_Data = "DFNP_DATA_SELECT_BY_DataCaptYM";
        const string _Bulk_Update_DFNP_Data = "Bulk_Update_DFNP_BY_DataCaptYM";

        /// <summary>
        /// 
        /// </summary>
        /// <param name="DataCaptYM"></param>
        /// <param name="DeptID"></param>
        /// <param name="MenuID"></param>
        /// <returns></returns>
        public stInfo GetDOAA1FormDataByID(int DataCaptYM, string DeptID, string MenuID)
        {
            stInfo info = new stInfo();
            info.DataCaptYM = DataCaptYM;
            info.DeptID = DeptID;
            info.MenuID = string.IsNullOrWhiteSpace(MenuID) ? "DOAA" : MenuID;
            return this.GetEntity<stInfo>(info, _SELECT_DOAA1_INFO);
        }

        public List<DofaInfo> GetDOFAFormDataByID(int DataCaptYM, string DeptID, string empDept = "")
        {
            Dictionary<string, object> sqlParamDictionary = new Dictionary<string, object>();
            sqlParamDictionary.Add("DataCaptYM", DataCaptYM);
            sqlParamDictionary.Add("DeptID", DeptID);
            sqlParamDictionary.Add("empDept", empDept);
            IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParamDictionary, _SELECT_DOFA_Data);
            SqlConnection connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
            command.Connection = connection;
            List<DofaInfo> dofaInfos = EntityMapper.MapCollection<DofaInfo>(command.ExecuteReader()).ToList();
            DBConnectionHelper.CloseSqlConnection(connection);
            return dofaInfos;
        }

        public bool UpdateBulkDOFAFormData(DataTable data, int DataCaptYM, string DeptID, string empDept = "")
        {
            SqlConnection connection = null;
            try
            {
                Dictionary<string, object> sqlParamDictionary = new Dictionary<string, object>();
                sqlParamDictionary.Add("dofaData", data);
                sqlParamDictionary.Add("DataCaptYM", DataCaptYM);
                sqlParamDictionary.Add("DeptID", DeptID);
                sqlParamDictionary.Add("empDept", empDept);
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParamDictionary, _Bulk_Update_DOFA_Data);
                connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
                command.Connection = connection;
                int result = command.ExecuteNonQuery();
                if (result > 0)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                DBConnectionHelper.CloseSqlConnection(connection);
            }
        }

        public List<SricFA> GetSricFAFormDataByID(int DataCaptYM, string DeptID)
        {
            Dictionary<string, object> sqlParamDictionary = new Dictionary<string, object>();
            sqlParamDictionary.Add("DataCaptYM", DataCaptYM);
            sqlParamDictionary.Add("DeptID", DeptID);
            IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParamDictionary, _SELECT_SricFA_Data);
            SqlConnection connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
            command.Connection = connection;
            List<SricFA> sricFAs = EntityMapper.MapCollection<SricFA>(command.ExecuteReader()).ToList();
            DBConnectionHelper.CloseSqlConnection(connection);
            return sricFAs;
        }

        public bool UpdateBulkSricFAFormData(DataTable data, int DataCaptYM, string DeptID)
        {
            SqlConnection connection = null;
            try
            {
                Dictionary<string, object> sqlParamDictionary = new Dictionary<string, object>();
                sqlParamDictionary.Add("sricFaInfo", data);
                sqlParamDictionary.Add("DataCaptYM", DataCaptYM);
                sqlParamDictionary.Add("DeptID", DeptID);
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParamDictionary, _Bulk_Update_SricFA_Data);
                connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
                command.Connection = connection;
                int result = command.ExecuteNonQuery();
                if (result > 0)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                DBConnectionHelper.CloseSqlConnection(connection);
            }
        }

        public List<SricDept> GetSricDeptFormDataByID(int DataCaptYM)
        {
            Dictionary<string, object> sqlParamDictionary = new Dictionary<string, object>();
            sqlParamDictionary.Add("DataCaptYM", DataCaptYM);
            IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParamDictionary, _SELECT_SricDept_Data);
            SqlConnection connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
            command.Connection = connection;
            List<SricDept> sricDepts = EntityMapper.MapCollection<SricDept>(command.ExecuteReader()).ToList();
            DBConnectionHelper.CloseSqlConnection(connection);
            return sricDepts;
        }

        public bool UpdateBulkSricDeptFormData(DataTable data, int DataCaptYM)
        {
            SqlConnection connection = null;
            try
            {
                Dictionary<string, object> sqlParamDictionary = new Dictionary<string, object>();
                sqlParamDictionary.Add("sricDeptData", data);
                sqlParamDictionary.Add("DataCaptYM", DataCaptYM);
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParamDictionary, _Bulk_Update_SricDept_Data);
                connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
                command.Connection = connection;
                int result = command.ExecuteNonQuery();
                if (result > 0)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                DBConnectionHelper.CloseSqlConnection(connection);
            }
        }

        public bool UpdateBulkDofaPeerFormData(DataTable data, int DataCaptYM, string DeptID)
        {
            SqlConnection connection = null;
            try
            {
                Dictionary<string, object> sqlParamDictionary = new Dictionary<string, object>();
                sqlParamDictionary.Add("DofaPeerInfo", data);
                sqlParamDictionary.Add("DataCaptYM", DataCaptYM);
                sqlParamDictionary.Add("DeptID", DeptID);
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParamDictionary, _Bulk_Update_DofaPeer_Data);
                connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
                command.Connection = connection;
                int result = command.ExecuteNonQuery();
                if (result > 0)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                DBConnectionHelper.CloseSqlConnection(connection);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="info"></param>
        /// <returns></returns>
        public int Insert(stInfo info)
        {
            return this.InsertAndGetEntityID(info, _Insert_DOAA1_INFO);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="info"></param>
        /// <returns></returns>
        public bool Update(stInfo info)
        {
            return this.InsertOrUpdate(info, _Update_DOAA1_INFO);
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="DataCaptYM"></param>
        /// <param name="DeptID"></param>
        /// <param name="MenuID"></param>
        /// <returns></returns>
        public stInfo2 GetADIRFormDataByID(int DataCaptYM, string DeptID, string MenuID)
        {
            Dictionary<string, object> sqlParamDictionary = new Dictionary<string, object>();
            sqlParamDictionary.Add("DataCaptYM", DataCaptYM);
            sqlParamDictionary.Add("DeptID", DeptID);
            sqlParamDictionary.Add("MenuID", string.IsNullOrWhiteSpace(MenuID) ? "ADIR" : MenuID);
            IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParamDictionary, _SELECT_DOAA1_INFO);
            SqlConnection connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
            command.Connection = connection;
            stInfo2 stInfo2 = EntityMapper.MapSingle<stInfo2>(command.ExecuteReader());
            DBConnectionHelper.CloseSqlConnection(connection);
            return stInfo2;
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="info2"></param>
        /// <returns></returns>
        public bool InsertTostInfo2(stInfo2 info2)
        {
            IDbCommand command = new SqlCommand().GetCommandWithParameters(info2, _Insert_INFO2);
            SqlConnection connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);            
            command.Connection = connection;
            command.ExecuteNonQuery();
            DBConnectionHelper.CloseSqlConnection(connection);
            return true;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="info2"></param>
        /// <returns></returns>
        public bool UpdateTostInfo2(stInfo2 info2)
        {
            IDbCommand command = new SqlCommand().GetCommandWithParameters(info2, _Update_INFO2);
            SqlConnection connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
            command.Connection = connection;
            command.ExecuteNonQuery();
            DBConnectionHelper.CloseSqlConnection(connection);
            return true;            
        }

        public LibInfo GetLibFormDataByID(int DataCaptYM, string DeptID, string MenuID)
        {
            Dictionary<string, object> sqlParamDictionary = new Dictionary<string, object>();
            sqlParamDictionary.Add("DataCaptYM", DataCaptYM);
            sqlParamDictionary.Add("DeptID", DeptID);
            sqlParamDictionary.Add("MenuID", string.IsNullOrWhiteSpace(MenuID) ? "LIBFORM" : MenuID);
            IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParamDictionary, _SELECT_DOAA1_INFO);
            SqlConnection connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
            command.Connection = connection;
            LibInfo libInfo = EntityMapper.MapSingle<LibInfo>(command.ExecuteReader());
            DBConnectionHelper.CloseSqlConnection(connection);
            return libInfo;
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="info2"></param>
        /// <returns></returns>
        public bool InsertToLibInfo(LibInfo libInfo)
        {
            IDbCommand command = new SqlCommand().GetCommandWithParameters(libInfo, _Insert_LIBINFO);
            SqlConnection connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
            command.Connection = connection;
            command.ExecuteNonQuery();
            DBConnectionHelper.CloseSqlConnection(connection);
            return true;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="info2"></param>
        /// <returns></returns>
        public bool UpdateToLibInfo(LibInfo libInfo)
        {
            IDbCommand command = new SqlCommand().GetCommandWithParameters(libInfo, _Update_LIBINFO);
            SqlConnection connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
            command.Connection = connection;
            command.ExecuteNonQuery();
            DBConnectionHelper.CloseSqlConnection(connection);
            return true;
        }

        public DataSet GetReportData(int DataCaptYM, string MenuID, string DeptID = "")
        {
            Dictionary<string, object> sqlParamDictionary = new Dictionary<string, object>();
            sqlParamDictionary.Add("DataCaptYM", DataCaptYM);
            sqlParamDictionary.Add("MenuID", MenuID);
            sqlParamDictionary.Add("DeptID", DeptID);

            SqlDataAdapter dataAdapter = new SqlDataAdapter();
            IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParamDictionary, _Rpt_SELECT_BY_DataCaptYM_DeptID);
            SqlConnection sqlConnection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
            command.Connection = sqlConnection;
            dataAdapter.SelectCommand = (SqlCommand)command;
            DataSet dataSet = new DataSet();
            dataAdapter.Fill(dataSet);
            return dataSet;
        }

        public List<TPDept> GetTPDeptFormDataByID(int DataCaptYM)
        {
            Dictionary<string, object> sqlParamDictionary = new Dictionary<string, object>();
            sqlParamDictionary.Add("DataCaptYM", DataCaptYM);
            IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParamDictionary, _SELECT_TPDept_Data);
            SqlConnection connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
            command.Connection = connection;
            List<TPDept> tPDepts = EntityMapper.MapCollection<TPDept>(command.ExecuteReader()).ToList();
            DBConnectionHelper.CloseSqlConnection(connection);
            return tPDepts;
        }

        public bool UpdateBulkTPDeptFormData(DataTable data, int DataCaptYM)
        {
            SqlConnection connection = null;
            try
            {
                Dictionary<string, object> sqlParamDictionary = new Dictionary<string, object>();
                sqlParamDictionary.Add("TpDeptData", data);
                sqlParamDictionary.Add("DataCaptYM", DataCaptYM);
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParamDictionary, _Bulk_Update_TPDept_Data);
                connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
                command.Connection = connection;
                int result = command.ExecuteNonQuery();
                if (result > 0)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                DBConnectionHelper.CloseSqlConnection(connection);
            }
        }

        public Tuple<List<InfraDept>, List<InfraInfo>> GetInfraFormDataByID(int DataCaptYM, string DeptId)
        {
            Dictionary<string, object> sqlParamDictionary = new Dictionary<string, object>();
            sqlParamDictionary.Add("DataCaptYM", DataCaptYM);
            sqlParamDictionary.Add("DeptId", DeptId);
            SqlDataAdapter dataAdapter = new SqlDataAdapter();
            IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParamDictionary, _SELECT_INFRA_Data);
            SqlConnection connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
            command.Connection = connection;
            dataAdapter.SelectCommand = (SqlCommand)command;
            DataSet dataSet = new DataSet();
            dataAdapter.Fill(dataSet);
            DBConnectionHelper.CloseSqlConnection(connection);

            List<InfraDept> infraDepts = EntityMapper.MapCollection<InfraDept>(dataSet.Tables[0]).ToList();
            List<InfraInfo> infraInfos = EntityMapper.MapCollection<InfraInfo>(dataSet.Tables[1]).ToList();
            return new Tuple<List<InfraDept>, List<InfraInfo>>(infraDepts, infraInfos);
        }

        public bool UpdateBulkInfraFormData(DataTable infraDeptData, DataTable infraInfoData, int DataCaptYM, bool IsSaveInfraInfo)
        {
            SqlConnection connection = null;
            try
            {
                Dictionary<string, object> sqlParamDictionary = new Dictionary<string, object>();
                sqlParamDictionary.Add("InfraDeptData", infraDeptData);
                if (infraInfoData != null)
                {
                    sqlParamDictionary.Add("InfraInfoData", infraInfoData);
                }
                sqlParamDictionary.Add("DataCaptYM", DataCaptYM);
                sqlParamDictionary.Add("IsSaveInfraInfo", IsSaveInfraInfo);
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParamDictionary, _Bulk_Update_INFRA_Data);
                connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
                command.Connection = connection;
                int result = command.ExecuteNonQuery();
                if (result > 0)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                DBConnectionHelper.CloseSqlConnection(connection);
            }
        }

        public FinInfo GetDFNPDataByID(int DataCaptYM, string DeptId)
        {
            Dictionary<string, object> sqlParamDictionary = new Dictionary<string, object>();
            sqlParamDictionary.Add("DataCaptYM", DataCaptYM);
            sqlParamDictionary.Add("DeptID", DeptId);
            IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParamDictionary, _SELECT_DFNP_Data);
            SqlConnection connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
            command.Connection = connection;
            FinInfo finInfo = EntityMapper.MapSingle<FinInfo>(command.ExecuteReader());
            DBConnectionHelper.CloseSqlConnection(connection);
            return finInfo;
        }

        public bool UpdateBulkDFNPData(DataTable data, int DataCaptYM)
        {
            SqlConnection connection = null;
            try
            {
                Dictionary<string, object> sqlParamDictionary = new Dictionary<string, object>();

                data.Columns.Remove("EmpDept");
                sqlParamDictionary.Add("FinInfoData", data);
                sqlParamDictionary.Add("DataCaptYM", DataCaptYM);
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParamDictionary, _Bulk_Update_DFNP_Data);
                connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
                command.Connection = connection;
                int result = command.ExecuteNonQuery();
                if (result > 0)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                DBConnectionHelper.CloseSqlConnection(connection);
            }
        }
    }
}
