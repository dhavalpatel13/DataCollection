using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DBConnetion
{
    class DBConnectionHelper
    {
        /// <summary>
        /// Instantiate and return open SqlConnection object
        /// </summary>
        /// <param name="strConn"></param>
        /// <returns></returns>
        public static SqlConnection OpenNewSqlConnection(string strConn)
        {
            SqlConnection objSqlConn = new SqlConnection(strConn);

            if (objSqlConn.State == ConnectionState.Closed)
            {
                objSqlConn.Open();
            }

            return objSqlConn;
        }

        /// <summary>
        /// Closes an open SqlConnection
        /// </summary>
        /// <param name="objConn">SqlConnection object to close</param>
        public static void CloseSqlConnection(SqlConnection objConn)
        {
            if (objConn == null)
            {
                return;
            }
            if (objConn.State == ConnectionState.Open)
            {
                objConn.Dispose();
            }
        }
    }
}
