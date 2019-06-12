using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("EXAMENTYPE")]
    public class EXAMENTYPE
    {
        public String ExamenTypeID { get; set; }
        public String Libelle { get; set; }
        public String Description { get; set; }
        public decimal Prix { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}