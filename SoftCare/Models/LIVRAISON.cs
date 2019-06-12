using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("LIVRAISON")]
    public class LIVRAISON
    {
        public String LivraisonID { get; set; }
        public virtual FOURNISSEUR Fournisseur { get; set; }
        public virtual DOSSIER Dossie { get; set; }
        public virtual STOCK Stock{ get; set; }
        public virtual FACTURE Facture { get; set; }
        public virtual UTILISATEUR Utilisateur { get; set; }
        public String Reference { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
        public Boolean EstValide { get; set; }
    }
}