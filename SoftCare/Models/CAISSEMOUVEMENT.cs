using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("CAISSEMOUVEMENT")]
    public class CAISSEMOUVEMENT
    {
        public String CaisseMouvementID { get; set; }
        public virtual CAISSE Caisse { get; set; }
        public String Direction { get; set; }
        public String Reference { get; set; }
        public decimal Montant { get; set; }
        public String Raison { get; set; }
        public String Commentaire { get; set; }
        public Boolean EstValide { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}