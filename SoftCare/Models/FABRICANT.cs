using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("FABRICANT")]
    public class FABRICANT
    {
        public String FabricantID { get; set; }
        public String Nom { get; set; }
        public String Description { get; set; }
        public String Adresse { get; set; }
        public String Contact { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}