using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Enum
{
    public enum UserRoles
    {
        Admin,
        User
    }

    public enum Menu
    {   
        DOAA,        
        LIBFORM,
        ADIR,
        DOSW,
        SRIC,
        SRICFA,
        DOFA,
        USERS,
        DOFAPEER
    }

    public enum UserWork
    {
        Admin,
        DO,
        HOD,
        DSRIC,
        ADSRIC
    }

    public enum DataStatus : int
    {
        [StringValue("Data Entry Started by Operator")]
        DataEntryStartedbyOperator = 1,
        [StringValue("Data Entry Completed by Operator")]
        DataEntryCompletedbyOperator = 2,
        [StringValue("Data Checking by HOD")]
        DataCheckingbyHOD = 3,
        [StringValue("Data Checking Completed by HOD")]
        DataCheckingCompletedbyHOD = 4,
        [StringValue("Data Sent to Asso.DEAN")]
        DataSenttoAssoDEAN = 5,
        [StringValue("Data Checked by Asso.DEAN")]
        DataCheckedbyAssoDEAN = 6,
        [StringValue("Data Verified by DEAN")]
        DataVerifiedbyDEAN = 7,
        [StringValue("Reserved")]
        Reserved = 8,
        [StringValue("Data Locked")]
        DataLocked = 10
    }    

    //public enum Department : int
    //{
            //ASE = "Applied Science & Engineering",
            //ARCH = "Architecture & Planning",
            //BIO = "Biotechnology",
            //CHED = "Chemical Engineering",
            //CHY = "Chemistry",
            //CIVIL = "CIVIL ENGG",
            //CSE = "Computer Science & Engineering",
            //ESC = "Earth Sciences",
            //EQD = "Earthquake Engineering",
            //EED = "Electrical Engineering",
            //ECE = "Electronics & Communication Engineering",
            //HSS = "Humanities and Social Sciences",
            //HYD = "Hydrology",
            //MATHS = "Mathematics",
            //MIED = "Mechanical & Industrial Engineering",
            //MET = "Metallurgical & Materials Engineering",
            //PHY = "Physics",
            //PPE = "Polymar & Process Engineering",
            //PPT = "Pulp & Paper Technology",
            //WRDM = "Water Resources Development & Management",
            //CTS = "Center for Transportation Systems",
            //AHEC = "Alternate Hydro Energy Center",
            //CCE = "Centre for Continuing Education",
            //COEDMM = "Centre of Excellence in Disaster Mitigation & Management",
            //NANO = "Centre of Nanotechnology",
            //QIP = "Quality Improvement Program Centre",
            //ICC = "Institute Computer Center",
            //IIC = "Institute Instrumentation Centre",
            //DOMS = "Management Studies"
   // } 
}
