using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("ACCES")]
    public class ACCES
    {
        public String AccesID { get; set; }
        public virtual ROLE Role { get; set; }
        public virtual PRIVILEGE Privilege { get; set; }
        public Boolean IsRemoved { get; set; }
        public DateTime DateRemoved { get; set; }
        public Boolean IsDeleted { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public DateTime DateModification { get; set; }

    }
}