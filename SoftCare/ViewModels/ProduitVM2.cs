using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace SoftCare.ViewModels
{
    public class ProduitVM2
    {
        public String ProduitID { get; set; }
        [Display(Name = "Nom du Stock")]
        public String NomStock { get; set; }
        [Display(Name = "Nom du rayon")]
        public String NomRayon { get; set; }
        [Display(Name = "Seuil D'allerte")]
        public int SeuilAlert { get; set; }
        [Display(Name = "Nom du Produit")]
        public String NomProduit { get; set; }
        [Display(Name = "Prix de vente")]
        public decimal PrixVente { get; set; }
        [Display(Name = "Prix D'achat")]
        public decimal PrixAchat { get; set; }
        public String Description { get; set; }
        [Display(Name = "Nom du Fabricant")]
        public String NomFabricant { get; set; }
        [Display(Name = "Référence du Produit")]
        public String ReferenceProduit { get; set; }
        [Display(Name = "Reférence Externe")]
        public String ReferenceExterne { get; set; }
        [Display(Name = "Date D'expiration")]
        public DateTime DateExpiration { get; set; }
        [Display(Name = "Quantité en Stock")]
        public int QuantiteStock { get; set; }


        public List<ListePeremptionVM> Liste;

    }
}