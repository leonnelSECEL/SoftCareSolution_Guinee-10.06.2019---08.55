using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace SoftCare.ViewModels
{
    public class ProduitVM
    {
        public String ProduitID { get; set; }
        public String StockID { get; set; }
        public String RayonID { get; set; }
        public String FabricantID { get; set; }
        public String Nom { get; set; }
        public String Reference { get; set; }
        [Display(Name = "Seuil D'allerte")]
        public int SeuilAlert { get; set; }
        [Display(Name = "Qantité en Stock")]
        public int QuantiteStock { get; set; }
        [Display(Name = "Prix de vente ")]
        public decimal PrixVente { get; set; }
        [Display(Name = "Prix D'achat")]
        public decimal PrixAchat { get; set; }
        [Display(Name = "Reférence externe")]
        public String ReferenceExterne { get; set; }
        [Display(Name = "Date D'expiration")]
        public DateTime DateExpiration { get; set; }
        public String Description { get; set; }

    }
}