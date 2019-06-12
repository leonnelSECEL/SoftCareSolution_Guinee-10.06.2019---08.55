using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("GROUPEMALADIE")]
    public class GROUPEMALADIE
    {
        public String GroupeMaladieID { get; set; }
        [Required]
        public String IntituleGroupe { get; set; }
        public DateTime DateCreation { get; set; }

        public Boolean IsDeleted { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public DateTime DateModification { get; set; }

    }
}