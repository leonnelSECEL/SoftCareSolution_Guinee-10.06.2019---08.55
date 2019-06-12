using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("INVENTAIRE")]
    public class INVENTAIRE
    {
        public String InventaireID { get; set; }
        public virtual STOCK Stock { get; set; }
        public String Reference { get; set; }
        public DateTime DateDebut { get; set; }
        public DateTime DateFin { get; set; }
        public String Commentaire { get; set; }
        public Boolean EstFini { get; set; }
        public Boolean EstValide { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}