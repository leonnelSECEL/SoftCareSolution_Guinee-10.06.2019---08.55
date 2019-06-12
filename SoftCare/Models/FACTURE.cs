using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("FACTURE")]
    public class FACTURE
    {
        public String FactureID  { get; set; }        
        public virtual DOSSIER Dossier { get; set; }
        public virtual UTILISATEUR Utilisateur { get; set; }
        public String Reference { get; set; }
        //public decimal Montant { get; set; }
        public Boolean EstValide { get; set; }
        public Boolean EstPaye { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}