using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class FournisseurVM
    {
        public String Id { get; set; }

        [Display(Name = "Nom du Fournisseur")]
        public String Nom { get; set; }

        [Display(Name = "Description du Fournisseur")]
        public String Description { get; set; }

        [Display(Name = "Adresse du Fournisseur")]
        public String Adresse { get; set; }

        [Display(Name = "Contact du Fournisseur")]
        public String Contact { get; set; }

        [Display(Name = "Contact du Fournisseur")]
        public String Telephone { get; set; }

        [Display(Name = "Fax du Fournisseur")]
        public String Fax { get; set; }

        [Display(Name = "Email du Fournisseur")]
        public String Email { get; set; }

        [Display(Name = "Fournisseur actif ?")]
        public Boolean EstActif { get; set; }

    }
}