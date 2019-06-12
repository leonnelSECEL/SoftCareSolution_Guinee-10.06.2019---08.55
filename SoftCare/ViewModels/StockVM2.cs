using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class StockVM2
    {
        public String Id { get; set; }
        public String TypeStockId { get; set; }
        public String TypeStock { get; set; }

        [Display(Name = "Nom du Stock")]
        public String Nom { get; set; }

        [Display(Name = "Responsable de ce Stock")]
        public String ResponsableStock { get; set; }

        [Display(Name = "Est-ce le Stock Principal")]
        public Boolean IsStocktCentral { get; set; }
        public String IsStocktCentralString { get; set; }
        public DateTime DateCreation { get; set; }
    }
}