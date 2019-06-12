using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class RayonVM
    {
        public String Id { get; set; }
       
        [Display(Name = "Code du Rayon")]
        public String Code { get; set; }

        [Display(Name = "Nom du Rayon")]
        public String Nom { get; set; }

        [Display(Name = "Stock")]
        public String NomStock { get; set; }
    }
}