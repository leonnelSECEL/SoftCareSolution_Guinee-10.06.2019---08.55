using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class FabricantVM
    {
        public String Id { get; set; }

        [Display(Name = "Nom du Fabricant")]
        public String Nom { get; set; }

        [Display(Name = "Description du Fabricant")]
        public String Description { get; set; }

        [Display(Name = "Adresse du Fabricant")]
        public String Adresse { get; set; }

        [Display(Name = "Contact du Fabricant")]
        public String Contact { get; set; }
    }
}