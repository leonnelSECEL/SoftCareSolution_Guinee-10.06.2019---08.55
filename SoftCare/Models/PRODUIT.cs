using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("PRODUIT")]
    public class PRODUIT
    {
        public String ProduitID { get; set; }
        public virtual STOCK Stock { get; set; }
        public virtual RAYON Rayon { get; set; }
        public virtual FABRICANT Fabricant { get; set; }
        public String Reference { get; set; }
        public String Nom { get; set; }
        public decimal PrixVente { get; set; }
        public decimal PrixAchat { get; set; }
        public String ReferenceExterne { get; set; }
        public String Description { get; set; }
        public Boolean EstCompte { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}