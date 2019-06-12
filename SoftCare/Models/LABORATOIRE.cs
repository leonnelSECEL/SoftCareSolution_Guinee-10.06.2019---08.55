using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("LABORATOIRE")]
    public class LABORATOIRE
    {
        public String LaboratoireID { get; set; }
        public String Libelle { get; set; }
        public String Adresse { get; set; }
        public String Telephone { get; set; }
        public String Email { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}