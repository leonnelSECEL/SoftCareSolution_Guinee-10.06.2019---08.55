using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("STOCKMOUVEMENT")]
    public class STOCKMOUVEMENT
    {
        public String StockMouvementID { get; set; }
        public virtual STOCK Stock { get; set; }
        public String Reference { get; set; }
        public String Direction { get; set; }
        public String Raison { get; set; }
        public Boolean IsValidated { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}