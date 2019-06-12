using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("REGLEMENT")]
    public class REGLEMENT
    {
        public String ReglementID { get; set; }
        public virtual CAISSE Caisse { get; set; }
        public virtual FACTURE Facture { get; set; }
        public virtual MODEPAIEMENT ModePaiement { get; set; }
        public String Motif { get; set; }
        public String Reference { get; set; }
        public decimal MontantNet { get; set; }
        public decimal MontantRecu { get; set; }
        public decimal MontantRembourse { get; set; }
        public decimal MontantARembourse { get; set; }
        public decimal MontantRestant { get; set; }
        public Boolean EstLivre{ get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}