using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("RESULTAT")]
    public class RESULTAT
    {
        public String ResultatID { get; set; } 
        public virtual EXAMEN Examen { get; set; }
        public String Reference { get; set; }
        public String Description { get; set; }
        public DateTime DateCreation { get; set; }
    }
}