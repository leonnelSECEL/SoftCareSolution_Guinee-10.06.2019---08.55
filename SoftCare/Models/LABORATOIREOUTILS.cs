using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("LABORATOIREOUTILS")]
    public class LABORATOIREOUTILS
    {
        public String LaboratoireOutilsID { get; set; }
        public virtual LABORATOIRE Laboratoire { get; set; }
        public virtual RAYON Rayon { get; set; }
        public String Libelle { get; set; }
        public String Description { get; set; }
        public Boolean EstCompte { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}