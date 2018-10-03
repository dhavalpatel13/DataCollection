namespace DataAccess.Repository
{
    public interface IRepositoryBase<T>
    {
        string ConnectionString { get; set; }        
        int UserPreferredLanguageID { get; set; }
        int UserPreferredCNLanguageID { get; set; }
        string ImpersonatedByUser { get; set; }
    }
}
