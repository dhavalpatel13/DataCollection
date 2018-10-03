using DataAccess.DBConnetion;
using DataAccess.Entity;
using DataAccess.Repository;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.SQLParamFinder
{
    public static class Extention
    {

        public static T GetEntity<T>(this RepositoryBase<T> repository, T entity, string sprocName)
        {
            try
            {
                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(entity, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                entity = EntityMapper.MapSingle<T>(command.ExecuteReader());
                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return entity;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        private static void DebugWriteLineExecutionTime(string sprocName, Stopwatch sw)
        {
            //Debug.WriteLine(String.Format("{0} took {1} milliseconds to finish.", sprocName, sw.ElapsedMilliseconds));
        }

        /// <summary>
        /// Converts the reader values to Datatable
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="repository"></param>
        /// <param name="entity"></param>
        /// <param name="sprocName"></param>
        /// <returns></returns>
        public static DataTable GetEntityCustom<T>(this RepositoryBase<T> repository, T entity, string sprocName)
        {
            try
            {
                // This method is added as part of ZCW-50257 AutoMapper issue
                DataTable dt = new DataTable();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(entity, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                dt.Load(command.ExecuteReader());
                DBConnectionHelper.CloseSqlConnection(conn);
                return dt;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="repository"></param>
        /// <param name="entity"></param>
        /// <param name="sprocName"></param>
        /// <returns></returns>
        public static T GetEntity<T>(this RepositoryBase<T> repository, Dictionary<string, object> sprocParametersList, string sprocName)
        {
            try
            {
                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                T entity = EntityMapper.MapSingle<T>(command.ExecuteReader());
                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return entity;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }
        /// <summary>
        /// Calls the sproc and maps the result sets to respective entities.
        /// </summary>
        /// <typeparam name="T1"></typeparam>
        /// <typeparam name="T2"></typeparam>
        /// <param name="repository"></param>
        /// <param name="sprocParametersList"></param>
        /// <param name="sprocName"></param>
        /// <param name="firstEntity"></param>
        /// <param name="secondEntity"></param>
        public static void GetEntitiesFromDataSet<T1, T2>(this RepositoryBase<T1> repository, Dictionary<string, object> sprocParametersList, string sprocName, ref T1 firstEntity, out T2 secondEntity)
        {
            try
            {
                Stopwatch sw = Stopwatch.StartNew();
                DataSet dataSet = new DataSet();
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                dataAdapter.SelectCommand = (SqlCommand)command;
                dataAdapter.Fill(dataSet);
                DBConnectionHelper.CloseSqlConnection(conn);
                firstEntity = (dataSet.Tables.Count > 0) ? EntityMapper.MapSingle<T1>(dataSet.Tables[0]) : default(T1);
                secondEntity = (dataSet.Tables.Count > 1) ? EntityMapper.MapSingle<T2>(dataSet.Tables[1]) : default(T2);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// Calls the sproc and maps the result sets to respective entities.
        /// </summary>
        /// <typeparam name="T1"></typeparam>
        /// <typeparam name="T2"></typeparam>
        /// <typeparam name="T3"></typeparam>
        /// <param name="repository"></param>
        /// <param name="sprocParametersList"></param>
        /// <param name="sprocName"></param>
        /// <param name="firstEntity"></param>
        /// <param name="secondEntity"></param>
        /// <param name="thirdEntity"></param>
        public static void GetEntitiesFromDataSet<T1, T2, T3>(this RepositoryBase<T1> repository, Dictionary<string, object> sprocParametersList, string sprocName, ref T1 firstEntity, out T2 secondEntity, out T3 thirdEntity)
        {
            try
            {
                Stopwatch sw = Stopwatch.StartNew();
                DataSet dataSet = new DataSet();
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                dataAdapter.SelectCommand = (SqlCommand)command;
                dataAdapter.Fill(dataSet);
                DBConnectionHelper.CloseSqlConnection(conn);
                firstEntity = (dataSet.Tables.Count > 0) ? EntityMapper.MapSingle<T1>(dataSet.Tables[0]) : default(T1);
                secondEntity = (dataSet.Tables.Count > 1) ? EntityMapper.MapSingle<T2>(dataSet.Tables[1]) : default(T2);
                thirdEntity = (dataSet.Tables.Count > 2) ? EntityMapper.MapSingle<T3>(dataSet.Tables[2]) : default(T3);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// Gets Entity collection
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="repository"></param>
        /// <param name="sprocName"></param>
        /// <returns></returns>
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
        // Supressing this as we pass sprocname from constant at all times
        public static List<T> GetEntityCollection<T>(this RepositoryBase<T> repository, string sprocName)
        {
            try
            {
                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = sprocName;
                command.CommandTimeout = IDbCommandExtensions.ZerochaosStandardTimeout;
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                List<T> entities = (List<T>)EntityMapper.MapCollection<T>(command.ExecuteReader());
                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return entities;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }
        /// <summary>
        /// Gets Entity collection
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="repository"></param>
        /// <param name="entity"></param>
        /// <param name="sprocName"></param>
        /// <returns></returns>
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
        // Supressing this as we pass sprocname from constant at all times
        public static List<T> GetEntityCollection<T>(this RepositoryBase<T> repository, T entity, string sprocName)
        {
            try
            {
                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command;
                if (entity != null)
                {
                    command = new SqlCommand().GetCommandWithParameters(entity, sprocName);
                }
                else
                {
                    command = new SqlCommand();
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = sprocName;
                }
                command.CommandTimeout = IDbCommandExtensions.ZerochaosStandardTimeout;
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                List<T> entities = (List<T>)EntityMapper.MapCollection<T>(command.ExecuteReader());
                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return entities;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="repository"></param>
        /// <param name="sprocParametersList"></param>
        /// <param name="sprocName"></param>
        /// <returns></returns>
        public static List<T> GetEntityCollection<T>(this RepositoryBase<T> repository, Dictionary<string, object> sprocParametersList, string sprocName)
        {
            try
            {
                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                List<T> entities = (List<T>)EntityMapper.MapCollection<T>(command.ExecuteReader());
                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return entities;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// Calls the sproc and maps the result sets to respective lists.
        /// </summary>
        /// <typeparam name="T1"></typeparam>
        /// <typeparam name="T2"></typeparam>
        /// <param name="repository"></param>
        /// <param name="sprocParametersList"></param>
        /// <param name="sprocName"></param>
        /// <param name="firstEntityCollection"></param>
        /// <param name="secondEntityCollection"></param>
        public static void GetEntityCollectionsFromDataSet<T1, T2>(this RepositoryBase<T1> repository, Dictionary<string, object> sprocParametersList, string sprocName, ref List<T1> firstEntityCollection, out List<T2> secondEntityCollection)
        {
            try
            {
                Stopwatch sw = Stopwatch.StartNew();
                DataSet dataSet = new DataSet();
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                dataAdapter.SelectCommand = (SqlCommand)command;
                dataAdapter.Fill(dataSet);
                DBConnectionHelper.CloseSqlConnection(conn);
                firstEntityCollection = (dataSet.Tables.Count > 0) ? (List<T1>)EntityMapper.MapCollection<T1>(dataSet.Tables[0]) : default(List<T1>);
                secondEntityCollection = (dataSet.Tables.Count > 1) ? (List<T2>)EntityMapper.MapCollection<T2>(dataSet.Tables[1]) : default(List<T2>);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
            }
            catch (SqlException ex)
            {
                throw;
            }
        }


        public static DataSet GetEntityDataSet<T1>(this RepositoryBase<T1> repository, Dictionary<string, object> sprocParametersList, string sprocName)
        {
            try
            {
                Stopwatch sw = Stopwatch.StartNew();
                DataSet dataSet = new DataSet();
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                dataAdapter.SelectCommand = (SqlCommand)command;
                dataAdapter.Fill(dataSet);
                DBConnectionHelper.CloseSqlConnection(conn);
                return dataSet;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// Calls the sproc and maps the result sets to respective lists.
        /// </summary>
        /// <typeparam name="T1"></typeparam>
        /// <typeparam name="T2"></typeparam>
        /// <typeparam name="T3"></typeparam>
        /// <param name="repository"></param>
        /// <param name="sprocParametersList"></param>
        /// <param name="sprocName"></param>
        /// <param name="firstEntityCollection"></param>
        /// <param name="secondEntityCollection"></param>
        /// <param name="thirdEntityCollection"></param>
        public static void GetEntityCollectionsFromDataSet<T1, T2, T3>(this RepositoryBase<T1> repository, Dictionary<string, object> sprocParametersList, string sprocName, ref List<T1> firstEntityCollection, out List<T2> secondEntityCollection, out List<T3> thirdEntityCollection)
        {
            try
            {
                Stopwatch sw = Stopwatch.StartNew();
                DataSet dataSet = new DataSet();
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                dataAdapter.SelectCommand = (SqlCommand)command;
                dataAdapter.Fill(dataSet);
                DBConnectionHelper.CloseSqlConnection(conn);
                firstEntityCollection = (dataSet.Tables.Count > 0) ? (List<T1>)EntityMapper.MapCollection<T1>(dataSet.Tables[0]) : default(List<T1>);
                secondEntityCollection = (dataSet.Tables.Count > 1) ? (List<T2>)EntityMapper.MapCollection<T2>(dataSet.Tables[1]) : default(List<T2>);
                thirdEntityCollection = (dataSet.Tables.Count > 2) ? (List<T3>)EntityMapper.MapCollection<T3>(dataSet.Tables[2]) : default(List<T3>);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        public static bool InsertOrUpdate<T>(this RepositoryBase<T> repository, T entity, string sprocName)
        {
            int isSuccess;
            try
            {
                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(entity, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                isSuccess = command.ExecuteNonQuery();
                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return isSuccess > 0;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        public static bool InsertOrUpdate<T>(this RepositoryBase<T> repository, Dictionary<string, object> dictionary, string sprocName)
        {
            int isSuccess;
            try
            {
                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(dictionary, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                isSuccess = command.ExecuteNonQuery();
                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return isSuccess > 0;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        public static int InsertAndGetEntityID<T>(this RepositoryBase<T> repository, T entity, string sprocName)
        {
            try
            {
                int entityID;
                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(entity, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                entityID = Convert.ToInt32(command.ExecuteScalar());
                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return entityID;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// Method to execute SP for saving entity and return generated ID from output parameter.
        /// </summary>
        /// <typeparam name="T">Generic type for Entity</typeparam>
        /// <param name="repository">Entity for repository of type RepositoryBase</param>
        /// <param name="entity">Generic Entity</param>
        /// <param name="sprocName">Stored Procedure name</param>
        /// <param name="outParamName">Optional output parameter name</param>
        /// <returns></returns>
        public static int InsertAndGetEntityIDByOutParam<T>(this RepositoryBase<T> repository, T entity, string sprocName, string outParamName = "@ID", bool convertMinDatesToNull = true)
        {
            try
            {
                int entityID = -1;
                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(entity, sprocName);
                if (convertMinDatesToNull)
                {
                    foreach (SqlParameter entityParameter in command.Parameters)
                    {
                        if (entityParameter.DbType == DbType.DateTime || entityParameter.DbType == DbType.DateTime2)
                        {
                            DateTime valueDate;
                            DateTime.TryParse((entityParameter.Value ?? string.Empty).ToString(), out valueDate);
                            if (valueDate.Equals(DateTime.MinValue))
                            {
                                entityParameter.Value = DBNull.Value;
                            }
                        }
                    }
                }

                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                command.ExecuteNonQuery();
                if (!string.IsNullOrWhiteSpace(outParamName))
                {
                    if (command.Parameters.Count > 0 && command.Parameters.Contains(outParamName))
                    {
                        SqlParameter entityParameter = (SqlParameter)command.Parameters[outParamName];
                        entityID = Convert.ToInt32(entityParameter.Value);
                    }
                }

                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return entityID;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        public static T InsertAndGetEntityWithID<T>(this RepositoryBase<T> repository, T entity, string sprocName)
        {
            try
            {
                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(entity, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                //entity.ID = Convert.ToInt32(command.ExecuteScalar());
                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return entity;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        public static T InsertAndGetEntityWithID<T>(this RepositoryBase<T> repository, T entity, Expression<Func<T, int>> primaryKeyField, string sprocName)
        {
            try
            {
                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(entity, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;

                var value = Convert.ToInt32(command.ExecuteScalar());
                var body = (MemberExpression)primaryKeyField.Body;
                var property = (PropertyInfo)body.Member;
                property.SetValue(entity, value, null);

                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return entity;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// Delete the entity.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="repository"></param>
        /// <param name="entity"></param>
        /// <param name="sprocName"></param>
        /// <returns></returns>
        public static bool DeleteEntity<T>(this RepositoryBase<T> repository, T entity, string sprocName, Dictionary<string, object> dictionary = null)
        {
            try
            {
                int isSuccess;
                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(entity, dictionary, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                isSuccess = command.ExecuteNonQuery();
                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return isSuccess > 0;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// Delete the entity.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="repository"></param>
        /// <param name="entity"></param>
        /// <param name="sprocName"></param>
        /// <returns>True if Success else False</returns>
        public static bool Delete<T>(this RepositoryBase<T> repository, T entity, string sprocName)
        {
            try
            {
                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(entity, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                command.ExecuteNonQuery();
                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return true;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// Delete the entity and returns -1 if entity is mapped.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="repository"></param>
        /// <param name="entity"></param>
        /// <param name="sprocName"></param>
        /// <returns>returns -1 if entity is mapped.</returns>
        public static int DeleteWithExist<T>(this RepositoryBase<T> repository, T entity, string sprocName)
        {
            try
            {
                int entityID;

                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(entity, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                entityID = Convert.ToInt32(command.ExecuteScalar());
                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return entityID;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// Gets back an single value from database.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="repository"></param>
        /// <param name="sprocParametersList"></param>
        /// <param name="sprocName"></param>
        /// <returns></returns>
        public static object GetScalarValue<T>(this RepositoryBase<T> repository, Dictionary<string, object> sprocParametersList, string sprocName)
        {
            try
            {
                object scalarObject = null;
                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                scalarObject = command.ExecuteScalar();
                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return scalarObject;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }
        /// <summary>
        /// Gets back an single value from database.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="repository"></param>
        /// <param name="sprocParametersList"></param>
        /// <param name="sprocName"></param>
        /// <returns></returns>
        public static object GetScalarValue<T>(this RepositoryBase<T> repository, T entity, string sprocName)
        {
            try
            {
                object scalarObject = null;
                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(entity, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                scalarObject = command.ExecuteScalar();
                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return scalarObject;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        public static bool BulkDBTransact<T>(this RepositoryBase<T> repository, Dictionary<string, object> sprocParametersList, string sprocName)
        {
            int isSuccess;
            try
            {
                Stopwatch sw = Stopwatch.StartNew();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                isSuccess = command.ExecuteNonQuery();
                DBConnectionHelper.CloseSqlConnection(conn);
                sw.Stop();
                DebugWriteLineExecutionTime(sprocName, sw);
                return isSuccess > 0;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }


        /// <summary>
        /// This Method will execute BulkInsert Queries and Returns the Identity values in a list of Integer.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="repository"></param>
        /// <param name="sprocParametersList"></param>
        /// <param name="sprocName"></param>
        /// <returns></returns>
        public static List<int> BulkDBTransactandGetMultipleID<T>(this RepositoryBase<T> repository, Dictionary<string, object> sprocParametersList, string sprocName)
        {
            try
            {
                DataTable dataTable = new DataTable();
                List<int> listIDs = new List<int>();
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                //TODO 
                dataAdapter.SelectCommand = (SqlCommand)command;
                dataAdapter.Fill(dataTable);
                DBConnectionHelper.CloseSqlConnection(conn);

                for (int i = 0; i <= dataTable.Rows.Count - 1; i++)
                {
                    listIDs.Add(Convert.ToInt32(dataTable.Rows[i][0]));
                }

                return listIDs;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// This methods will do batch insert/Update/delete operation.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="repository"></param>
        /// <param name="entity"></param>
        /// <param name="sprocName"></param>
        /// <param name="InserUpdateTable"></param>
        /// <returns></returns>
        public static int BatchInsertUpdateDelete<T>(this RepositoryBase<T> repository, T entity, string sprocName, DataTable InserUpdateTable)
        {
            try
            {
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                IDbCommand command = new SqlCommand().GetCommandWithParameters(entity, sprocName, true);
                command.UpdatedRowSource = UpdateRowSource.OutputParameters;
                command.Connection = conn;
                dataAdapter.InsertCommand = (SqlCommand)command;
                dataAdapter.UpdateBatchSize = InserUpdateTable.Rows.Count; // Specify the number of records to be Inserted/Updated in one go. Default is 1.
                int recordsupdated = dataAdapter.Update(InserUpdateTable);
                DBConnectionHelper.CloseSqlConnection(conn);
                return recordsupdated;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }


        /// <summary>
        /// This method will convert the single row to dictionary object when the number of columns returned is based on given parameters
        /// </summary>
        /// <typeparam name="T1"></typeparam>
        /// <param name="repository"></param>
        /// <param name="sprocParametersList"></param>
        /// <param name="sprocName"></param>
        /// <param name="dictionaryObject"></param>
        public static Dictionary<string, string> GetDictionariesFromDataSet<T1>(this RepositoryBase<T1> repository, Dictionary<string, object> sprocParametersList, string sprocName)
        {
            try
            {
                DataSet dataSet = new DataSet();
                Dictionary<string, string> dictionaryObject = new Dictionary<string, string>();
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                dataAdapter.SelectCommand = (SqlCommand)command;
                dataAdapter.Fill(dataSet);
                DBConnectionHelper.CloseSqlConnection(conn);
                if (dataSet.Tables.Count > 0 && dataSet.Tables[0].Rows.Count > 0)
                {
                    DataRow row = dataSet.Tables[0].Rows[0];
                    foreach (DataColumn column in row.Table.Columns)
                    {
                        dictionaryObject.Add(column.ColumnName, row[column].ToString());
                    }
                }
                return dictionaryObject;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// This method returns a list of dictionaries with emailTokens of different user types
        /// </summary>
        /// <typeparam name="T1"></typeparam>
        /// <param name="repository"></param>
        /// <param name="sprocParametersList"></param>
        /// <param name="sprocName"></param>
        /// <returns></returns>
        public static List<Dictionary<string, string>> GetListofDictionariesFromDataSet<T1>(this RepositoryBase<T1> repository, Dictionary<string, object> sprocParametersList, string sprocName)
        {
            try
            {
                DataSet dataSet = new DataSet();
                List<Dictionary<string, string>> resultList = new List<Dictionary<string, string>>();
                Dictionary<string, string> firstDictionaryObject = new Dictionary<string, string>();
                Dictionary<string, string> secondDictionaryObject = new Dictionary<string, string>();
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                dataAdapter.SelectCommand = (SqlCommand)command;
                dataAdapter.Fill(dataSet);
                DBConnectionHelper.CloseSqlConnection(conn);
                if (dataSet.Tables.Count > 0 && dataSet.Tables[0].Rows.Count > 0)
                {
                    DataRow row = dataSet.Tables[0].Rows[0];
                    foreach (DataColumn column in row.Table.Columns)
                    {
                        firstDictionaryObject.Add(column.ColumnName, row[column].ToString());
                    }
                }
                resultList.Add(firstDictionaryObject);
                if (dataSet.Tables.Count > 1 && dataSet.Tables[1].Rows.Count > 0)
                {
                    DataRow row = dataSet.Tables[1].Rows[0];
                    foreach (DataColumn column in row.Table.Columns)
                    {
                        secondDictionaryObject.Add(column.ColumnName, Convert.ToString(row[column]));
                    }
                    resultList.Add(secondDictionaryObject);
                }
                return resultList;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// This method returns a list of dictionaries with emailTokens
        /// </summary>
        /// <typeparam name="T1"></typeparam>
        /// <param name="repository"></param>
        /// <param name="sprocParametersList"></param>
        /// <param name="sprocName"></param>
        /// <returns></returns>
        public static List<Dictionary<string, string>> GetListofDictionariesFromDataSetMultipleRows<T1>(this RepositoryBase<T1> repository, Dictionary<string, object> sprocParametersList, string sprocName)
        {
            try
            {
                DataSet dataSet = new DataSet();
                List<Dictionary<string, string>> resultList = new List<Dictionary<string, string>>();
                Dictionary<string, string> firstDictionaryObject = null;

                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                dataAdapter.SelectCommand = (SqlCommand)command;
                dataAdapter.Fill(dataSet);
                DBConnectionHelper.CloseSqlConnection(conn);
                if (dataSet.Tables.Count > 0 && dataSet.Tables[0].Rows.Count > 0)
                {
                    for (int i = 0; i < dataSet.Tables[0].Rows.Count; i++)
                    {
                        firstDictionaryObject = new Dictionary<string, string>();
                        DataRow row = dataSet.Tables[0].Rows[i];
                        foreach (DataColumn column in row.Table.Columns)
                        {
                            firstDictionaryObject.Add(column.ColumnName, row[column].ToString());
                        }
                        resultList.Add(firstDictionaryObject);
                    }
                }
                return resultList;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        public static List<List<Dictionary<string, string>>> GetListofDictionariesFromDataTable<T1>(this RepositoryBase<T1> repository, Dictionary<string, object> sprocParametersList, string sprocName)
        {
            try
            {
                DataSet dataSet = new DataSet();
                DataTable dataTable = new DataTable();
                List<List<Dictionary<string, string>>> resultList = new List<List<Dictionary<string, string>>>();

                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                dataAdapter.SelectCommand = (SqlCommand)command;
                dataAdapter.Fill(dataSet);
                DBConnectionHelper.CloseSqlConnection(conn);

                if (dataSet.Tables.Count > 0)
                {
                    for (int i = 0; i <= dataSet.Tables.Count - 1; i++)
                    {
                        dataTable = dataSet.Tables[i];
                        List<Dictionary<string, string>> dataList = new List<Dictionary<string, string>>();
                        for (int j = 0; j <= dataTable.Rows.Count - 1; j++)
                        {
                            Dictionary<string, string> dictionaryObject = new Dictionary<string, string>();
                            DataRow row = dataTable.Rows[j];
                            foreach (DataColumn column in row.Table.Columns)
                            {
                                dictionaryObject.Add(column.ColumnName, row[column].ToString());
                            }
                            dataList.Add(dictionaryObject);
                        }
                        resultList.Add(dataList);
                    }
                }

                return resultList;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// This method returns a list of dictionaries with emailTokens of different user types
        /// </summary>
        /// <typeparam name="T1"></typeparam>
        /// <param name="repository"></param>
        /// <param name="sprocParametersList"></param>
        /// <param name="sprocName"></param>
        /// <returns></returns>
        public static List<Dictionary<string, string>> GetListofDictionaryFromSingleResultSet<T1>(this RepositoryBase<T1> repository, Dictionary<string, object> sprocParametersList, string sprocName)
        {
            try
            {
                DataSet dataSet = new DataSet();
                DataTable dataTable = new DataTable();
                List<Dictionary<string, string>> resultList = new List<Dictionary<string, string>>();

                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                dataAdapter.SelectCommand = (SqlCommand)command;
                dataAdapter.Fill(dataSet);
                DBConnectionHelper.CloseSqlConnection(conn);
                if (dataSet.Tables.Count > 0 && dataSet.Tables[0].Rows.Count > 0)
                {
                    dataTable = dataSet.Tables[0];
                    foreach (DataRow dataRow in dataTable.Rows)
                    {
                        Dictionary<string, string> dictionaryObject = new Dictionary<string, string>();

                        foreach (DataColumn column in dataTable.Columns)
                        {
                            dictionaryObject.Add(column.ColumnName, dataRow[column].ToString());
                        }
                        resultList.Add(dictionaryObject);
                    }
                }
                return resultList;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// Get Expense Menu Permissions for manager and supplier
        /// </summary>
        /// <param name="repository"></param>
        /// <param name="sprocParametersList"></param>
        /// <param name="sprocName"></param>
        /// <returns></returns>
        public static bool GetExpenseMenuPermissions<T>(this RepositoryBase<T> repository, T entity, string sprocName)
        {
            try
            {
                bool IsManagerAddExpense = false;
                var command = new SqlCommand().GetCommandWithParameters(entity, sprocName);
                var conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                IsManagerAddExpense = Convert.ToBoolean(command.ExecuteScalar());
                DBConnectionHelper.CloseSqlConnection(conn);

                return IsManagerAddExpense;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }
        public static DataTable GetValidBachNumbers<T>(this RepositoryBase<T> repository, Dictionary<string, object> sprocParametersList, string sprocName)
        {
            try
            {
                var dataSet = new DataSet();
                var dataAdapter = new SqlDataAdapter();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                dataAdapter.SelectCommand = (SqlCommand)command;
                dataAdapter.Fill(dataSet);
                //List<T> entities = (List<T>)EntityMapper.MapCollection<T>(command.ExecuteReader());
                DBConnectionHelper.CloseSqlConnection(conn);
                return dataSet.Tables[0];
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        /// <summary>
        /// Maps entity xml to Entity Object
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="repository"></param>
        /// <param name="entityXML"></param>
        /// <returns></returns>
        public static T GetEntityFromXML<T>(this RepositoryBase<T> repository, string entityXML)
        {
            DataSet ds = new DataSet();
            ds.ReadXml(new System.IO.StringReader(entityXML));
            IDataReader dr = ds.CreateDataReader();
            T entity = EntityMapper.MapSingle<T>(dr);
            return entity;
        }

        /// <summary>
        /// Generate SQL Command
        /// </summary>
        /// <param name="storedProcName"></param>
        /// <param name="sqlParameterList"></param>
        /// <returns></returns>
        public static SqlCommand BuildSqlCommand<T>(this RepositoryBase<T> repository, string storedProcName, List<SqlParameter> sqlParameterList)
        {
            SqlCommand command = new SqlCommand();
            command.CommandText = storedProcName;
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Connection = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString); ;

            foreach (SqlParameter item in sqlParameterList)
            {
                item.ParameterName = "@" + item.ParameterName;
                item.Direction = ParameterDirection.Input;
                command.Parameters.Add(item);
            }
            return command;
        }

        /// <summary>
        /// SQL Bulk Copy
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="repository">repository</param>
        /// <param name="dt">data table to insert records in db</param>
        /// <returns></returns>
        public static bool BulkSQLCopy<T>(this RepositoryBase<T> repository, DataTable dt)
        {
            try
            {
                using (SqlConnection dbConnection = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString))
                {
                    using (SqlBulkCopy s = new SqlBulkCopy(dbConnection))
                    {
                        s.DestinationTableName = dt.TableName;
                        foreach (var column in dt.Columns)
                        {
                            s.ColumnMappings.Add(column.ToString(), column.ToString());
                        }
                        s.WriteToServer(dt);
                    }
                }
                return true;
            }
            catch (SqlException ex)
            {
                throw;
            }

        }
        /// <summary>
        /// This method returns a list of dictionaries with emailTokens of different user types
        /// </summary>
        /// <typeparam name="T1"></typeparam>
        /// <param name="repository"></param>
        /// <param name="sprocParametersList"></param>
        /// <param name="sprocName"></param>
        /// <returns></returns>
        public static List<List<Dictionary<string, string>>> GetListofDictionaryAndReceptionListFromSingleResultSet<T1>(this RepositoryBase<T1> repository, Dictionary<string, object> sprocParametersList, string sprocName, string emailToken = "")
        {
            try
            {
                string[] emailTokenArray = null;

                if (!string.IsNullOrWhiteSpace(emailToken))
                {
                    emailTokenArray = emailToken.Split(';');
                }

                DataSet dataSet = new DataSet();
                DataTable dataTable = new DataTable();
                List<List<Dictionary<string, string>>> resultList = new List<List<Dictionary<string, string>>>();

                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sprocParametersList, sprocName);
                SqlConnection conn = DBConnectionHelper.OpenNewSqlConnection(repository.ConnectionString);
                command.Connection = conn;
                dataAdapter.SelectCommand = (SqlCommand)command;
                dataAdapter.Fill(dataSet);
                DBConnectionHelper.CloseSqlConnection(conn);

                if (dataSet.Tables.Count > 0)
                {
                    for (int i = 0; i <= dataSet.Tables.Count - 1; i++)
                    {
                        dataTable = dataSet.Tables[i];

                        var dataList = new List<Dictionary<string, string>>();

                        for (int j = 0; j <= dataTable.Rows.Count - 1; j++)
                        {
                            var dictionaryObject = new Dictionary<string, string>();
                            DataRow row = dataTable.Rows[j];

                            foreach (DataColumn column in row.Table.Columns)
                            {
                                dictionaryObject.Add(column.ColumnName, row[column].ToString());
                            }

                            dataList.Add(dictionaryObject);

                        }

                        resultList.Add(dataList);

                        dataList = new List<Dictionary<string, string>>();

                        for (int j = 0; j <= dataTable.Rows.Count - 1; j++)
                        {
                            var dictionaryObject = new Dictionary<string, string>();
                            DataRow row = dataTable.Rows[j];

                            foreach (DataColumn column in row.Table.Columns)
                            {

                                if (!column.ColumnName.Contains("##"))
                                {
                                    dictionaryObject.Add(column.ColumnName, row[column].ToString());
                                }

                                if (emailTokenArray != null && emailTokenArray.Where(c => c == column.ColumnName).Any())
                                {
                                    dictionaryObject.Add(column.ColumnName.TrimStart('#'), row[column].ToString());
                                }

                            }

                            dataList.Add(dictionaryObject);

                        }

                        resultList.Add(dataList);
                    }
                }

                return resultList;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }

        public static string GetStringValue(this System.Enum value)
        {
            // Get the type
            Type type = value.GetType();

            // Get fieldinfo for this type
            FieldInfo fieldInfo = type.GetField(value.ToString());

            // Get the stringvalue attributes
            StringValueAttribute[] attribs = fieldInfo.GetCustomAttributes(
                typeof(StringValueAttribute), false) as StringValueAttribute[];

            // Return the first if there was a match.
            return attribs.Length > 0 ? attribs[0].StringValue : null;
        }
    }
}
