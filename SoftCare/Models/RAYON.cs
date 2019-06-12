using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("RAYON")]
    public class RAYON
    {
        public String RayonID { get; set; }
        public virtual STOCK Stock { get; set; }
        public String Code { get; set; }
        public String Nom { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}