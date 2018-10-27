using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccess.SQLParamFinder;
using System.Data.SqlClient;
using System.Data;
using DataAccess.DBConnetion;

namespace DataAccess.Repository
{
    public class RankUserRepository : RepositoryBase<RankUser>
    {
        const string _Get_Login_User = "GET_LOGIN_USER";
        const string _Get_Current_User_Menu = "GET_CURRENT_USER_MENU";
        const string _Get_Rank_Info_Msg = "GET_RANK_INFO_MSG";
        const string _insert_Rank_User = "ADD_RANK_USER";
        const string _update_Rank_User = "UPDATE_RANK_USER";
        const string _check_user_is_exist_ByEmail = "CHECK_USER_EXIST_BY_EMAIL_EMPNO";
        const string _get_Table_Detail = "Get_Table_Detail";

        public RankUser GetLoginUser(string UserName, string Password)
        {
            RankUser rankUser = new RankUser();
            rankUser.UserName = UserName;
            rankUser.UserPassword = Password;
            return this.GetEntity<RankUser>(rankUser, _Get_Login_User);
        }

        public RankUser GetUserByEmail(string Email)
        {
            RankUser rankUser = new RankUser();
            rankUser.UserEmail = Email;
            return this.GetEntity<RankUser>(rankUser, _check_user_is_exist_ByEmail);
        }

        public List<RankUserMenu> GetCurrentUserMenuByUserId(string UserID)
        {
            SqlConnection connection = null;
            try
            {
                Dictionary<string, object> sqlParameterDictionary = new Dictionary<string, object>();
                sqlParameterDictionary.Add("UserID", UserID);
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParameterDictionary, _Get_Current_User_Menu);
                connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
                command.Connection = connection;
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                DataSet RankUserMenuDataset = new DataSet();
                dataAdapter.SelectCommand = (SqlCommand)command;
                dataAdapter.Fill(RankUserMenuDataset);
                List<RankUserMenu> rankUserMenu = EntityMapper.MapCollection<RankUserMenu>(RankUserMenuDataset.Tables[0]).ToList();
                return rankUserMenu;
            }
            finally
            {
                DBConnectionHelper.CloseSqlConnection(connection);
            }
        }

        public RankMesg GetRankMsg()
        {
            SqlConnection connection = null;
            try
            {
                Dictionary<string, object> sqlParameterDictionary = new Dictionary<string, object>();
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParameterDictionary, _Get_Rank_Info_Msg);
                connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
                command.Connection = connection;
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                DataSet RankMesgDataset = new DataSet();
                dataAdapter.SelectCommand = (SqlCommand)command;
                dataAdapter.Fill(RankMesgDataset);
                List<RankMesg> rankUserMenu1 = EntityMapper.MapCollection<RankMesg>(RankMesgDataset.Tables[0]).ToList();
                RankMesg rankMesg = rankUserMenu1.Count > 0 ? rankUserMenu1.FirstOrDefault() : new RankMesg();
                return rankMesg;
            }
            finally
            {
                DBConnectionHelper.CloseSqlConnection(connection);
            }
        }

        public bool AddRankUser(RankUser rankUser)
        {
            return this.InsertOrUpdate(rankUser, _insert_Rank_User);
        }

        public bool UpdateRankUser(RankUser rankUser)
        {
            return this.InsertOrUpdate(rankUser, _update_Rank_User);
        }

        public int CheckUserExistByEmailEmpNo(RankUser rankUser)
        {
            return Convert.ToInt32(this.GetScalarValue(rankUser, _check_user_is_exist_ByEmail));
        }

        public DataTable GetTableDetail(string TableName)
        {
            SqlConnection connection = null;
            try
            {
                Dictionary<string, object> sqlParameterDictionary = new Dictionary<string, object>();
                sqlParameterDictionary.Add("TableName", TableName);
                IDbCommand command = new SqlCommand().GetCommandWithParameters(sqlParameterDictionary, _get_Table_Detail);
                connection = DBConnectionHelper.OpenNewSqlConnection(this.ConnectionString);
                command.Connection = connection;
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                DataSet TableDetailDataset = new DataSet();
                dataAdapter.SelectCommand = (SqlCommand)command;
                dataAdapter.Fill(TableDetailDataset);
                return TableDetailDataset.Tables[0];
            }
            finally
            {
                DBConnectionHelper.CloseSqlConnection(connection);
            }
        }
    }
}
