using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("EXAMENRESULTAT")]
    public class EXAMENRESULTAT
    {
        public String ExamenResultatID { get; set; }
        public virtual EXAMEN Examen { get; set; }
        public String Description { get; set; }
        public DateTime DateResultat { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}