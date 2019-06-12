using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SoftCare.Models
{
    [Table("STOCKTYPE")]
    public class STOCKTYPE
    {
        public String StockTypeID { get; set; }
        public String Nom { get; set; }
        public DateTime DateCreation { get; set; }
        public Boolean IsActif { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}