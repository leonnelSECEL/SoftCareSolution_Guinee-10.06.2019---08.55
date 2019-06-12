using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class FactureVM2
    {
        public String Id { get; set; }
        public String DossierID { get; set; }
        public String CaissierID { get; set; }
        public String RegrementId { get; set; }
        public String Patient { get; set; }
        public String CodeDossier { get; set; }
        public String Reference { get; set; }
        public decimal Montant { get; set; }
        public decimal Reste { get; set; }
        public String DateCreation { get; set; }
        public Boolean EstPaye { get; set; }
        public String Caissier { get; set; }
        public List<ProduitVM3> ListeProduits { get; set; }
    }
}