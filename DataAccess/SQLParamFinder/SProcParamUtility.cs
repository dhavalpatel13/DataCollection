using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace DataAccess.SQLParamFinder
{
    /// <summary>
    /// LOOK-INTO: Another approach for caching XMLDocument object
    /// </summary>
    public class SProcParamUtility
    {
        private static XDocument _SQLParameterXML;
        private static XDocument SQLParameterXML
        {
            get
            {
                if (_SQLParameterXML == null)
                {
                    _SQLParameterXML = GetSprocParamsXMLDocument();
                }
                return _SQLParameterXML;
            }
        }
        /// <summary>
        /// Gets the Stored Procedure parameters xml document
        /// </summary>
        /// <returns></returns>
        public static XDocument GetSprocParamsXMLDocument()
        {
            SProcParamUtility obj = new SProcParamUtility();
            return XDocument.Load(obj.GetResourceStream("SprocParameterMapper.xml"));
        }
        /// <summary>
        /// Gets the Stream for the given embeded resource file
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public Stream GetResourceStream(string filename)
        {
            Assembly assembly = Assembly.GetExecutingAssembly();
            return assembly.GetManifestResourceStream(this.GetType().Namespace + "." + filename);
            //return this.GetType().Assembly.GetManifestResourceStream("RepositoryWithMVC.SQLParamFinder.SprocParameterMapper.xml");
        }

        /// <summary>
        /// Adds sql parameters to IDbCommand for the given Stored Procedure
        /// </summary>
        /// <param name="cmd"></param>
        /// <param name="sprocName"></param>
        /// <param name="entity"></param>
        /// <param name="sqlParametersDictionary"></param>
        /// <returns></returns>
        public static IDbCommand GenerateSQLParams(IDbCommand cmd, string sprocName, object entity = null, Dictionary<string, object> sqlParametersDictionary = null, bool isBatchOperation = false)
        {
            bool requiresValue;
            string paramName;

            string directionString;
            string entityProperty;
            string sqlDBTypeString;
            int sqlDBType;
            int direction;
            string size = null;
            SqlParameter param;
            SqlDbType dbType;
            try
            {
                // get the parameter XML
                XDocument doc = SProcParamUtility.SQLParameterXML;

                // get the list of parameters defined for the given sproc
                var selectors = (from elements in doc.Elements("sprocs").Elements("sproc")
                                 where elements.Attribute("name").Value.ToLower() == sprocName.ToLower()
                                 select elements).FirstOrDefault();
                if (selectors != null)
                {


                    var list = selectors.Elements("param").ToList();

                    // for each paramenter, if the given object has a property use it
                    // otherwise check if the parameter has an alternate property defined in EntityProperty attribute
                    // If none of them are found then throw an exception
                    foreach (var item in list)
                    {
                        object paramValue = null;
                        paramName = item.Attribute("name") != null ? item.Attribute("name").Value : null;
                        if (string.IsNullOrEmpty(paramName))
                        {
                            throw new Exception("attribute name  is required.");
                        }

                        sqlDBTypeString = item.Attribute("SqlDbType") != null ? item.Attribute("SqlDbType").Value : null;
                        if (string.IsNullOrEmpty(sqlDBTypeString) || !Int32.TryParse(sqlDBTypeString, out sqlDBType))
                        {
                            throw new Exception("attribute SqlDbType is required or invalid.");
                        }

                        entityProperty = (item.Attribute("EntityProperty") != null && item.Attribute("EntityProperty").Value != "??") ? item.Attribute("EntityProperty").Value : paramName;
                        directionString = item.Attribute("direction") != null ? item.Attribute("direction").Value : null;
                        if (!Int32.TryParse(directionString, out direction))
                        {
                            direction = (int)ParameterDirection.Input;
                        }
                        size = item.Attribute("size") != null ? item.Attribute("size").Value : null;

                        PropertyInfo property = null;
                        if (entity != null)
                        {
                            property = entity.GetType().GetProperty(entityProperty);
                            if (property != null)
                            {
                                paramValue = property.GetValue(entity, null);
                            }
                        }
                        if (property == null && sqlParametersDictionary != null)
                        {
                            if (sqlParametersDictionary.ContainsKey(entityProperty))
                            {
                                paramValue = sqlParametersDictionary[entityProperty];
                            }
                        }

                        if (direction == (int)ParameterDirection.ReturnValue || direction == (int)ParameterDirection.Output)
                        {
                            requiresValue = false;
                        }
                        else
                        {
                            requiresValue = true;
                        }

                        if (requiresValue && paramValue == null)
                        {
                            //throw new Exception("Parameter " + paramName + " has no associated value.");
                            paramValue = DBNull.Value;
                        }
                        dbType = (SqlDbType)sqlDBType;
                        param = new SqlParameter("@" + paramName, dbType);
                        param.Direction = (ParameterDirection)direction;
                        if (requiresValue)
                        {
                            param.Value = paramValue;
                        }
                        if (!string.IsNullOrEmpty(size))
                        {
                            param.Size = Int32.Parse(size);
                        }

                        if (isBatchOperation && property != null)
                        {
                            param.SourceColumn = property.Name;
                        }
                        cmd.Parameters.Add(param);
                    }
                }
                return cmd;
            }
            catch (Exception ex)
            {
                throw new Exception("An error occured while generating sproc parameters", ex);
            }
            finally
            {
            }
        }
    }
}
