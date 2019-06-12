using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("STOCKTRANSFERT")]
    public class STOCKTRANSFERT
    {
        public String StockTransfertID { get; set; }
        public virtual STOCK StockTransfertFromID { get; set; }
        public virtual STOCK StockTransfertToID { get; set; }
        public String Reference { get; set; }
        public String Raison { get; set; }
        public String EstValide { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}