using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class FactureVM
    {
        public String DossierID { get; set; }
        public String CaissierID { get; set; }
        public String Patient { get; set; }
        public String CodeDossier { get; set; }
        public String NomCaissier { get; set; }
        public int Quantite { get; set; }


        public List<ProduitVM> ListeProduits { get; set; }
    }
}