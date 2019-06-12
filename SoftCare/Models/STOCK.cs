using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("STOCK")]
    public class STOCK
    {
        public String StockID { get; set; }
        public virtual UTILISATEUR Utilisateur { get; set; }
        public virtual STOCKTYPE StockType { get; set; } 
        public String Nom { get; set; }
        public Boolean IsStocktCentral { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}