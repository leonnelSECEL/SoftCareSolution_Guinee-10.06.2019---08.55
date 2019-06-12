using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("FACTUREDETAILS")]
    public class FACTUREDETAILS
    {
        public String FactureDetailsID { get; set; }
        public virtual FACTURE Facture { get; set; }
        public virtual PRODUIT Produit { get; set; }
        public int Quantite { get; set; }
        public decimal PrixUnitaire { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}