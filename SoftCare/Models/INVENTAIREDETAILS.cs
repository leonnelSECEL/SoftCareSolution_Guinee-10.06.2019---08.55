using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("INVENTAIREDETAILS")]
    public class INVENTAIREDETAILS
    {
        public String InventaireDetailsID { get; set; }
        public virtual INVENTAIRE Inventaire { get; set; }
        public virtual PRODUIT Produit { get; set; }
        public int QuantiteLogic { get; set; }
        public int QuantiteReelle { get; set; }
        public float PrixAchat { get; set; }
        public float PrixVente { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}