using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("STOCKTRANSFERTDETAILS")]
    public class STOCKTRANSFERTDETAILS
    {
        public String StockTransfertDetailsID { get; set; }
        public virtual STOCKTRANSFERT StockTransfert { get; set; }
        public virtual PRODUIT Produit { get; set; }
        public int Quantite { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}