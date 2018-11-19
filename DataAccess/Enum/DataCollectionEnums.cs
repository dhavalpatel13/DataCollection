using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
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
        DOFAPEER,
        TPDEPT,
        INFRA
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

}

public static class ExtenstionClass
{
    public static string GetStringValue(this Enum value)
    {
        Type type = value.GetType();
        FieldInfo fieldInfo = type.GetField(value.ToString());
        // Get the stringvalue attributes
        StringValueAttribute[] attribs = fieldInfo.GetCustomAttributes(
             typeof(StringValueAttribute), false) as StringValueAttribute[];
        // Return the first if there was a match.
        return attribs.Length > 0 ? attribs[0].StringValue : null;
    }
}