using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("EXAMENDETAILS")]
    public class EXAMENDETAILS
    {
        public String ExamenDetailsID { get; set; }
        public virtual EXAMEN Examen { get; set; }
        public virtual EXAMENMEDICAL ExamenMedical { get; set; }
        public DateTime DateCreation { get; set; }
        public String Description { get; set; }
        public Boolean EstNegatif { get; set; } 
}
}