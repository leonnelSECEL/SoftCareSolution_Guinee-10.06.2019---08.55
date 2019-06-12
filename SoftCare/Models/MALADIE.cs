using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("MALADIE")]
    public class MALADIE
    {
        public String MaladieID { get; set; }
        [Required]
        public String Intitule{ get; set; }
        public DateTime DateCreation { get; set; }
        public virtual GROUPEMALADIE TypeMaladie { get; set; }

        public Boolean IsDeleted { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public DateTime DateModification { get; set; }

    }
}