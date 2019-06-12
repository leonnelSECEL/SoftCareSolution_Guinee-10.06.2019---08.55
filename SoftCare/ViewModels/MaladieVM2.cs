using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class MaladieVM2
    {
        public String Id { get; set; }
        public String NomMaladie { get; set; }
        [Required]
        public String GroupeMaladieID { get; set; }
    }
}