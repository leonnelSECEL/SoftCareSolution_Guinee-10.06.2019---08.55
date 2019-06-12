using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("GROSSESSE")]
    public class GROSSESSE
    {
        public String GrossesseID { get; set; }
        public DateTime DateEnregistrement { get; set; }
        public DateTime DateResultat { get; set; }
        public int Resultat { get; set; }
        public virtual LIAISONDOSSIERGROUPECIBLE Maternite { get; set; }
        public virtual UTILISATEUR MedecinTraitant { get; set; }

        public Boolean IsDeleted { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public DateTime DateModification { get; set; }

    }
}