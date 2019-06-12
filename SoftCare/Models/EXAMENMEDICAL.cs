using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("EXAMENMEDICAL")]
    public class EXAMENMEDICAL
    {
        public String ExamenMedicalId { get; set; } 
        public virtual EXAMENTYPE ExamenType { get; set; }  
        public String Code { get; set; }
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