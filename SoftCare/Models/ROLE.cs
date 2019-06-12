using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("ROLE")]
    public class ROLE
    {
       public String RoleID { get; set; }
       public String Intitule { get; set; }
       public DateTime DateCreation { get; set; }
       public Boolean IsDeleted { get; set; }
       public DateTime DateSuppression { get; set; }
       public Boolean IsModified { get; set; }
       public DateTime DateModification { get; set; }
    }
}