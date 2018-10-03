using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace DataAccess.Repository
{
    public abstract class RepositoryBase<T> : IRepositoryBase<T>
    {
        public RepositoryBase()
        {
            ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        }


        private int _userPreferredLanguageID = 75;
        private int _userPreferredCNLanguageID = 9;
        private string _impersonatedByUser = null;
        public string ConnectionString { get; set; }

        //public abstract T GetByID(int id);

        public int UserPreferredLanguageID
        {
            get
            {
                return _userPreferredLanguageID;
            }
            set
            {
                _userPreferredLanguageID = value;
            }
        }

        public int UserPreferredCNLanguageID
        {
            get
            {
                return _userPreferredCNLanguageID;
            }
            set
            {
                _userPreferredCNLanguageID = value;
            }
        }

        public string ImpersonatedByUser
        {
            get
            {
                return _impersonatedByUser;
            }
            set
            {
                _impersonatedByUser = value;
            }
        }
    }
}
