using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class ProduitVM3
    {
        public String ProduitID { get; set; }
        public String NomProduit { get; set; }
        public decimal PrixUnitaire { get; set; }
        public String ReferenceProduit { get; set; }
        public int Quantite { get; set; }
        public decimal PrixTotal { get; set; }
    }
}