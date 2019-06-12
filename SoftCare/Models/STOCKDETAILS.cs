using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("STOCKDETAILS")]
    public class STOCKDETAILS
    {
        public String StockDetailsID { get; set; }
        public virtual STOCK Stock { get; set; }
        public PRODUIT Produit { get; set; }
        public int StockQuantity { get; set; }
        public int StockAlert { get; set; }
        public DateTime DateExpiration { get; set; }  
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}