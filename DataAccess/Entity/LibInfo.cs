using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Entity
{
    public class LibInfo : CommonProp
    {
        public int SubscJourDB { get; set;}
	    public int PrintedBooks { get; set;}
	    public int TotalCollection { get; set;}
	    public int FYAddition { get; set;}
	    public int LibMembers { get; set;}
	    public int LibSeatCap { get; set;}
	    public int SemWSOrg { get; set;}
	    public int BooksChMono { get; set;}
	    public int JourPapers { get; set;}
	    public int ConfSympWSPapers { get; set;}
	    public int SciTechReports { get; set;}
    }
}
