using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class StockVM
    {
        public String Id { get; set; }

        [Display(Name = "Nom du Stock")]
        public String Nom { get; set; }

        [Display(Name = "Code du Stock")]
        public String Code { get; set; }

        [Display(Name = "Adresse Physique du Stock")]
        public String Adresse { get; set; }
    }
}